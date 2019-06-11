import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/ui/components/large_two_part_header.dart';
import 'package:inkstep/utils/screen_navigator.dart';

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
        child: FloatingActionButton(
          child: Icon(Icons.clear),
          onPressed: () {
            final ScreenNavigator nav = sl.get<ScreenNavigator>();
            nav.pop(context);
          },
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
