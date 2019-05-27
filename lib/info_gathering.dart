import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widgets.dart';

import 'info_gathering/concept_question.dart';

class NewJourneyRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewJourneyRouteState();
}

class _NewJourneyRouteState extends State<NewJourneyRoute> {
  final controller = PageController(
    initialPage: 1,
  );

  Widget get styleQ => JourneyCard("style");

  Widget get conceptQ => TattooConcept();

  Widget get positionQ => JourneyCard("position");

  Widget get sizeQ => JourneyCard("size");

  Widget get availabilityQ => JourneyCard("availability");

  Widget get depositQ => JourneyCard("deposit");

  Widget get legalQ => JourneyCard("legal");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a new journey'),
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        children: <Widget>[
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
