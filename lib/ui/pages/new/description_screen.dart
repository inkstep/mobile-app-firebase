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
  State<StatefulWidget> createState() =>
      _DescriptionScreenState(descController, navigator);
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  _DescriptionScreenState(this.descController, this.navigator);

  final TextEditingController descController;
  final InfoNavigator navigator;

  @override
  Widget build(BuildContext context) {
    return DescriptionWidget(descController, navigator);
  }
}

class DescriptionWidget extends InfoWidget {
  DescriptionWidget(this.descController, this.navigator);

  final TextEditingController descController;
  final InfoNavigator navigator;

  @override
  Widget getWidget(BuildContext context) {
    return LongTextInputFormElement(
      textController: descController,
      label: 'Tell your artist what you want and your inspiration behind it. '
          'You\'ll get to add some photos to show them in a minute!',
      hint: 'A sleeping deer protecting a crown with stars splayed behind it',
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
}
