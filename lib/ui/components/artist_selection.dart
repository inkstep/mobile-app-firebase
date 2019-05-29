import 'package:flutter/material.dart';

class ArtistProfileRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 30.0,
          backgroundImage: AssetImage('assets/ricky.png'),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Ricky Williams',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('South City Market')
            ],
          ),
        )
      ],
    );
  }
}
