import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    @required this.images,
    @required this.updateCallback,
    @required this.submitCallback,
    this.updateAsset,
  });

  final List<Asset> images;
  final void Function(List<Asset>) updateCallback;
  final VoidCallback submitCallback;
  final Future<void> Function() updateAsset;

  List<Asset> get inspirationImages => images;

  set inspirationImages(List<Asset> inspirationImages) {
    updateCallback(inspirationImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Show us your inspiration',
          style: Theme.of(context).accentTextTheme.title,
        ),
        Spacer(),
        Expanded(
          child: AutoSizeText(
            "Choose some reference images, showing what you want. You'll get to talk about these later.",
            style: Theme.of(context).accentTextTheme.subhead,
            textAlign: TextAlign.center,
          ),
          flex: 10,
        ),
        Spacer(flex: 2),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraint) {
              const double thumbNoWidth = 2;
              const double thumbNoHeight = 3;
              const double thumbSizeFactor = 0.9;
              final double thumbHeight =
                  constraint.maxHeight * thumbSizeFactor * (1 / thumbNoHeight);
              final double thumbWidth = constraint.maxWidth * thumbSizeFactor * (1 / thumbNoWidth);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildImageThumbnail(context, 4, thumbSize),
                      _buildImageThumbnail(context, 5, thumbSize)
                    ],
                  ),
                ],
              );
            },
          ),
          flex: 60,
        ),
        inspirationImages.length > 1
            ? Expanded(
                child: Center(
                  child: RaisedButton(
                    child: Text('That enough?'),
                    onPressed: submitCallback,
                  ),
                ),
                flex: 10,
              )
            : Container(),
      ],
    );
  }

  Widget _buildImageThumbnail(BuildContext context, int i, double size) {
    Widget inner;
    if (i < inspirationImages.length) {
      final Asset asset = inspirationImages[i];
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
        color: Theme.of(context).accentIconTheme.color,
      );
    }
    return Container(
      width: size,
      height: size,
      child: InkWell(
        child: inner,
        onTap: updateAsset ?? _updateAssets,
      ),
    );
  }

  Future<void> _updateAssets() async {
    List<Asset> resultList;

    try {
      resultList =
          await MultiImagePicker.pickImages(maxImages: 6, selectedAssets: inspirationImages);
    } on PlatformException catch (e) {
      // TODO(DJRHails): Proper error handling to enduser
    }

    inspirationImages = resultList;
  }
}
