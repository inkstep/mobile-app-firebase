import 'package:flutter/material.dart';
import 'package:inkstep/info_gathering.dart';

class JourneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const <Widget>[
          JourneyCard('Journey 1'),
          JourneyCard('Journey 2'),
          JourneyCard('Journey 3'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(builder: (context) => NewJourneyRoute()),
            );
          }
      ),
    );
  }
}

class JourneyCard extends StatelessWidget {
  const JourneyCard(this.text, {this.height=100});

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

class StudiosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(

        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
              obscureText: false,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              )
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Featured'),
          const SizedBox(
            height: 5,
          ),
          const JourneyCard('South City Market', height: 50,),
          const Divider(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: const <Widget>[
                JourneyCard('Studio 1', height: 50,),
                JourneyCard('Studio 2', height: 50,),
                JourneyCard('Studio 3', height: 50,),
              ],
            ),
          ),
        ],

      ),
    );
  }
}
