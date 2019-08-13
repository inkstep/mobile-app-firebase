import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/theme.dart';
import 'package:inkstep/ui/components/progress_indicator.dart';
import 'package:inkstep/ui/pages/journeys/described_icon.dart';
import 'package:inkstep/ui/pages/journeys/image_snippet.dart';
import 'package:inkstep/ui/pages/journeys/stage_dialogs.dart';
import 'package:inkstep/ui/pages/single_journey_screen.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class JourneyCard extends StatelessWidget {
  const JourneyCard({
    Key key,
    @required this.card,
  }) : super(key: key);

  final CardModel card;

  @override
  Widget build(BuildContext context) {
//    final Color accentColor = card.palette?.vibrantColor?.color ?? Theme.of(context).accentColor;
    final Color accentColor = Theme.of(context).accentColor;
    bool showCare = card.stage is BookedIn || card.stage is Aftercare;
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Widget dialog;
                      if (card.stage is QuoteReceived) {
                        dialog = QuoteDialog(
                          stage: card.stage,
                          artistName: card.artist.name,
                          onAcceptance: () {
                            // TODO(mm)
                            // final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
                            // journeyBloc.dispatch(QuoteAccepted(card.journey.id));
                            // card.stage = WaitingForAppointmentOffer(card.quote);
                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
                            nav.pop(context);
                          },
                          onDenial: () {
                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
                            nav.pop(context);
                            showDialog<dynamic>(
                              context: context,
                              builder: (BuildContext context) {
                                return DeleteJourneyDialog(
                                  card: card,
                                  doublePop: false,
                                );
                              },
                            );
                          },
                        );
                      } else if (card.stage is AppointmentOfferReceived) {
                        dialog = DateDialog(
                          stage: card.stage,
                          artistName: card.artist.name,
                          onAcceptance: () {
                            // TODO(mm)
//                            final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
//                            journeyBloc.dispatch(DateAccepted(card.journeyId));
//                            card.stage = BookedIn(card.bookedDate, card.quote);
//                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
//                            nav.pop(context);
                          },
                          onDenial: () {
                            // TODO(mm)
//                            final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
//                            journeyBloc.dispatch(DateDenied(card.journey.id));
//                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
//                            nav.pop(context);
                          },
                        );
                      } else if (card.stage is Healed) {
                        dialog = PictureDialog(
                          onAcceptance: () async {
                            // TODO(mm)
//                            final File image = await ImagePicker.pickImage(
//                                source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
//                            final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
//                            journeyBloc.dispatch(
//                                SendPhoto(image, card.userId, card.artistId, card.journeyId));
//                            card.stage = Finished();
//                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
//                            nav.pop(context);
                          },
                          onDenial: () {
                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
                            nav.pop(context);
                          },
                        );
                      }
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
                  Spacer(flex: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DescribedIconButton(
                      icon: Icons.mail_outline,
                      featureId: card.messagesID,
                      onPressed: () {
                        final ScreenNavigator nav = sl.get<ScreenNavigator>();
                        nav.openJourneyMessagesScreen(context, card);
                      },
                    ),
                  ),
                  showCare
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: DescribedIconButton(
                            icon: Icons.healing,
                            featureId: card.aftercareID,
                            onPressed: () {
                              // TODO(mm)
//                              final ScreenNavigator nav = sl.get<ScreenNavigator>();
//                              nav.openCareScreen(context, card.bookedDate);
                            },
                          ))
                      : Spacer(),
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
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 32.0, bottom: 16.0),
              child: JourneyProgressIndicator(
                color: accentColor,
                progress: card.stage.progress,
                style: Theme.of(context).accentTextTheme.caption,
              ),
            ),
          ],
        ),
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
