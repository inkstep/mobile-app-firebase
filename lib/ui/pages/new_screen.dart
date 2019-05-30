import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/concept_question.dart';
import 'package:inkstep/ui/components/logo.dart';
import 'package:inkstep/ui/components/name_question.dart';

class NewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final PageController controller = PageController(
    initialPage: 0,
  );

  int get autoScrollDuration => 500;

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
          NameQ(
            controller: controller,
            autoScrollDuration: autoScrollDuration,
          ),
          ConceptQ(
            controller: controller,
            autoScrollDuration: autoScrollDuration,
          ),
        ],
      ),
    );
  }
}
