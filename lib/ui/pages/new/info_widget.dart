import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/bold_call_to_action.dart';
import 'package:inkstep/utils/info_navigator.dart';

import 'help_screen.dart';

abstract class InfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).accentIconTheme,
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
          IconButton(
              icon: Icon(Icons.keyboard_arrow_up),
              color: Theme.of(context).cardColor,
              tooltip: 'Previous question',
              onPressed: () {
                back(context);
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: isForm() ? 15 : 25, child: getWidget(context)),
          if (shouldHaveNext()) Spacer(),
          if (shouldHaveNext()) Expanded(
              flex: isForm() ? 1 : 3,
              child: valid() ? BoldCallToAction(label: 'Next!', color: Theme.of(context)
        .cardColor, onTap: () {next(context);}, textColor: Theme.of(context).primaryColor,
              ) : Container()),
          if (shouldHaveNext()) setButtonHeight(context),
        ],
      ),
    );
  }

  List<String> getHelp();

  Widget setButtonHeight(BuildContext context) {
   return Spacer(
     flex: 2,
   );
  }

  Widget getWidget(BuildContext context);

  void submitCallback();

  InfoNavigator getNavigator();

  bool valid();

  bool isForm() => false;

  bool shouldHaveNext() => true;

  void next(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    submitCallback();
    getNavigator().next(context, this);
  }

  void back(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    submitCallback();
    getNavigator().back(context, this);
  }
}
