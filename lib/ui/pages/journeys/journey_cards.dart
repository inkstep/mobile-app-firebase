import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/ui/components/progress_indicator.dart';
import 'package:inkstep/ui/pages/care/advice_snippet.dart';
import 'package:inkstep/ui/pages/journeys/described_icon.dart';
import 'package:inkstep/ui/pages/journeys/image_snippet.dart';
import 'package:inkstep/ui/pages/journeys/stage_dialogs.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class JourneyCard extends StatefulWidget {
  const JourneyCard({Key key, @required this.model}) : super(key: key);

  final Future<CardModel> model;

  @override
  _JourneyCardState createState() => _JourneyCardState();
}

class _JourneyCardState extends State<JourneyCard> with SingleTickerProviderStateMixin {
  Animation<double> loopedAnimation;
  AnimationController loopController;

  @override
  void initState() {
    super.initState();
    loopController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    loopedAnimation = CurvedAnimation(parent: loopController, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          loopController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          loopController.forward();
        }
        // Mark widget as dirty
        setState(() {});
      });
    loopController.forward();
  }

  @override
  void dispose() {
    loopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CardModel>(
      future: widget.model,
      builder: (BuildContext context, AsyncSnapshot<CardModel> snapshot) {
        return (snapshot.hasData && snapshot.data != null)
            ? LoadedJourneyCard(
                card: snapshot.data,
                animation: loopedAnimation,
                animationController: loopController,
              )
            : Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).backgroundColor),
                  ),
                ),
              );
      },
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

class LoadedJourneyCard extends AnimatedWidget {
  const LoadedJourneyCard({
    Key key,
    @required this.card,
    @required Animation<double> animation,
    @required this.animationController,
  }) : super(key: key, listenable: animation);

  final CardModel card;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final Color accentColor = card.palette.vibrantColor?.color ?? Theme.of(context).accentColor;

    bool showCare = false;

    if (card.stage is BookedIn || card.stage is Aftercare) {
      showCare = true;
    }

    final _elevationTween = Tween<double>(begin: card.stage.userActionRequired ? 0.95 : 1, end: 1);

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
                          artistName: card.artistName,
                          onAcceptance: () {
                            final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
                            journeyBloc.dispatch(QuoteAccepted(card.journeyId));
                            card.stage = AppointmentOfferReceived(card.bookedDate, card.quote);
                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
                            nav.pop(context);
                          },
                          onDenial: () {
                            final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
                            journeyBloc.dispatch(QuoteDenied(card.journeyId));
                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
                            nav.pop(context);
                          },
                        );
                      } else if (card.stage is AppointmentOfferReceived) {
                        dialog = DateDialog(
                          stage: card.stage,
                          artistName: card.artistName,
                          onAcceptance: () {
                            final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
                            journeyBloc.dispatch(DateAccepted(card.journeyId));
                            card.stage = BookedIn(card.bookedDate, card.quote);
                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
                            nav.pop(context);
                          },
                          onDenial: () {
                            final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
                            journeyBloc.dispatch(DateDenied(card.journeyId));
                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
                            nav.pop(context);
                          },
                        );
                      } else if (card.stage is Healed) {
                        dialog = PictureDialog(
                          onAcceptance: () async {
                            final File image = await ImagePicker.pickImage(
                                source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
                            final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
                            journeyBloc.dispatch(
                                SendPhoto(image, card.userId, card.artistId, card.journeyId));
                            card.stage = Finished();
                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
                            nav.pop(context);
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
                          pageBuilder: (context, animation1, animation2) {},
                        );
                      }
                    },
                    child: ScaleTransition(
                      scale: _elevationTween.animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval(
                            0,
                            1,
                            curve: Curves.decelerate,
                          ),
                        ),
                      ),
                      child: Chip(
                        avatar: card.stage.userActionRequired ? Icon(Icons.error) : null,
                        label: Text(card.stage.toString()),
                        backgroundColor: accentColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Spacer(),
                  showCare
                      ? DescribedIconButton(
                          icon: Icons.healing,
                          featureId: card.aftercareID,
                          onPressed: () {
                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
                            nav.openCareScreen(context, card.bookedDate);
                          },
                        )
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
