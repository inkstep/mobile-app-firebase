import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/grid_image_picker.dart';
import 'package:inkstep/ui/short_text_input.dart';
import 'package:inkstep/ui/logo.dart';

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
  Widget get conceptQ => TattooConcept();
//  Widget get positionQ => JourneyCard('position');
//  Widget get sizeQ => JourneyCard('size');
//  Widget get availabilityQ => JourneyCard('availability');
//  Widget get depositQ => JourneyCard('deposit');
//  Widget get legalQ => JourneyCard('legal');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
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
        ),
        SafeArea(
          child: Container(
              child: Hero(
                tag: 'logo',
                child: LogoWidget(),
              ),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 30.0),
              width: 100),
        ),
      ],
    );
  }
}
