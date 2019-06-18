import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inkstep/ui/components/short_text_input_form_element.dart';
import 'package:inkstep/utils/info_navigator.dart';

import 'info_widget.dart';

class SizeSelectorScreen extends StatefulWidget {
  SizeSelectorScreen({
    Key key,
    @required this.widthController,
    @required this.heightController,
    this.navigator,
  }) : super(key: key);

  final TextEditingController widthController;
  final TextEditingController heightController;
  final InfoNavigator navigator;

  @override
  State<StatefulWidget> createState() =>
      _SizeSelectorScreenState(widthController, heightController, navigator);
}

class _SizeSelectorScreenState extends State<SizeSelectorScreen> {
  _SizeSelectorScreenState(this.widthController, this.heightController, this.navigator) {
    listener = () {setState(() {});};
    widthController.addListener(listener);
    heightController.addListener(listener);
  }

  final TextEditingController widthController;
  final TextEditingController heightController;
  final InfoNavigator navigator;
  VoidCallback listener;

  @override
  Widget build(BuildContext context) {
    return SizeSelectorWidget(widthController, heightController, navigator, (_) {});
  }

  @override
  void dispose() {
    widthController.removeListener(listener);
    heightController.removeListener(listener);
    super.dispose();
  }
}

class SizeSelectorWidget extends InfoWidget {
  SizeSelectorWidget(this.widthController, this.heightController, this.navigator, this.callback);

  final TextEditingController widthController;
  final TextEditingController heightController;
  final InfoNavigator navigator;
  final void Function(String) callback;

  // TODO(DJRHails): Use default sizes, and use inches
  // XS – 0.5″ x 0.5″
  // S – 1″ x 2″
  // M – 2″ x 3″
  // L – 3″ x 4″
  // XL – 5″ x 6″
  // XXL – 6″ x 7″
  // TODO(DJRHails): Warnings on small tattoo sizes
  @override
  Widget getWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'How big would you like your tattoo to be?',
          style: Theme.of(context).primaryTextTheme.headline,
          textScaleFactor: 0.8,
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(flex: 2, child: _buildNumberInputBox(widthController, context)),
            Spacer(),
            Flexible(
              flex: 1,
              child: Text(
                'by',
                style: Theme.of(context).primaryTextTheme.subtitle,
              ),
            ),
            Spacer(),
            Flexible(flex: 2, child: _buildNumberInputBox(heightController, context)),
            Flexible(
              flex: 1,
              child: Text(
                'cm',
                style: Theme.of(context).primaryTextTheme.subtitle,
              ),
            ),
          ],
        ),
        AutoSizeText(
          'We recommend grabbing a ruler and '
          'trying to measure out where you want the tattoo to be',
          style: Theme.of(context).accentTextTheme.subtitle,
          maxLines: 2,
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildNumberInputBox(TextEditingController textController, BuildContext context) {
    return Container(
      width: 130.0,
      child: ShortTextInputFormElement(
        textController: textController,
        keyboardType: TextInputType.number,
        label: '',
        hint: '',
        maxLength: 3,
        callback: (text) {
          next(context);
          callback(text);
          },
        capitalisation: TextCapitalization.words,
      ),
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
    return widthController.text.isNotEmpty && heightController.text.isNotEmpty;
  }
}
