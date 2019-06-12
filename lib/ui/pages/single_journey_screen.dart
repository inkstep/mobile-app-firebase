import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/ui/components/large_two_part_header.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class DropdownFloatingActionButtons extends StatefulWidget {
  const DropdownFloatingActionButtons({this.onPressed, this.tooltip, this.icon});

  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  @override
  _DropdownFloatingActionButtonsState createState() => _DropdownFloatingActionButtonsState();
}

class _DropdownFloatingActionButtonsState extends State<DropdownFloatingActionButtons>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;

  final Curve _curve = Curves.easeOut;

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
          nav.openAftercareScreen(context);
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
  const SingleJourneyScreen({Key key, @required this.card}) : super(key: key);

  final CardModel card;

  Widget _backgroundImage(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Image.asset(
        'assets/bg2.jpg',
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
            DropdownFloatingActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    final String artistFirstName = card.artistName.split(' ')[0];
    return ListView(
      children: <Widget>[
        SizedBox(height: 200),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LargeTwoPartHeader(largeText: 'Your Journey with', name: artistFirstName),
        ),
        SizedBox(height: 20),
        Card(
          margin: EdgeInsets.only(),
          color: Colors.black,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  width: 80,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
              Text(card.description),
              Text(card.stage.toString()),
              Text(card.position.toString()),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[_backgroundImage(context), _content(), _topLayerButtons(context)],
      ),
    );
  }
}
