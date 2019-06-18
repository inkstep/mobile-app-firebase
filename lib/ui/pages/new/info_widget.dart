import 'package:flutter/material.dart';
import 'package:inkstep/utils/info_navigator.dart';

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
          Expanded(flex: valid() ? 15 : 25, child: getWidget(context)),
          if (shouldHaveNext()) Spacer(),
          if (shouldHaveNext()) Expanded(
              flex: valid() ? 2 : 1,
              child: valid() ? RaisedButton(
                onPressed: () {
                  next(context);
                },
                elevation: 15.0,
                padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                color: Theme.of(context).cardColor,
                child: Text(
                  'Next!',
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Signika', color: Theme.of(context)
                      .primaryColorDark),
                ),
              ) : Container()),
          if (shouldHaveNext()) setButtonHeight(context),
        ],
      ),
    );
  }

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
