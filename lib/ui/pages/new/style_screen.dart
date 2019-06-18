import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/utils/info_navigator.dart';

import 'info_widget.dart';

class StyleScreen extends StatefulWidget {
  StyleScreen({
    Key key,
    @required this.styleController,
    this.navigator,
  }) : super(key: key);

  final TextEditingController styleController;
  final InfoNavigator navigator;

  @override
  State<StatefulWidget> createState() => _StyleScreenState(styleController, navigator);
}

class _StyleScreenState extends State<StyleScreen> {
  _StyleScreenState(this.styleController, this.navigator) {
    listener = () {
      setState(() {});
    };
    styleController.addListener(listener);
  }

  final TextEditingController styleController;
  final InfoNavigator navigator;
  VoidCallback listener;

  @override
  Widget build(BuildContext context) {
    return StyleScreenWidget(styleController, navigator, (_) {});
  }

  @override
  void dispose() {
    styleController.removeListener(listener);
    super.dispose();
  }
}

typedef StyleBuilder = Widget Function(
    BuildContext, TextEditingController, void Function(BuildContext));

class StyleScreenWidget extends InfoWidget {
  StyleScreenWidget(this.styleController, this.navigator, this.callback);

  final TextEditingController styleController;
  final InfoNavigator navigator;
  final void Function(String) callback;

  final List<Style> styles = [
    Style(
      name: 'Abstract',
      images: ['assets/style-abstract-1.jpg', 'assets/style-abstract-2.jpg'],
      description: 'Abstract tattoos draw heavily from early surrealist painters. '
          'The word ‘abstract’ refers to ideas that do not have a physical form. '
          'In art, this represents work that is complex and layered, '
          'and often appears to not have any structure’. '
          'Abstract designs are therefore open to interpretation and usually have personal '
          'meaning for the wearers of such tattoos.',
    ),
    Style(
      name: 'Black & Grey',
      images: [
        'assets/style-black&grey-1.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Blackwork',
      images: [
        'assets/style-blackwork-1.jpg',
        'assets/style-blackwork-2.jpg',
        'assets/style-blackwork-3.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Brushstroke',
      images: [
        'assets/style-brushstroke-1.jpg',
        'assets/style-brushstroke-2.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Classic',
      images: [
        'assets/style-classic-1.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Dotwork',
      images: [
        'assets/style-dotwork-1.jpg',
        'assets/style-dotwork-2.jpg',
        'assets/style-dotwork-3.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Geometric',
      images: [
        'assets/style-geometric-1.jpg',
        'assets/style-geometric-2.jpg',
        'assets/style-geometric-3.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Hyperrealism',
      images: [
        'assets/style-hyperrealism-1.jpg',
        'assets/style-hyperrealism-2.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Linework',
      images: [
        'assets/style-linework-1.jpg',
        'assets/style-linework-2.jpg',
        'assets/style-linework-3.jpg',
        'assets/style-linework-4.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Negative Space',
      images: [
        'assets/style-negative-space-1.jpg',
        'assets/style-negative-space-2.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'New School',
      images: [
        'assets/style-new-school-1.jpg',
        'assets/style-new-school-2.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Realism',
      images: [
        'assets/style-realism-1.jpg',
        'assets/style-realism-2.jpg',
        'assets/style-realism-3.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Script',
      images: [
        'assets/style-script-1.jpg',
        'assets/style-script-2.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Silhouette / Shadow',
      images: [
        'assets/style-silhouette-shadow-1.jpg',
        'assets/style-silhouette-shadow-2.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Trash Polka',
      images: [
        'assets/style-trash-polka-1.jpg',
        'assets/style-trash-polka-2.jpg',
      ],
      description: 'TODO',
    ),
    Style(
      name: 'Watercolour',
      images: [
        'assets/style-watercolour-1.jpg',
        'assets/style-watercolour-2.jpg',
      ],
      description: 'TODO',
    ),
  ];

  @override
  Widget getWidget(BuildContext context) {
    if (styleController.value != null) {
      styles.sort((s1, s2) => s1.name == styleController.value.text
          ? -1
          : s2.name == styleController.value.text ? 1 : 0);
    }
    final orderedStyles = styles;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'What style do you like?',
          style: Theme.of(context).primaryTextTheme.headline,
          textScaleFactor: 0.8,
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: styles.length,
            itemBuilder: (context, idx) => _styleBuilder(context, orderedStyles[idx]),
          ),
        )
      ],
    );
  }

  Widget _styleBuilder(BuildContext context, Style style) {
    return InkWell(
      onTap: () {
        styleController.value = TextEditingValue(text: style.name);
        next(context);
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: style.images.length,
              itemBuilder: (context, idx) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(style.images[idx]),
                  ),
              padding: EdgeInsets.only(left: 64.0),
            ),
          ),
          Text(
            style.name,
            style: Theme.of(context).textTheme.headline.copyWith(
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(3.0, 3.0),
                  blurRadius: 3.0,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ],
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
  bool shouldHaveNext() => false;

  @override
  bool valid() {
    return styleController.text.isNotEmpty;
  }
}

class Style {
  Style({this.name, this.images, this.description});

  String description;
  String name;
  List<String> images;
}
