import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/info_gathering/short_text_input.dart';
import 'package:inkstep/logo.dart';
import 'package:inkstep/widgets.dart';

import 'info_gathering/concept_question.dart';
import 'journeys/journeys.dart';

class NewJourneyRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewJourneyRouteState();
}

class _NewJourneyRouteState extends State<NewJourneyRoute> {
  final PageController controller = PageController(
    initialPage: 0,
  );

  Widget get nameQ =>
      ShortTextInput(controller, 'What do your friends call you?', 'Natasha');
  Widget get styleQ => const JourneyCard('style');
  Widget get conceptQ => TattooConcept();
  Widget get positionQ => const JourneyCard('position');
  Widget get sizeQ => const JourneyCard('size');
  Widget get availabilityQ => const JourneyCard('availability');
  Widget get depositQ => const JourneyCard('deposit');
  Widget get legalQ => const JourneyCard('legal');

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
