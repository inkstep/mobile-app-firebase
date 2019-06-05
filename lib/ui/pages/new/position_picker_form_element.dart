import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/dropdown_menu.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class PositionPickerFormElement extends StatefulWidget {
  const PositionPickerFormElement({Key key,
    @required this.controller,
    @required this.formData,
    @required this.textController,
  }) : super(key: key);

  final PageController controller;
  final Map formData;
  final TextEditingController textController;

  @override
  State<StatefulWidget> createState() => _PositionPickerFormElementState(
      controller,
      formData,
      textController,
  );
}

class _PositionPickerFormElementState extends State<StatefulWidget> {
  _PositionPickerFormElementState(this.controller, this.formData, this.textController) {
    positions = {
      'Leg': ['Lower Leg', 'Calf'],
      'Arm': ['Inner Wrist', 'Inner Arm', 'Biceps', 'Upper Arm', 'Side'],
      'Chest': ['Full Front Chest', 'Pec', 'Ribs'],
      'Foot': ['Ankle'],
      'Head': ['Inner Ear', 'Behind Ear'],
      'Hand': ['Fingers'],
      'Back': ['Back', 'Shoulders', 'Neck'],
      'Other': [],
    };
  }

  final PageController controller;
  final Map formData;
  final TextEditingController textController;

  String generalPos;

  Map<String, List<String>> positions;

  @override
  Widget build(BuildContext context) {
    return FormElementBuilder(
      builder: (context, focus, onSubmitCallback) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                  flex: generalPos == 'Other' ? 10 : 4,
                  child: Text(
                    'Where would you like your tattoo? (Arm, leg,'
                    ' etc)',
                    style: Theme.of(context).accentTextTheme.title,
                    textAlign: TextAlign.center,
                  )),
              Spacer(flex: 1),
              Flexible(
                flex: generalPos == 'Other' ? 10 : 3,
                child: DropdownMenu(
                  hintText: generalPos == null ? 'General Area' : generalPos,
                  callback: (value) {
                    setState(() {
                      generalPos = value;
                      formData['position'] = null;
                    });
                  },
                  items: positions.keys.toList(),
                ),
              ),
              Spacer(flex: 1),
              generalPos == 'Other'
                  ? Spacer(flex: 1)
                  : Flexible(
                      flex: 2,
                      child: Text(
                        'Specifics...',
                        style: Theme.of(context).accentTextTheme.title,
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
                          callback: onSubmitCallback,
                        )
                      : DropdownMenu(
                          hintText:
                              formData['position'] == null ? 'Specifc Area' : formData['position'],
                          callback: onSubmitCallback,
                          items: generalPos == null ? [] : positions[generalPos],
                        ),
                ),
              ),
            ],
          ),
        );
      },
      onSubmitCallback: (value) {
        setState(() {
          formData['position'] = value;
        });
      },
      controller: controller,
    );
  }
}
