import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journey_bloc.dart';
import 'package:inkstep/blocs/journey_event.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/ui/components/availability_question.dart';
import 'package:inkstep/ui/components/deposit_question.dart';
import 'package:inkstep/ui/components/email_question.dart';
import 'package:inkstep/ui/components/inspiration_images_question.dart';
import 'package:inkstep/ui/components/location_question.dart';
import 'package:inkstep/ui/components/logo.dart';
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

  var formFields = ["name", "email", "mentalImage", "position", "size",
  "availability", "deposit", "email"];

  _NewScreenState() {
    for (var key in formFields) {
      formData.putIfAbsent(key, () => '');
    }
  }

  Map<String, String> formData = Map();

  final dynamic formKey = GlobalKey<FormState>();
  int get autoScrollDuration => 500;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBar(
            title: Hero(
              tag: 'logo',
              child: LogoWidget(),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            iconTheme: Theme.of(context).accentIconTheme,
          ),
          body: PageView(
            controller: controller,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              NameQuestion(
                controller: controller,
                func: (term) {
                  formData["name"] = term;
                },
                name: formData["name"],
              ),
              InspirationImagesQuestion(
                controller: controller,
              ),
              MentalImageQuestion(
                controller: controller,
                submitCallback: (term) {
                  formData["mentalImage"] = term;
                },
              ),
              PositionQuestion(
                controller: controller,
                submitCallback: (term) {
                  formData["position"] = term;
                },
              ),
              SizingQuestion(
                controller: controller,
                submitCallback: (term) {
                  formData["size"] = term;
                },
              ),
              AvailabilityQuestion(
                controller: controller,
                submitCallback: (term) {
                  formData["availability"] = term;
                },
              ),
              DepositQuestion(
                controller: controller,
                submitCallback: (term) {
                  formData["deposit"] = term;
                },
              ),
              EmailQuestion(
                controller: controller,
                submitCallback: (term) {
                  formData["email"] = term;
                },
              ),
              RaisedButton(
                onPressed: () {
                  bool missingParams = false;

                  String missing = "";

                  for (var key in formData.keys) {
                    if (formData[key] == '') {
                      missingParams = true;

                      if (missing == "") {
                        missing = key;
                      } else {
                        missing += ", " + key;
                      }
                    }
                  }

                  if (missingParams) {
                    final snackbar = SnackBar(
                      content: Text(
                        "You still need to provide us with " + missing,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      backgroundColor: Theme.of(context).backgroundColor,
                    );

                    _scaffoldKey.currentState.showSnackBar(snackbar);
                  } else {
                    final JourneyBloc journeyBloc =
                    BlocProvider.of<JourneyBloc>(context);
                    journeyBloc.dispatch(
                      AddJourney(
                        Journey(
                          // TODO(DJRHails): Don't hardcode these
                          artistName: 'Ricky',
                          studioName: 'South City Market',
                          name: formData["name"],
                          size: formData["size"],
                          email: formData["email"],
                          availability: formData["availability"],
                          deposit: formData["deposit"],
                          mentalImage: formData["mentalImage"],
                          position: formData["position"],
                        ),
                      ),
                    );
                    final ScreenNavigator nav = sl.get<ScreenNavigator>();
                    nav.openJourneyScreen(context);
                  }
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
