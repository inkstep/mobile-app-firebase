import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/long_text_input_form_element.dart';
import 'package:inkstep/utils/info_navigator.dart';

import 'info_widget.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({
    Key key,
    @required this.descController,
    @required this.navigator,
  }) : super(key: key);

  final TextEditingController descController;
  final InfoNavigator navigator;

  @override
  State<StatefulWidget> createState() => _DescriptionScreenState(descController, navigator);
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  _DescriptionScreenState(this.descController, this.navigator) {
    listener = () {
      setState(() {});
    };
    descController.addListener(listener);
  }

  VoidCallback listener;

  final TextEditingController descController;
  final InfoNavigator navigator;

  @override
  Widget build(BuildContext context) {
    return DescriptionWidget(descController, navigator, (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    descController.removeListener(listener);

    super.dispose();
  }
}

class DescriptionWidget extends InfoWidget {
  DescriptionWidget(this.descController, this.navigator, this.callback);

  final TextEditingController descController;
  final InfoNavigator navigator;
  final void Function(String) callback;

  @override
  Widget getWidget(BuildContext context) {
    return LongTextInputFormElement(
      textController: descController,
      label: 'Tell your artist what you want and your inspiration behind it. '
          'You\'ll get to add some photos to show them in a minute!',
      hint: '',
      callback: (_) {
        if (valid()) {
          next(context);
        }
      },
    );
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
    return descController.text.isNotEmpty;
  }

  @override
  String getHelp() {
    return 'Help Help Help';
  }
}
