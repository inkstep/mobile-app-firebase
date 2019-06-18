import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/short_text_input_form_element.dart';
import 'package:inkstep/utils/info_navigator.dart';

import 'info_widget.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({
    Key key,
    @required this.emailController,
    @required this.navigator,
  }) : super(key: key);

  final TextEditingController emailController;
  final InfoNavigator navigator;

  @override
  State<StatefulWidget> createState() => _EmailScreenState(emailController, navigator);
}

class _EmailScreenState extends State<EmailScreen> {
  _EmailScreenState(this.emailController, this.navigator) {
    listener = () {
      setState(() {});
    };
    emailController.addListener(listener);
  }

  VoidCallback listener;

  final TextEditingController emailController;
  final InfoNavigator navigator;

  @override
  Widget build(BuildContext context) {
    return EmailWidget(emailController, navigator, (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    emailController.removeListener(listener);

    super.dispose();
  }
}

class EmailWidget extends InfoWidget {
  EmailWidget(this.emailController, this.navigator, this.callback);

  final TextEditingController emailController;
  final InfoNavigator navigator;
  final void Function(String) callback;

  @override
  Widget getWidget(BuildContext context) {
    return ShortTextInputFormElement(
        textController: emailController,
        keyboardType: TextInputType.emailAddress,
        capitalisation: TextCapitalization.none,
        label: 'What\'s your email address?',
        hint: 'example@inkstep.com',
        callback: (_) {
          if (valid()) {
            next(context);
          }
        });
  }

  @override
  InfoNavigator getNavigator() {
    return navigator;
  }

  @override
  void submitCallback() {
    return;
  }

  @override
  bool valid() {
    final RegExp regExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
      caseSensitive: false,
      multiLine: false,
    );

    return regExp.hasMatch(emailController.text);
  }

  @override
  List<String> getHelp() {
    return <String>['Help!', 'Me!', 'Lorem ipsum stuff'];
  }
}
