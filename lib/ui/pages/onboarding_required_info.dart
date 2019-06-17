import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/short_text_input.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class OnboardingRequiredInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OnboardingRequiredInfoState();
}

class OnboardingRequiredInfoState extends State<OnboardingRequiredInfo> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Spacer(),
              Flexible(
                flex: 3,
                child: ShortTextInput(
                    controller: nameController,
                    maxLength: 16,
                    capitalisation: TextCapitalization.words,
                    hint: 'Natasha',
                    label: 'What do your friends call you?',
                    callback: (_) => FocusScope.of(context).requestFocus(FocusNode())),
              ),
              Spacer(),
              RaisedButton(
                onPressed: () {
                  final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
                  journeyBloc.dispatch(AddUser(name: nameController.text));

                  final ScreenNavigator nav = sl.get<ScreenNavigator>();
                  nav.openViewJourneysScreen(context);
                },
                elevation: 15.0,
                padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                child: Text(
                  'Get Started!',
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Signika'),
                ),
              ),
              Spacer(),
            ],
          ),
        ));
  }
}
