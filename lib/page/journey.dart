import 'package:flutter/material.dart';
import 'package:inkstep/page/info_gathering.dart';

class JourneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          JourneyCard("Journey 1"),
          JourneyCard("Journey 2"),
          JourneyCard("Journey 3"),
        ],
      ),*/
      body: LargeJourneyCard(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(builder: (context) => InfoScreen()),
            );
          }),
    );
  }
}

class JourneyCard extends StatelessWidget {
  JourneyCard(String this.text, {double this.height = 100});

  final String text;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          print('Card tapped');
        },
        child: Container(
          width: 300,
          height: height,
          child: Text(text),
        ),
      ),
    );
  }
}

class ArtistProfileRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 30.0,
          backgroundImage: AssetImage("assets/ricky.png"),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Ricky Williams",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("South City Market")
            ],
          ),
        )
      ],
    );
  }
}

class LargeJourneyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
      width: 100000,
      height: 100000,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              ArtistProfileRow(),
              Expanded(
                child: SizedBox(height: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
