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

  final CardModel model;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final Color accentColor = model.palette.vibrantColor?.color ?? Theme.of(context).accentColor;
    return GestureDetector(
        onTap: () {
          print('Existing card tapped');
        },
        child: Transform.scale(
          scale: scale,
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Chip(
                        label: Text(model.status.toString()),
                        //labelStyle: Theme.of(context).textTheme.subhead,
                        backgroundColor: accentColor,
                        elevation: 4,
                      ),
                      Spacer(),
                      DescribedIconButton(model: model),
                    ],
                  ),
                  Spacer(),
                  if (model.images.isNotEmpty)
                    Text(
                      'Inspiration.',
                      style: Theme.of(context).accentTextTheme.subtitle,
                    ),
                  Row(
                    children: <Widget>[
                      for (Image i in model.images)
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: i,
                          ),
                        )
                    ],
                  ),
                  Spacer(
                    flex: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Chip(
                        avatar: CircleAvatar(
                          backgroundImage: AssetImage('assets/ricky.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        label: Text(
                          model.artistName,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 4.0),
                  Text(
                    '${model.description}',
                    style: Theme.of(context).accentTextTheme.title.copyWith(
                          color: accentColor,
                        ),
                  ),
                  Spacer(),
                  JourneyProgressIndicator(
                    color: accentColor,
                    progress: model.status.progress,
                    style: Theme.of(context).accentTextTheme.caption,
                  ),
                ],
              ),
            ),
          ),
        ));
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
