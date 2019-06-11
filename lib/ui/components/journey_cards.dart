import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/ui/components/feature_discovery.dart';
import 'package:inkstep/ui/components/progress_indicator.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class AddCard extends StatelessWidget {
  const AddCard({@required this.userID, Key key}) : super(key: key);

  final int userID;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).backgroundColor;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            final nav = sl.get<ScreenNavigator>();
            nav.openArtistSelection(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 52.0,
                  color: textColor,
                ),
                Container(
                  height: 8.0,
                ),
                Text(
                  'Start a new journey',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class JourneyCard extends StatelessWidget {
  const JourneyCard({Key key, @required this.model, this.scale}) : super(key: key);

  final Future<CardModel> model;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CardModel>(
      future: model,
      builder: (BuildContext context, AsyncSnapshot<CardModel> snapshot) {
        Widget innerBody;
        if (snapshot.hasData && snapshot.data != null) {
          final card = snapshot.data;
          final Color accentColor =
              card.palette.vibrantColor?.color ?? Theme.of(context).accentColor;

          innerBody = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Chip(
                      label: Text(card.status.toString()),
                      //labelStyle: Theme.of(context).textTheme.subhead,
                      backgroundColor: accentColor,
                      elevation: 4,
                    ),
                    Spacer(),
                    DescribedIconButton(model: card),
                  ],
                ),
              ),
              ImageSnippet(
                images: card.images,
                axis: Axis.horizontal,
              ),
              Spacer(
                flex: 8,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Chip(
                  avatar: CircleAvatar(
                    backgroundImage: AssetImage('assets/ricky.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  label: Text(
                    card.artistName,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Text(
                  '${card.description}',
                  style: Theme.of(context).accentTextTheme.title.copyWith(
                        color: accentColor,
                      ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 32.0, bottom: 16.0),
                child: JourneyProgressIndicator(
                  color: accentColor,
                  progress: card.status.progress,
                  style: Theme.of(context).accentTextTheme.caption,
                ),
              ),
            ],
          );
        } else {
          innerBody = Center(
            child: CircularProgressIndicator(
              strokeWidth: 1.0,
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).backgroundColor),
            ),
          );
        }

        return GestureDetector(
            onTap: () {
              print('Existing card tapped');
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: innerBody,
            ));
      },
    );
  }
}

class ImageSnippet extends StatelessWidget {
  const ImageSnippet({
    Key key,
    @required this.images,
    @required this.axis,
  }) : super(key: key);

  final List<Image> images;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    final List<Image> imageSection = images.sublist(0, 2.clamp(0, images.length));
    final bool withOverlay = images.length > 3;
    final BoxDecoration overlay = withOverlay
        ? BoxDecoration(color: Theme.of(context).backgroundColor.withOpacity(0.5))
        : null;

    final List<Widget> children = <Widget>[
      for (Image img in imageSection)
        Expanded(
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

class DescribedIconButton extends StatelessWidget {
  const DescribedIconButton({
    Key key,
    @required this.model,
  }) : super(key: key);

  final CardModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: DescribedFeatureOverlay(
        featureId: model.aftercareID,
        icon: Icons.healing,
        color: Theme.of(context).accentColor,
        title: 'Aftercare Information',
        description: 'Tap the care icon to see your current aftercare information.',
        child: IconButton(
          icon: Icon(
            Icons.healing,
            color: Theme.of(context).backgroundColor,
            size: 20,
          ),
          onPressed: () {
            final ScreenNavigator nav = sl.get();
            nav.openAftercareScreen(context);
          },
        ),
      ),
    );
  }
}
