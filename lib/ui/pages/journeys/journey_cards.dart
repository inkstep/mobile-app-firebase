import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/card.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/theme.dart';
import 'package:inkstep/ui/components/alert_dialog.dart';
import 'package:inkstep/ui/pages/journeys/described_icon.dart';
import 'package:inkstep/ui/pages/journeys/image_snippet.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class JourneyCard extends StatelessWidget {
  const JourneyCard({
    Key key,
    @required this.card,
  }) : super(key: key);

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    // final Color accentColor = card.palette?.vibrantColor?.color ?? Theme.of(context).accentColor;
    final Color accentColor = Theme.of(context).accentColor;
    final bool showCare = card.journey.stage is BookedIn || card.journey.stage is Aftercare;
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      elevation: 10.0,
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              final ScreenNavigator nav = sl.get<ScreenNavigator>();
              nav.openFullscreenJourney(context, card);
            },
            splashColor: Colors.grey[50],
            highlightColor: Colors.grey[100],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          final Widget dialog = RoundedAlertDialog(
                            title: null,
                            child: card.journey.stage.buildStageWidget(context, card),
                            dismiss: card.journey.stage.buildDismissStageWidget(context, card),
                          );

                          if (dialog != null) {
                            showGeneralDialog<void>(
                              barrierColor: Colors.black.withOpacity(0.4),
                              transitionBuilder: (context, a1, a2, widget) {
                                return Transform.scale(
                                  scale: a1.value,
                                  child: Opacity(
                                    opacity: a1.value,
                                    child: dialog,
                                  ),
                                );
                              },
                              transitionDuration: Duration(milliseconds: 300),
                              barrierDismissible: true,
                              barrierLabel: '',
                              context: context,
                              // ignore: missing_return
                              pageBuilder: (context, animation1, animation2) {},
                            );
                          }
                        },
                        child: Chip(
                          avatar: card.journey.stage.userActionRequired ? Icon(Icons.error) : null,
                          label: Text(card.journey.stage.toString()),
                          backgroundColor: accentColor,
                          shape: RoundedRectangleBorder(borderRadius: smallBorderRadius),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('images')
                      .where('journeyId', isEqualTo: card.journey.id)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    /*if (snapshot.hasData && snapshot.data.documents.isNotEmpty) {
                      print('found ${snapshot.data.documents.length} images for journey: ${card.journey.id}');
                      snapshot.data.documents.forEach((doc) => print('${doc["url"]}'));
                      return ImageSnippet(
                        urls: snapshot.data.documents.map<String>((doc) => doc['url']).toList(),
                        axis: Axis.horizontal,
                      );
                    }*/
                    return ImageSnippet(
                      urls: const [
                        'https://firebasestorage.googleapis.com/v0/b/inkstep-2c4cc.appspot.com/o/KwmLEnTZpzO5RJkUxSH02Vn0NYv1%2Fsao2pFEwis3yucabvoYr%2F402445307rose1.png?alt=media&token=59122bdd-1269-4191-93c8-20b1d9ec8815',
                        'https://firebasestorage.googleapis.com/v0/b/inkstep-2c4cc.appspot.com/o/y6yDkDJ7LlcqV1DftVW8Oj0EZkn1%2F5ScBnDgPOBFCpIuEElDu%2F118011505IMG_0010.JPG?alt=media&token=04feef80-cc23-4f8e-b61d-12e43c14a074'
                      ],
                      axis: Axis.horizontal,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Text(
                    '${card.journey.description}',
                    style: Theme.of(context).accentTextTheme.title.copyWith(
                          color: accentColor,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Text(
                    'with',
                    style: Theme.of(context).accentTextTheme.subtitle,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 32.0),
                    child: Card(
                      color: Colors.black,
                      clipBehavior: Clip.antiAlias,
                      child: card.artist.profileImage,
                      shape: RoundedRectangleBorder(
                        borderRadius: smallBorderRadius,
                      ),
                      elevation: 1,
                      margin: EdgeInsets.all(10),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, bottom: 24.0),
                  child: Text(
                    card.artist.name.toUpperCase(),
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                DescribedIconButton(
                  icon: Icons.mail_outline,
                  featureId: card.messagesID,
                  onPressed: () {
                    final ScreenNavigator nav = sl.get<ScreenNavigator>();
                    nav.openJourneyMessagesScreen(context, card);
                  },
                ),
                if (showCare)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DescribedIconButton(
                      icon: Icons.healing,
                      featureId: card.aftercareID,
                      onPressed: () {
                        final ScreenNavigator nav = sl.get<ScreenNavigator>();
                        final JourneyStage stage = card.journey.stage;
                        nav.openCareScreen(
                            context, stage is JourneyStageWithBooking ? stage.date : null);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddCard extends StatelessWidget {
  const AddCard(this._onTap, {Key key}) : super(key: key);

  final Function _onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).backgroundColor;
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: smallBorderRadius,
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: _onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.add,
                    size: 52.0,
                    color: textColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Start a new journey',
                    style: Theme.of(context).textTheme.subtitle.copyWith(color: textColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
