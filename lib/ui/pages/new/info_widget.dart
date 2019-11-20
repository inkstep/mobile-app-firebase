import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/bold_call_to_action.dart';
import 'package:inkstep/ui/components/text_button.dart';
import 'package:inkstep/ui/pages/new/size_screen.dart';
import 'package:inkstep/utils/info_navigator.dart';
import 'package:inkstep/utils/screen_navigator.dart';

import 'help_screen.dart';

abstract class InfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int flexOfMain = isForm() ? 15 : 25;
    int flexOfButton = isForm() ? 1 : 3;
    if (this is SizeSelectorWidget) {
      flexOfMain = 140;
      flexOfButton = 20;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).accentIconTheme,
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            final ScreenNavigator nav = sl.get<ScreenNavigator>();
            nav.pop(context);
          },
          color: Colors.white,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info,
            ),
            color: Theme.of(context).cardColor,
            tooltip: 'Information',
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return HelpDialog(
                    navigator: getNavigator(),
                    help: getHelp(),
                  );
                },
              );
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                label: 'Back',
                onTap: () {
                  back(context);
                },
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: flexOfMain, child: getWidget(context)),
          if (shouldHaveNext()) Spacer(),
          if (shouldHaveNext())
            Expanded(
                flex: flexOfButton,
                child: valid()
                    ? BoldCallToAction(
                        label: 'Next',
                        color: Theme.of(context).cardColor,
                        onTap: () {
                          next(context);
                        },
                        textColor: Theme.of(context).primaryColor,
                      )
                    : Container()),
          if (shouldHaveNext()) setButtonHeight(context),
        ],
      ),
    );
  }

  List<String> getHelp();

  Widget setButtonHeight(BuildContext context) {
    return Spacer(
      flex: 1,
    );
  }

  Widget getWidget(BuildContext context);

  void submitCallback();

  InfoNavigator getNavigator();

  bool valid();

  bool isForm() => false;

  bool shouldHaveNext() => true;

  void next(BuildContext context) {
    if (valid()) {
      FocusScope.of(context).requestFocus(FocusNode());
      submitCallback();
      getNavigator().next(context, this);
    }
  }

  void back(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    submitCallback();
    getNavigator().back(context, this);
  }
}
