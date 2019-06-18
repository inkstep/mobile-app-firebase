import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/alert_dialog.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/ui/components/short_text_input.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key key,
  }) : super(key: key);

  final TextEditingController textController = TextEditingController();
  final FocusNode focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: Theme.of(context).accentIconTheme,
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: FormElementBuilder(
        builder: (context, focus, submitCallback) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'What is your UserID?',
                style: Theme.of(context).accentTextTheme.headline,
                textScaleFactor: 0.8,
                textAlign: TextAlign.center,
              ),
              _buildNumberInputBox(textController),
              RaisedButton(
                onPressed: () {
                  final userId = int.tryParse(textController.text);
                  if (userId == null) {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return RoundedAlertDialog(
                            title: 'Enter a number',
                            child: Text(
                              'You haven\'t entered a number!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                          );
                          }
                        );
                      } else {
                    final ScreenNavigator nav = sl.get<ScreenNavigator>();
                    nav.openViewJourneysScreenWithNewDevice(context, userId);
                  }
                },
                elevation: 15.0,
                padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                child: Text(
                  'Next!',
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Signika'),
                ),
              ),
            ],
          );
        },
        onSubmitCallback: (_) {},
      ),
    );
  }

  Widget _buildNumberInputBox(TextEditingController textController) {
    return Container(
      width: 130.0,
      child: ShortTextInput(
        controller: textController,
        keyboardType: TextInputType.number,
        label: '',
        hint: '',
        maxLength: 3,
        capitalisation: TextCapitalization.words,
        callback: (_) {},
      ),
    );
  }
}
