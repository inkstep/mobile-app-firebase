import 'dart:io';

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
    listener = () {
      setState(() {});
    };
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
    final int width = int.tryParse(widthController.text);
    final int height = int.tryParse(heightController.text);

    return Column(
      mainAxisSize: MainAxisSize.min,
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
            Expanded(flex: 6, child: _buildNumberInputBox(widthController, context)),
            Spacer(),
            Flexible(
              flex: 3,
              child: Text(
                'by',
                style: Theme.of(context).primaryTextTheme.subtitle,
              ),
            ),
            Spacer(),
            Expanded(flex: 6, child: _buildNumberInputBox(heightController, context)),
            Flexible(
              flex: 2,
              child: Text(
                'cm',
                style: Theme.of(context).primaryTextTheme.subtitle,
              ),
            ),
          ],
        ),
        Flexible(
          child: AutoSizeText(
            'We recommend grabbing a ruler and '
            'trying to measure out where you want the tattoo to be',
            style: Theme.of(context).primaryTextTheme.subtitle,
            maxLines: 2,
          ),
        ),
        Spacer(),
        if (checkSquareArea(width, height, 2, 13))
          _buildSizeIndicator('assets/size-xs.jpg'), // 2
        if (checkSquareArea(width, height, 13, 25))
          _buildSizeIndicator('assets/size-s.jpg'), // 13
        if (checkSquareArea(width, height, 25, 60))
          _buildSizeIndicator('assets/size-m.jpg'), // 40
        if (checkSquareArea(width, height, 60, 130))
          _buildSizeIndicator('assets/size-l.jpg'), // 80
        if (checkSquareArea(width, height, 130, 200))
          _buildSizeIndicator('assets/size-xl.jpg'), // 190
        if (checkSquareArea(width, height, 200, 500)) // 270
          _buildSizeIndicator('assets/size-xxl.jpg'),
        if (checkSquareArea(width, height, 500, 999 * 999)) // 270
          _buildSizeIndicator('assets/size-xxxl.jpg'),
        Spacer(),
      ],
    );
  }

  Widget _buildSizeIndicator(String path) => Container(
        height: 150,
        child: Image.asset(path),
      );

  bool checkSquareArea(int width, int height, int lower, int upper) {
    if (width == null || height == null) {
      return false;
    }
    return width * height > lower && width * height <= upper;
  }

  Widget _buildNumberInputBox(TextEditingController textController, BuildContext context) {
    return Container(
      width: 430.0,
      child: ShortTextInputFormElement(
        textController: textController,
        keyboardType: TextInputType.number,
        label: '',
        hint: '',
        maxLength: 3,
        callback: (text) {
          SystemChannels.textInput.invokeMethod<dynamic>('TextInput.hide');
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
    final String width = widthController.text;
    final String height = heightController.text;
    if (width.isEmpty || height.isEmpty) {
      return false;
    }
    final int widthInt = int.tryParse(width);
    final int heightInt = int.tryParse(height);
    if (widthInt == null || heightInt == null) {
      return false;
    }
    return heightInt >= 1 && widthInt >= 1 && heightInt < 100 && widthInt < 100;
  }

  @override
  Widget setButtonHeight(BuildContext context) {
    int toFlex = 2;
    if (Platform.isIOS) {
      toFlex = 18;
    }
    return Spacer(
      flex: toFlex,
    );
  }

  @override
  List<String> getHelp() {
    return <String>[
      'Why do we want you to be so precise with size?',
      "What's wrong with giving a rough estimate?",
      'Even a small change in tattoo size can lead to drastically different session times and prices'
    ];
  }
}
