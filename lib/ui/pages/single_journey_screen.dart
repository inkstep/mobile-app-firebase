import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/ui/components/alert_dialog.dart';
import 'package:inkstep/ui/components/date_block.dart';
import 'package:inkstep/ui/components/large_two_part_header.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class DeleteJourneyDialog extends StatelessWidget {
  const DeleteJourneyDialog({
    Key key,
    @required this.card,
    @required this.onAcceptance,
    @required this.onDenial,
  }) : super(key: key);

  final CardModel card;
  final VoidCallback onAcceptance;
  final VoidCallback onDenial;

  @override
  Widget build(BuildContext context) {
    String header;
    String body;
    String confirmButtonText;
    switch (card.stage.runtimeType) {
      case WaitingForQuote:
      case QuoteReceived:
      case WaitingForAppointmentOffer:
      case AppointmentOfferReceived:
        header = 'Are you sure you want to end your journey?';
        body = '${card.artistName.split(' ').first} will be notified that you do not want to proceed.';
        confirmButtonText = 'End Journey';
        break;
      case BookedIn:
        header = 'Are you sure you want to cancel your booking?';
        body = '${card.artistName.split(' ').first} will be notified and you will not get your deposit back.';
        confirmButtonText = 'Cancel Booking';
        break;
      case Aftercare:
        header = 'Are you sure you want to remove this journey?';
        body = 'You won\'t get to see personalised aftercare advice, or send a photo to your artist if you proceed.';
        confirmButtonText = 'Remove Journey';
        break;
      case Healed:
        header = 'Are you sure you want to remove this journey?';
        body = 'Please consider sending your artist a healed photo first!';
        confirmButtonText = 'Remove Journey';
        break;
      case Finished:
        header = 'Are you sure you want to remove this journey?';
        body = 'It doesn\'t look like you\'ve got anything left to do.';
        confirmButtonText = 'Remove Journey';
        break;
      default: throw Exception('Journey stage not supported');
    }

    return RoundedAlertDialog(
        title: header,
        child: Text(
          body,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle,
        ),
        dismiss: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: RaisedButton(
            color: Colors.white,
            onPressed: () {
              print('Confirm');
            },
            elevation: 15.0,
            padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              confirmButtonText,
              style: TextStyle(fontSize: 20.0, fontFamily: 'Signika').copyWith(color: Colors.red),
            ),
          ),
        ));
  }
}

class DropdownFloatingActionButtons extends StatefulWidget {
  const DropdownFloatingActionButtons({@required this.card});

  final CardModel card;

  @override
  _DropdownFloatingActionButtonsState createState() => _DropdownFloatingActionButtonsState();
}

class _DropdownFloatingActionButtonsState extends State<DropdownFloatingActionButtons>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _disappearingBtnColour;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  bool isOpened = false;
  int _numFabs;

  final Curve _curve = Curves.easeOut;
  final double _fabMiniHeight = 40;
  final int _fabSeparation = 8;

  @override
  void initState() {
    _numFabs = widget.card.bookedDate == null ? 2 : 3;

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });

    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _disappearingBtnColour = ColorTween(
      begin: Colors.transparent,
      end: Colors.white,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        1.0,
        curve: Curves.linear,
      ),
    ));

    _translateButton = Tween<double>(
      begin: 0,
      end: _fabMiniHeight + _fabSeparation,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    isOpened ? _animationController.reverse() : _animationController.forward();
    isOpened = !isOpened;
  }

  FloatingActionButton _toggle() {
    return FloatingActionButton(
      mini: true,
      heroTag: 'toggleBtn',
      backgroundColor: Colors.white,
      onPressed: animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  FloatingActionButton _aftercare() {
    return FloatingActionButton(
      mini: true,
      backgroundColor: _disappearingBtnColour.value,
      heroTag: 'aftercareBtn',
      onPressed: () {
        final ScreenNavigator nav = sl.get<ScreenNavigator>();
        nav.openAftercareScreen(context, widget.card.bookedDate);
      },
      tooltip: 'Aftercare',
      child: Icon(Icons.healing),
    );
  }

  FloatingActionButton _delete() {
    return FloatingActionButton(
      mini: true,
      backgroundColor: _disappearingBtnColour.value,
      heroTag: 'deleteBtn',
      onPressed: () {
        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return DeleteJourneyDialog(
              card: widget.card,
              onAcceptance: () {},
              onDenial: () {},
            );
          },
        );
      },
      tooltip: 'Delete',
      child: Icon(Icons.delete),
    );
  }

  Widget animatedDropDownFab({@required int index, @required FloatingActionButton fab}) {
    return Transform(
        transform: Matrix4.translationValues(
          0.0,
          (_translateButton.value * (index + 1)) - (index * (_fabMiniHeight + _fabSeparation)),
          0.0,
        ),
        child: fab);
  }

  @override
  Widget build(BuildContext context) {
    if (_numFabs == 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // The fabs to appear dropped down under the toggle when pressed
          animatedDropDownFab(index: 0, fab: _aftercare()),
          animatedDropDownFab(index: 1, fab: _delete()),

          // The toggle fab needs to be at the bottom of the column to hide other fabs when collapsed
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              -(_numFabs - 1) * (_fabSeparation + _fabMiniHeight) * 1.0,
              0.0,
            ),
            child: _toggle(),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // The fabs to appear dropped down under the toggle when pressed
          animatedDropDownFab(index: 0, fab: _delete()),

          // The toggle fab needs to be at the bottom of the column to hide other fabs when collapsed
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              -(_numFabs - 1) * (_fabSeparation + _fabMiniHeight) * 1.0,
              0.0,
            ),
            child: _toggle(),
          ),
        ],
      );
    }
  }
}

