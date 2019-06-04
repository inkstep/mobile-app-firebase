import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class AddCard extends StatelessWidget {
  const AddCard({Key key}) : super(key: key);

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
  const JourneyCard({Key key, @required this.model}) : super(key: key);

  final Journey model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print('Existing card tapped');
        },
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(
                  flex: 8,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 4.0),
                  // TODO(DJRHails): Should be Hero-d
                  child: Text(
                    '${model.artistId.toString()}',
                    style: Theme.of(context).accentTextTheme.body1,
                  ),
                ),
                Container(
                  // TODO(DJRHails): Should be Hero-d
                  child: Text('${model.artistId.toString()}',
                      style: Theme.of(context).accentTextTheme.title),
                ),
                Spacer(),
              ],
            ),
          ),
        ));
  }
}
