import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/models/card_model.dart';

class JourneyMessagesScreen extends StatelessWidget {
  JourneyMessagesScreen({Key key, @required this.card}) : super(key: key);

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(card.artistName), backgroundColor: Colors.black,),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Material(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.black,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Center(child: Text('message'))),
            ),
          ),
        ],
      ),
    );
  }
}
