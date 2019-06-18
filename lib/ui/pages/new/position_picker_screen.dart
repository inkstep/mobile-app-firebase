import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/dropdown_menu.dart';
import 'package:inkstep/ui/components/short_text_input.dart';
import 'package:inkstep/utils/info_navigator.dart';

import 'info_widget.dart';

class PositionPickerScreen extends StatefulWidget {
  const PositionPickerScreen({
    Key key,
    @required this.formData,
    @required this.navigator,
    @required this.callback,
  }) : super(key: key);

  final Map formData;
  final InfoNavigator navigator;
  final void Function(String pos, String genPos) callback;

  @override
  State<StatefulWidget> createState() =>
      _PositionPickerScreenState(formData, navigator, callback);
}

class _PositionPickerScreenState extends State<StatefulWidget> {
  _PositionPickerScreenState(Map formData, this.navigator, this.callback) {
    generalPos ??= formData['generalPos'];
    specificPos ??= formData['position'];
    textController = TextEditingController(text: specificPos ?? '...');
  }

  TextEditingController textController;
  final InfoNavigator navigator;
  final void Function(String pos, String genPos) callback;

  String generalPos;
  String specificPos;

  @override
  Widget build(BuildContext context) {
    return PositionWidget(navigator, callback, generalPos, specificPos, textController, (text) {
      setState(() {
        generalPos = text;
        specificPos = '';
      });
    }, (text) {
      setState(() {
        specificPos = text;
      });
    });
  }
}

class PositionWidget extends InfoWidget {
  PositionWidget(this.navigator, this.callback, this.generalPos, this.specificPos,
      this.textController, this.generalPosCallback, this.specificPosCallback);

  final String generalPos;
  final String specificPos;
  final TextEditingController textController;
  final InfoNavigator navigator;
  final void Function(String pos, String genPos) callback;
  final void Function(String text) generalPosCallback;
  final void Function(String text) specificPosCallback;

  final Map<String, List<String>> positions = {
    'Leg': ['Lower Leg', 'Calf'],
    'Arm': ['Inner Wrist', 'Inner Arm', 'Biceps', 'Upper Arm', 'Side'],
    'Chest': ['Full Front Chest', 'Pec', 'Ribs'],
    'Foot': ['Ankle'],
    'Head': ['Inner Ear', 'Behind Ear'],
    'Hand': ['Fingers'],
    'Back': ['Back', 'Shoulders', 'Neck'],
    'Other': [],
  };

  @override
  Widget getWidget(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
              flex: generalPos == 'Other' ? 10 : 4,
              child: Text(
                'Where would you like your tattoo? (Arm, leg,'
                ' etc)',
                style: Theme.of(context).primaryTextTheme.title,
                textAlign: TextAlign.center,
              )),
          Spacer(flex: 1),
          Flexible(
            flex: generalPos == 'Other' ? 10 : 3,
            child: DropdownMenu(
              hintText: generalPos == '' ? 'General Area' : generalPos,
              callback: generalPosCallback,
              items: positions.keys.toList(),
            ),
          ),
          Spacer(flex: 1),
          generalPos == 'Other'
              ? Spacer(flex: 1)
              : Flexible(
                  flex: 2,
                  child: Text(
                    generalPos == null ? '' : 'Specifics...',
                    style: Theme.of(context).primaryTextTheme.title,
                    textAlign: TextAlign.center,
                  ),
                ),
          Spacer(flex: 1),
          Flexible(
            flex: generalPos == 'Other' ? 30 : 4,
            child: Container(
              child: generalPos == 'Other'
                  ? ShortTextInput(
                      controller: textController,
                      label: 'Specific Area',
                      hint: '...',
                      maxLength: 20,
                      capitalisation: TextCapitalization.sentences,
                      callback: specificPosCallback,
                    )
                  : DropdownMenu(
                      hintText: specificPos == null ? 'Specific Area' : specificPos,
                      callback: specificPosCallback,
                      items: generalPos == '' ? [] : positions[generalPos],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  InfoNavigator getNavigator() {
    return navigator;
  }

  @override
  void submitCallback() {
    callback(specificPos, generalPos);
  }

  @override
  bool valid() {
    return specificPos.isNotEmpty;
  }
}
