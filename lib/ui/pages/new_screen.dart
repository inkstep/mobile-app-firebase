import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journey_bloc.dart';
import 'package:inkstep/blocs/journey_event.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/ui/components/logo.dart';
import 'package:inkstep/ui/components/availability_question.dart';
import 'package:inkstep/ui/components/deposit_question.dart';
import 'package:inkstep/ui/components/email_question.dart';
import 'package:inkstep/ui/components/inspiration_images_question.dart';
import 'package:inkstep/ui/components/location_question.dart';
import 'package:inkstep/ui/components/mental_image_question.dart';
import 'package:inkstep/ui/components/name_question.dart';
import 'package:inkstep/ui/components/sizing_question.dart';
import 'package:inkstep/utils/screen_navigator.dart';

import '../../main.dart';

class NewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final PageController controller = PageController(
    initialPage: 0,
  );

  String name, mentalImage, size, email, availability, deposit, position;
  final dynamic formKey = GlobalKey<FormState>();
  int get autoScrollDuration => 500;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBar(
            title: Hero(
              tag: 'logo',
              child: LogoWidget(),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            iconTheme: Theme.of(context)
                .iconTheme
                .copyWith(color: Theme.of(context).backgroundColor),
          ),
          body: PageView(
            controller: controller,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              NameQ(
                controller: controller,
                autoScrollDuration: autoScrollDuration,
                func: (term) {
                  name = term;
                },
              ),
              InspirationImagesQuestion(
                controller: controller,
                autoScrollDuration: autoScrollDuration,
              ),
              MentalImageQuestion(
                controller: controller,
                autoScrollDuration: autoScrollDuration,
                func: (term) {
                  mentalImage = term;
                },
              ),
              PositionQuestion(
                controller: controller,
                autoScrollDuration: autoScrollDuration,
                func: (term) {
                  position = term;
                },
              ),
              SizingQuestion(
                controller: controller,
                autoScrollDuration: autoScrollDuration,
                func: (term) {
                  size = term;
                },
              ),
              AvailabilityQuestion(
                controller: controller,
                autoScrollDuration: autoScrollDuration,
                func: (term) {
                  availability = term;
                },
              ),
              DepositQuestion(
                controller: controller,
                autoScrollDuration: autoScrollDuration,
                func: (term) {
                  deposit = term;
                },
              ),
              EmailQuestion(
                controller: controller,
                autoScrollDuration: autoScrollDuration,
                func: (term) {
                  email = term;
                },
              ),
              RaisedButton(
                onPressed: () {
                  final JourneyBloc journeyBloc =
                      BlocProvider.of<JourneyBloc>(context);
                  journeyBloc.dispatch(
                    AddJourney(
                      Journey(
                        // TODO(DJRHails): Don't hardcode these
                        artistName: 'Ricky',
                        studioName: 'South City Market',
                        name: name,
                        size: size,
                        email: email,
                        availability: availability,
                        deposit: deposit,
                        mentalImage: mentalImage,
                        position: position,
                      ),
                    ),
                  );
                  final ScreenNavigator nav = sl.get<ScreenNavigator>();
                  nav.openJourneyScreen(context);
                },
                elevation: 15.0,
                color: baseColors['dark'],
                textColor: baseColors['light'],
                padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Text(
                  "Let's contact your artist!",
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Signika'),
                ),
              )
            ],
          ),
        ));
  }
}
