import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
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
    this.doublePop = true,
  }) : super(key: key);

  final CardModel card;
  final bool doublePop;

  void _cancelJourney(BuildContext context) {
    final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
    journeyBloc.dispatch(RemoveJourney(card.journeyId));
    Navigator.pop(context);
    if (doublePop) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String header;
    String body;
    String confirmButtonText;
    switch (card.stage.runtimeType) {
      case WaitingForQuote:
        header = 'Are you sure you want to end your journey?';
        body = '${card.artistName.split(' ').first} will be '
            'notified that you do not want to proceed.';
        confirmButtonText = 'End Journey';
        break;
      case QuoteReceived:
        header = 'If you don\'t accept this quote, it will end your journey with this artist.';
        body = 'Think about a tattoo like a dentist\'s appointment, '
            'you don\'t haggle with your dentist. Even more importantly a tattoo is not something'
            ' to cheap out on.';
        confirmButtonText = 'End Journey';
        break;
      case WaitingForAppointmentOffer:
      case AppointmentOfferReceived:
        header = 'Are you sure you want to end your journey?';
        body = '${card.artistName.split(' ').first} will be '
            'notified that you do not want to proceed.';
        confirmButtonText = 'End Journey';
        break;
      case BookedIn:
        header = 'Are you sure you want to cancel your booking?';
        body = '${card.artistName.split(' ').first} will be notified and '
            'you will not get your deposit back.';
        confirmButtonText = 'Cancel Booking';
        break;
      case Aftercare:
        header = 'Are you sure you want to remove this journey?';
        body = 'You won\'t get to see personalised aftercare advice'
            'or be able to send a photo to your artist if you proceed.';
        confirmButtonText = 'Remove Journey';
        break;
      case Healed:
        header = 'Are you sure you want to remove this journey?';
        body = 'Please consider sending your artist a healed photo first!';
        confirmButtonText = 'Remove Journey';
        break;
      case Finished:
        header = 'It doesn\'t look like you\'ve got anything left to do.';
        body = 'Hope you enjoyed your tattoo journey';
        confirmButtonText = 'Remove Journey';
        break;
      case WaitingList:
        header = 'Are you sure you want to end your journey?';
        body = 'You won\'t get notified about any cancellation slots!';
        confirmButtonText = 'End Journey';
        break;
      default:
        throw Exception('Journey stage not supported');
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
            onPressed: () => _cancelJourney(context),
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

  FloatingActionButton _care(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: _disappearingBtnColour.value,
      heroTag: 'careBtn',
      onPressed: () {
        final ScreenNavigator nav = sl.get<ScreenNavigator>();
        nav.openCareScreen(context, widget.card.bookedDate);
      },
      tooltip: 'Care',
      child: Icon(Icons.healing),
    );
  }

  FloatingActionButton _delete(BuildContext context) {
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
          animatedDropDownFab(index: 0, fab: _care(context)),
          animatedDropDownFab(index: 1, fab: _delete(context)),

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
          animatedDropDownFab(index: 0, fab: _delete(context)),

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

class SingleJourneyScreen extends StatefulWidget {
  SingleJourneyScreen({Key key, @required this.card}) : super(key: key);

  final CardModel card;

  @override
  _SingleJourneyScreenState createState() => _SingleJourneyScreenState();
}

class _SingleJourneyScreenState extends State<SingleJourneyScreen> {
  String bgChoice;

  Widget _backgroundImage(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<String> backgroundPaths = [
      'assets/bg2.jpg',
      'assets/bg3.jpg',
      'assets/bg4.jpg',
      'assets/bg5.jpg',
    ];
    if (bgChoice == null) {
      setState(() {
        bgChoice = (backgroundPaths..shuffle()).first;
      });
    }
    return Center(
      child: Image.asset(
        bgChoice,
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
            DropdownFloatingActionButtons(card: widget.card),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    final String artistFirstName = widget.card.artistName.split(' ')[0];
    final double fullHeight = MediaQuery.of(context).size.height;
    final double fullWidth = MediaQuery.of(context).size.width;
    final bool hasQuote = widget.card.quote != null;
    final bool hasDate = widget.card.bookedDate != null;
    return ListView(
      children: <Widget>[
        Container(
          height: 0.8 * fullHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Transform.translate(
                    child: Container(
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
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                    offset: Offset(0, 20),
                  ),
                  if (hasDate)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Opacity(
                          opacity: 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DateBlock(
                              date: widget.card.bookedDate,
                              onlyDate: true,
                              scale: 1.75,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 800,
          child: Card(
            margin: EdgeInsets.zero,
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 0.2 * fullHeight,
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(widget.card.stage.icon,
                                color: Theme.of(context).accentTextTheme.subhead.color),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                '${widget.card.stage.toString()}',
                                style: Theme.of(context).accentTextTheme.subhead,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text('Description.',
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .accentTextTheme
                          .subtitle
                          .copyWith(fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 30.0),
                  child: Text(
                    widget.card.description,
                    style: Theme.of(context).accentTextTheme.subhead,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Placement.',
                    style: Theme.of(context)
                        .accentTextTheme
                        .subtitle
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 30.0),
                  child: Text(
                    widget.card.bodyLocation ?? 'N/A',
                    style: Theme.of(context).accentTextTheme.body1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Size.',
                    style: Theme.of(context)
                        .accentTextTheme
                        .subtitle
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 30.0),
                  child: Text(
                    widget.card.size ?? 'N/A',
                    style: Theme.of(context).accentTextTheme.body1,
                  ),
                ),
                if (hasQuote)
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Price.',
                          style: Theme.of(context)
                              .accentTextTheme
                              .subtitle
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, bottom: 30.0),
                        child: Text(
                          '£${widget.card.quote.start}-£${widget.card.quote.end}',
                          style: Theme.of(context).accentTextTheme.body1,
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: Text('Inspiration.',
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .accentTextTheme
                          .subtitle
                          .copyWith(fontWeight: FontWeight.w500)),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 30.0),
                    child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 4,
                      itemCount: widget.card.images.length,
                      itemBuilder: (BuildContext context, int index) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: widget.card.images[index].image,
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
