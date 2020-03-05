import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/describe_concept.dart';
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
    return DescribeConceptFormElement(
      textController: descController,
      label: 'Tell your artist the inspiration behind your idea!',
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
  List<String> getHelp() {
    return <String>['Help!', 'Me!', 'Lorem ipsum stuff'];
  }
}
