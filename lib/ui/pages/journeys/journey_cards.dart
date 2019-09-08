import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/theme.dart';
import 'package:inkstep/ui/components/alert_dialog.dart';
import 'package:inkstep/ui/components/progress_indicator.dart';
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
    final bool showCare = card.stage is BookedIn || card.stage is Aftercare;
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
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
                            child: card.stage.buildStageWidget(context, card),
                            dismiss: card.stage.buildDismissStageWidget(context, card),
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
                          avatar: card.stage.userActionRequired ? Icon(Icons.error) : null,
                          label: Text(card.stage.toString()),
                          backgroundColor: accentColor,
                          shape: RoundedRectangleBorder(borderRadius: smallBorderRadius),
                        ),
                      ),
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
                      card.artist.name,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                  child: Text(
                    '${card.journey.mentalImage}',
                    style: Theme.of(context).accentTextTheme.title.copyWith(
                          color: accentColor,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 32.0, top: 16.0, bottom: 16.0),
                  child: JourneyProgressIndicator(
                    color: accentColor,
                    progress: card.stage.progress,
                    style: Theme.of(context).accentTextTheme.caption,
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
                         nav.openCareScreen(context, (card.stage as JourneyStageWithBooking).date);
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
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).backgroundColor;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Material(
        borderRadius: smallBorderRadius,
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
