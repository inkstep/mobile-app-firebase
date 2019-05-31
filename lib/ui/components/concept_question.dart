import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inkstep/main.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../../main.dart';

class ConceptQ extends StatefulWidget {
  const ConceptQ({Key key, this.controller, this.autoScrollDuration})
      : super(key: key);

  final PageController controller;
  final int autoScrollDuration;

  @override
  State<StatefulWidget> createState() =>
      _ConceptQState(controller, autoScrollDuration);
}

class _ConceptQState extends State<StatefulWidget> {
  _ConceptQState(this.controller, this.autoScrollDuration);

  final PageController controller;
  final int autoScrollDuration;

  List<Asset> images = <Asset>[];

  // ignore: unused_field
  String _error;

  Widget buildImageThumbnail(int i, double size) {
    Widget inner;
    if (i < images.length) {
      final Asset asset = images[i];
      inner = Container(
        decoration: BoxDecoration(
          border: Border.all(),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 3,
              offset: Offset(-1, 1),
            )
          ],
        ),
        child: AssetThumb(
          asset: asset,
          width: size.floor(),
          height: size.floor(),
        ),
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
    final double thumbSizeFactor = images.length > 1 ? 0.18 : 0.2;
    final double thumbSize =
        MediaQuery.of(context).size.height * thumbSizeFactor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Show us your inspiration',
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: baseColors['dark']),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: <Widget>[
                  Text(
                    "Choose some reference images, showing what you want. You'll get to talk about these later.",
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: baseColors['dark']),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
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
          ],
        ),
        images.length > 1
            ? RaisedButton(
                child: Text('That enough?'),
                onPressed: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: autoScrollDuration),
                      curve: Curves.ease);
                },
              )
            : Container(),
      ],
    );
  }
}
