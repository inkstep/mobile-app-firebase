import 'dart:io';

import 'package:flutter/material.dart';

import 'form_element_builder.dart';

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
                style: Theme.of(context).accentTextTheme.subtitle,
              ),
              Text(
                studioName,
                style: Theme.of(context).accentTextTheme.subhead,
              )
            ],
          ),
        )
      ],
    );
  }
}

class ArtistSelectionTable extends StatelessWidget {
  ArtistSelectionTable({
    @required this.controller,
    @required this.label,
    this.onSubmitCallback,
    Key key,
  }) : super(key: key);

  final PageController controller;
  final String label;
  final void Function(String) onSubmitCallback;

  @override
  Widget build(BuildContext context) {
    return FormElementBuilder(
      builder: (context, focus, submitCallback) {
        return Column(
          children: <Widget>[
            Text(label, style: Theme.of(context).accentTextTheme.title),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ArtistProfileRow(
                    name: 'ricky',
                    studioName: 'scm',
                    imagePath: 'assets/ricky.png',
                  ),
                ],
              ),
            ),
          ],
        );
      },
      onSubmitCallback: onSubmitCallback ?? (_) {},
      controller: controller,
      fieldKey: key,
    );
  }
}
