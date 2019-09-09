import 'package:flutter/material.dart';

class ImageSnippet extends StatelessWidget {
  const ImageSnippet({
    Key key,
    @required this.urls,
    @required this.axis,
  }) : super(key: key);

  final List<String> urls;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    // TODO(mm): placeholder image and fade in
    final List<Image> images = urls.map((url) => Image.network(url)).toList();
    final List<Image> imageSection = images.sublist(0, 2.clamp(0, images.length));
    final bool withOverlay = images.length > 3;
    final BoxDecoration overlay = withOverlay
        ? BoxDecoration(color: Theme.of(context).backgroundColor.withOpacity(0.5))
        : null;

    final List<Widget> children = <Widget>[
      for (Image img in imageSection)
        Flexible(
          child: img,
        ),
      if (images.length > 2)
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                child: images[2],
                foregroundDecoration: overlay,
              ),
              if (withOverlay)
                Center(
                  child: Text(
                    '+${images.length - 2}',
                    textScaleFactor: 1.3,
                  ),
                ),
            ],
          ),
        )
    ];

    return axis == Axis.horizontal ? Row(children: children) : Column(children: children);
  }
}
