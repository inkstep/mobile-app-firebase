import 'package:flutter/material.dart';
import 'journeys/journeys.dart';

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
                JourneyCard(
                  'Studio 1',
                  height: 50,
                ),
                JourneyCard(
                  'Studio 2',
                  height: 50,
                ),
                JourneyCard(
                  'Studio 3',
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
