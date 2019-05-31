import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inkstep/main.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../../main.dart';

class InspirationImagesQuestion extends StatefulWidget {
  const InspirationImagesQuestion(
      {Key key, this.controller, this.autoScrollDuration})
      : super(key: key);

  final PageController controller;
  final int autoScrollDuration;

  @override
  State<StatefulWidget> createState() =>
      _InspirationImagesQuestionState(controller, autoScrollDuration);
}

class _InspirationImagesQuestionState extends State<StatefulWidget> {
  _InspirationImagesQuestionState(this.controller, this.autoScrollDuration);

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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Column(
            children: <Widget>[
              Text(
                'Show us your inspiration',
                style: Theme.of(context).accentTextTheme.title,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Choose some reference images, showing what you want. You'll get to talk about these later.",
                      style: Theme.of(context).accentTextTheme.subhead,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 26,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1,
                        child: buildImageThumbnail(0, thumbSize),
                      ),
                      AspectRatio(
                        aspectRatio: 1,
                        child: buildImageThumbnail(1, thumbSize),
                      ),
                    ]),
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1,
                        child: buildImageThumbnail(2, thumbSize),
                      ),
                      AspectRatio(
                        aspectRatio: 1,
                        child: buildImageThumbnail(3, thumbSize),
                      ),
                    ]),
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1,
                        child: buildImageThumbnail(4, thumbSize),
                      ),
                      AspectRatio(
                        aspectRatio: 1,
                        child: buildImageThumbnail(5, thumbSize),
                      ),
                    ]),
              ),
            ],
          ),
        ),
        Spacer(flex: 1),
        images.length > 1
            ? Expanded(
                flex: 2,
                child: RaisedButton(
                  child: Text('That enough?'),
                  onPressed: () {
                    controller.nextPage(
                        duration: Duration(milliseconds: autoScrollDuration),
                        curve: Curves.ease);
                  },
                ))
            : Container(),
        Spacer(flex: 1),
      ],
    );
  }
}
