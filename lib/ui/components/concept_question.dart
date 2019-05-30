import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inkstep/main.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../../main.dart';

class ConceptQ extends StatefulWidget {
  final PageController controller;
  final int autoScrollDuration;

  const ConceptQ({Key key, this.controller, this.autoScrollDuration}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _ConceptQState(controller, autoScrollDuration);
}

class _ConceptQState extends State<StatefulWidget> {
  final PageController controller;
  final int autoScrollDuration;

  List<Asset> images = <Asset>[];

  // ignore: unused_field
  String _error;

  _ConceptQState(this.controller, this.autoScrollDuration);

  Widget buildImageThumbnail(int i, double size) {
    Widget inner;
    if (i < images.length) {
      final Asset asset = images[i];
      inner = AssetThumb(
        asset: asset,
        width: size.round(),
        height: size.round(),
      );
    } else {
      inner = Icon(
        Icons.add,
        size: 60.0,
        color: baseColors['dark'],
      );
    }
    return Container(
      margin: EdgeInsets.all(8.0),
      width: size,
      height: size,
      child: InkWell(
        child: inner,
        onTap: updateAssets,
      ),
    );
  }

  Future<void> updateAssets() async {
    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 6, selectedAssets: images);
    } on PlatformException catch (e) {
      setState(() {
        _error = e.message;
      });
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double thumbSize = MediaQuery.of(context).size.width * 0.4;
    return Column(
      children: <Widget>[
        Text(
          "Let's get started!",
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: baseColors['dark']),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            "Choose some reference images, showing what you want. You'll get to talk about these later.",
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: baseColors['dark']),
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildImageThumbnail(0, thumbSize),
              buildImageThumbnail(1, thumbSize)
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildImageThumbnail(2, thumbSize),
              buildImageThumbnail(3, thumbSize)
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildImageThumbnail(4, thumbSize),
              buildImageThumbnail(5, thumbSize)
            ]),
        images.length > 1
            ? RaisedButton(
          child: Text('Ok?'),
          onPressed: () {
            controller.nextPage(
                duration: Duration(milliseconds: autoScrollDuration),
                curve: Curves.ease);
          },
        ) : Container(),
      ],
    );
  }
}
