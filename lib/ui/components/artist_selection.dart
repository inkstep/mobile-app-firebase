import 'dart:io';

import 'package:flutter/material.dart';

class ArtistProfileRow extends StatelessWidget {
  ArtistProfileRow({
    @required this.imagePath,
    @required this.name,
    @required this.studioName,
    Key key,
  }) : super(key: key);

  final String imagePath;
  final String name;
  final String studioName;

  @override
  Widget build(BuildContext context) {
    AssetImage profileImage;
    final File profileFile = File(imagePath);
    if (profileFile.existsSync()) {
      profileImage = AssetImage(imagePath);
    } else {
      profileImage = AssetImage('assets/ricky.png');
    }
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 30.0,
          backgroundImage: profileImage,
          backgroundColor: Colors.transparent,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(studioName)
            ],
          ),
        )
      ],
    );
  }
}
