import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/component/grid_image_picker.dart';
import 'package:inkstep/component/short_text_input.dart';
import 'package:inkstep/logo.dart';

class InfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final PageController controller = PageController(
    initialPage: 0,
  );

  // Should contain existing user flag to skip nameQ / contactQ

  Widget get nameQ =>
      ShortTextInput(controller, 'What do your friends call you?', 'Natasha');
  //Widget get styleQ => ('style');
  Widget get conceptQ => GridImagePicker();
//  Widget get positionQ => JourneyCard('position');
//  Widget get sizeQ => JourneyCard('size');
//  Widget get availabilityQ => JourneyCard('availability');
//  Widget get depositQ => JourneyCard('deposit');
//  Widget get legalQ => JourneyCard('legal');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Hero(
          tag: 'logo',
          child: LogoWidget(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context)
            .iconTheme
            .copyWith(color: Theme.of(context).backgroundColor),
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          nameQ,
          conceptQ,
//          styleQ,
//          positionQ,
//          sizeQ,
//          availabilityQ,
//          depositQ,
//          legalQ,
        ],
      ),
    );
  }
}
