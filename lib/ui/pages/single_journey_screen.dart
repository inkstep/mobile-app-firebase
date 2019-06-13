import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/ui/components/large_two_part_header.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class DropdownFloatingActionButtons extends StatefulWidget {
  const DropdownFloatingActionButtons(
      {this.onPressed, this.tooltip, this.icon, @required this.bookedDate});

  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  final DateTime bookedDate;

  @override
  _DropdownFloatingActionButtonsState createState() =>
      _DropdownFloatingActionButtonsState(bookedDate);
}

class _DropdownFloatingActionButtonsState extends State<DropdownFloatingActionButtons>
    with SingleTickerProviderStateMixin {
  _DropdownFloatingActionButtonsState(this.bookedDate);

  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;

  final Curve _curve = Curves.easeOut;
  final DateTime bookedDate;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.white,
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
      end: 24,
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

  Widget image() {
    return Container(
      child: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.white,
        heroTag: 'aftercareBtn',
        onPressed: () {
          print('opening aftercare');
          final ScreenNavigator nav = sl.get<ScreenNavigator>();
          nav.openAftercareScreen(context, bookedDate);
        },
        tooltip: 'Image',
        child: Icon(Icons.healing),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        mini: true,
        heroTag: 'toggleBtn',
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: image(),
        ),
        toggle(),
      ],
    );
  }
}

class SingleJourneyScreen extends StatelessWidget {
  SingleJourneyScreen({Key key, @required this.card}) : super(key: key);

  final CardModel card;

  final List<Shadow> dropShadows = <Shadow>[
    Shadow(
      offset: Offset(1, 1),
      blurRadius: 6.0,
      color: Colors.black,
    ),
  ];

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
            DropdownFloatingActionButtons(bookedDate: card.bookedDate),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    final String artistFirstName = card.artistName.split(' ')[0];
    final double fullHeight = MediaQuery.of(context).size.height;
    return ListView(
      children: <Widget>[
        Container(
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
                            margin: EdgeInsets.all(4.0),
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
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
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
                Icon(
                  Icons.airline_seat_recline_extra,
                  size: 40.0,
                  color: Theme.of(context).accentIconTheme.color,
                ),
                Text(
                  'Size.',
                  style: Theme.of(context)
                      .accentTextTheme
                      .subtitle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
//                SizeSelector(
//                  controller: null,
//                  heightController: TextEditingController(text: '32'),
//                  widthController: TextEditingController(text: '29'),
//                ),
                Text(
                  'Avaliability.',
                  style: Theme.of(context)
                      .accentTextTheme
                      .subtitle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  'Price.',
                  style: Theme.of(context)
                      .accentTextTheme
                      .subtitle
                      .copyWith(fontWeight: FontWeight.w500),
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
