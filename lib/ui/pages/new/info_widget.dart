import 'package:flutter/material.dart';
import 'package:inkstep/utils/info_navigator.dart';

abstract class InfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).accentIconTheme,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.keyboard_arrow_up),
              tooltip: 'Previous question',
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                submitCallback();
                getNavigator().back(context);
              }),
          valid() ? IconButton(
              icon: Icon(Icons.keyboard_arrow_down),
              tooltip: 'Next question',
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                submitCallback();
                getNavigator().next(context);
              }) : Container(),
        ],
      ),
      body: getWidget(context),
    );
  }

  Widget getWidget(BuildContext context);

  void submitCallback();

  InfoNavigator getNavigator();

  bool valid();
}
