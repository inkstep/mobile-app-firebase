import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/short_text_input.dart';
import 'package:inkstep/utils/screen_navigator.dart';

import '../../theme.dart';

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
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: appTheme.accentIconTheme,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
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
                    hint: 'e.g. Natasha',
                    label: 'What do your friends call you?',
                    callback: (_) {
                      final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
                      journeyBloc.dispatch(AddUser(name: nameController.text));

                      final ScreenNavigator nav = sl.get<ScreenNavigator>();
                      nav.openViewJourneysScreen(context);
                    }),
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
                  style: TextStyle(
                      fontSize: 20, fontFamily: 'Signika', color: Theme.of(context).primaryColor),
                ),
                color: Theme.of(context).cardColor,
              ),
              Spacer(),
            ],
          ),
        ));
  }
}
