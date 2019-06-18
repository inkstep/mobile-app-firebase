import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/utils/info_navigator.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'info_widget.dart';

class ImageScreen extends StatefulWidget {
  ImageScreen({Key key, @required this.images, @required this.navigator, @required this.callback})
      : super(key: key);

  final List<Asset> images;
  final InfoNavigator navigator;
  final void Function(List<Asset>) callback;

  @override
  State<StatefulWidget> createState() => _ImageScreenState(images, navigator, callback);
}

class _ImageScreenState extends State<ImageScreen> {
  _ImageScreenState(this.inspirationImages, this.navigator, this.callback);

  List<Asset> inspirationImages;
  final InfoNavigator navigator;
  final void Function(List<Asset>) callback;

  @override
  Widget build(BuildContext context) {
    return ImageWidget(inspirationImages, (images) {
      setState(() {
        inspirationImages = images;
      });
    }, navigator, callback);
  }
}

class ImageWidget extends InfoWidget {
  ImageWidget(this.images, this.updateCallback, this.navigator, this.callback);

  final List<Asset> images;
  final void Function(List<Asset>) updateCallback;
  final InfoNavigator navigator;
  final void Function(List<Asset>) callback;

  List<Asset> get inspirationImages => images;

  set inspirationImages(List<Asset> inspirationImages) {
    updateCallback(inspirationImages);
  }

  @override
  Widget getWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Show us your inspiration',
            style: Theme.of(context).primaryTextTheme.headline,
            textScaleFactor: 0.8,
          ),
          Spacer(),
          Expanded(
            child: AutoSizeText(
              'Add some reference images to show your artist what you want.',
              style: Theme.of(context).primaryTextTheme.subhead,
              textAlign: TextAlign.center,
            ),
            flex: 10,
          ),
          Spacer(flex: 2),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraint) {
                const double thumbNoWidth = 2;
                const double thumbNoHeight = 2;
                const double thumbSizeFactor = 0.9;
                final double thumbHeight =
                    constraint.maxHeight * thumbSizeFactor * (1 / thumbNoHeight);
                final double thumbWidth =
                    constraint.maxWidth * thumbSizeFactor * (1 / thumbNoWidth);
                final double thumbSize = min(thumbHeight, thumbWidth);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildImageThumbnail(context, 0, thumbSize),
                        _buildImageThumbnail(context, 1, thumbSize)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildImageThumbnail(context, 2, thumbSize),
                        _buildImageThumbnail(context, 3, thumbSize)
                      ],
                    ),
                  ],
                );
              },
            ),
            flex: 60,
          ),
        ],
      ),
    );
  }

  Widget _buildImageThumbnail(BuildContext context, int i, double size) {
    Widget inner;
    if (i < inspirationImages.length) {
      final Asset asset = inspirationImages[i];
      print(asset.name);
      inner = Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 10,
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
        color: Theme.of(context).primaryIconTheme.color,
      );
    }

    return Container(
      width: size,
      height: size,
      child: InkWell(
        child: inner,
        onTap: _updateAssets,
      ),
    );
  }

  Future<void> _updateAssets() async {
    // TODO(DJRHails): Proper error handling to enduser
    inspirationImages = await MultiImagePicker.pickImages(
      maxImages: 4,
      selectedAssets: inspirationImages,
    );
  }

  @override
  InfoNavigator getNavigator() {
    return navigator;
  }

  @override
  void submitCallback() {
    callback(images);
  }

  @override
  bool valid() {
    return inspirationImages.isNotEmpty;
  }

  @override
  List<String> getHelp() {
    return <String>['Help!', 'Me!', 'Lorem ipsum stuff'];
  }
}
