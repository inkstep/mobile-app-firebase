import 'package:flutter/material.dart';

class StudioSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Studio'),
      ),
      body: Container(
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
                )),
            const SizedBox(
              height: 20,
            ),
            Text('Featured'),
            const SizedBox(
              height: 5,
            ),
            Text(
              'South City Market',
            ),
            const Divider(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: const <Widget>[
                  Text(
                    'Studio 1',
                  ),
                  Text(
                    'Studio 2',
                  ),
                  Text(
                    'Studio 3',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
