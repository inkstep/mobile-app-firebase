import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/models/card_model.dart';

class JourneyMessagesScreen extends StatelessWidget {
  const JourneyMessagesScreen({Key key, @required this.card}) : super(key: key);

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.artist.name),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          card.stage.asMessage(),
        ],
      ),
    );
  }
}