class SingleJourneyScreen extends StatelessWidget {
  SingleJourneyScreen({Key key, @required this.card}) : super(key: key);

  final CardModel card;

  Widget _backgroundImage(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<String> backgroundPaths = [
      'assets/bg2.jpg',
      'assets/bg3.jpg',
      'assets/bg4.jpg',
      'assets/bg5.jpg',
    ];
    return Center(
      child: Image.asset(
        (backgroundPaths..shuffle()).first,
        width: size.width,
        height: size.height,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _topLayerButtons(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'dismissBtn',
              mini: true,
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_downward),
              onPressed: () {
                final ScreenNavigator nav = sl.get<ScreenNavigator>();
                nav.pop(context);
              },
            ),
            Spacer(),
            DropdownFloatingActionButtons(card: card),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    final String artistFirstName = card.artistName.split(' ')[0];
    final double fullHeight = MediaQuery.of(context).size.height;
    final double fullWidth = MediaQuery.of(context).size.width;
    final bool hasDate = card.bookedDate != null;
    return ListView(
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            if (hasDate)
              Row(
                children: <Widget>[
                  Spacer(),
                  Opacity(
                    opacity: 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DateBlock(
                        date: card.bookedDate,
                        onlyDate: true,
                        scale: 1.75,
                      ),
                    ),
                  ),
                ],
              ),
            Container(
              width: fullWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // Where the linear gradient begins and ends
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  stops: const [0.1, 0.5],
                  colors: const [Colors.black54, Colors.transparent],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: fullHeight * 0.65),
                  LargeTwoPartHeader(largeText: 'Your Journey with', name: artistFirstName),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 800,
          child: Card(
            margin: EdgeInsets.zero,
            color: Theme.of(context).cardColor,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Container(
                    width: 80,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    card.description,
                    style: Theme.of(context).accentTextTheme.subhead,
                  ),
                ),
                Text(
                  'Inspiration.',
                  style: Theme.of(context)
                      .accentTextTheme
                      .subtitle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 4,
                      itemCount: card.images.length,
                      itemBuilder: (BuildContext context, int index) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: card.images[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              transform: Matrix4.translationValues(10, 10, 10),
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text('${index + 1}'),
                              ),
                            ),
                          ),
                      staggeredTileBuilder: (int index) =>
                          StaggeredTile.count(2, index.isEven ? 2 : 1),
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                    ),
                  ),
                ),
                Text(
                  'Placement.',
                  style: Theme.of(context)
                      .accentTextTheme
                      .subtitle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  card.bodyLocation ?? 'N/A',
                  style: Theme.of(context).accentTextTheme.body1,
                ),
                Text(
                  'Size.',
                  style: Theme.of(context)
                      .accentTextTheme
                      .subtitle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  card.size ?? 'N/A',
                  style: Theme.of(context).accentTextTheme.body1,
                ),
                Text(
                  'Price.',
                  style: Theme.of(context)
                      .accentTextTheme
                      .subtitle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  '£XXX',
                  style: Theme.of(context).accentTextTheme.body1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _backgroundImage(context),
          _content(context),
          _topLayerButtons(context),
        ],
      ),
    );
  }
}
