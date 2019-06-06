import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/ui/components/short_text_input_form_element.dart';

class SizeSelector extends StatelessWidget {

  const SizeSelector({
    Key key,
    @required this.controller,
    @required this.widthController,
    @required this.heightController,
  }) : super(key: key);

  final PageController controller;
  final TextEditingController widthController;
  final TextEditingController heightController;
  //final TextInputType keyboardType = TextInputType.number;

  @override
  Widget build(BuildContext context) {
    return FormElementBuilder(
      builder: (context, focus, submitCallback) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'How big would you like your tattoo to be?',
              style: Theme.of(context).accentTextTheme.headline,
              textScaleFactor: 0.8,
              textAlign: TextAlign.center,
            ),
            Flexible(child:
              Row(
                children: <Widget>[
                  _buildNumberInputBox(widthController),
                  Text(
                    'cm by ',
                    style: Theme.of(context).accentTextTheme.subtitle,
                  ),
                  _buildNumberInputBox(heightController),
                  Text(
                    'cm',
                    style: Theme.of(context).accentTextTheme.subtitle,
                  ),
                  Spacer(),
                ],
              ),
            ),
            // TODO(Felination): Replace this with a clever grab of how big the user's screen is
            AutoSizeText(
              'We recommend grabbing a ruler and '
                  'trying to measure out where you want the tattoo to be',
              style: Theme.of(context).accentTextTheme.subtitle,
              maxLines: 2,
            ),
            Spacer(),
            RaisedButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
              elevation: 15.0,
              padding: EdgeInsets.fromLTRB(
                  32.0, 16.0, 32.0, 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Text('Next!', style: TextStyle(
                  fontSize: 20.0, fontFamily: 'Signika'),
              ),
            ),
          ],
        );
      },
      controller:  controller,
      onSubmitCallback: (_) {},
    );
  }

  Widget _buildNumberInputBox(TextEditingController textController) {
    return Container(
      width: 115.0,
      child: ShortTextInputFormElement(
        controller: null,
        textController: textController,
        keyboardType: TextInputType.number,
        label: '',
        hint:'',
        maxLength: 3,
      ),
    );
  }

}