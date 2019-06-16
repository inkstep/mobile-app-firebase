import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/horizontal_divider.dart';

class AdviceSnippet extends StatelessWidget {
  const AdviceSnippet({
    Key key,
    @required this.description,
    @required this.children,
    @required this.timeOffset,
    this.timeDescription,
    this.preCare = false,
  }) : super(key: key);

  final String description;
  final Duration timeOffset;
  final String timeDescription;
  final bool preCare;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.w500),
          ),
          HorizontalDivider(
            thickness: 4,
            percentage: 20,
            color: Colors.white,
            alignment: MainAxisAlignment.start,
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          for (Widget adviceElem in children) adviceElem,
        ],
      ),
    );
  }
}
