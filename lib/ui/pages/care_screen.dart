import 'package:flutter/material.dart';
import 'package:inkstep/ui/pages/care/advice_snippet.dart';
import 'package:inkstep/ui/pages/care/bullet_element.dart';

class CareScreen extends StatelessWidget {
  const CareScreen({Key key, @required this.bookedTime}) : super(key: key);

  final DateTime bookedTime;

  static const AdviceSnippet expectation = AdviceSnippet(
    description: 'What to expect!',
    timeOffset: Duration(days: 7 * 7),
    preCare: true,
    children: <Widget>[
      Text('New tattoos are raw, open wounds and will hurt a bit, '
          'about as much as a mild to moderate skin burn. This is normal and to be expected.'),
      Text(''),
      BulletElement(
        'The tattoo area will be sore (like the muscles underneath have just been stretched',
      ),
      BulletElement('You will experience redness'),
      BulletElement('You might expereince some bruising (skin will be raised and bumpy)'),
      BulletElement('You might feel a bit run down or tired'),
      Text(''),
      Text('All these symptoms will gradually subside over the first week and will '
          'be totally gone after 2-4 weeks.'),
    ],
  );

  // www.jhaiho.com/tattoo-care/
  static const List<AdviceSnippet> snippets = <AdviceSnippet>[
    AdviceSnippet(
      description: 'Precare (The day before)',
      timeDescription: 'Week 1: Day 00',
      timeOffset: Duration(days: 1),
      preCare: true,
      children: <Widget>[
        Text('Come sober'),
        Text('Hygiene'), // Co// me freshly showered! Tattooing required good hygiene. ],
        Text('Prep the tattoo spot'),
        Text('What to wear'), // loose, comfortable clothing - think black!,
        Text('Eat well and stay hydrated'), // blood glucose dropping, bring a snack, well rested
      ],
    ),
    AdviceSnippet(
      description: 'Tattoo Day: Getting ready!',
      timeDescription: 'T-24hrs',
      timeOffset: Duration(days: 1),
      preCare: true,
      children: <Widget>[
        Text('Your appointment day is finally here! And with it, the usual hits play - '
            '"Do I prep the tattoo spot? Should I shave? Can I do a shot to calm my '
            'nerves before I get inked? Can I get there early? WHAT DO I WEAR?!"'
            'Pause the tunes - we\'ve got some answers for you!'),
        Text('Getting to your appointmnet'), // Be on time! Leave the friends,
        Text('Stay still'),
        Text('Breaks'),
        Text('Duration'),
        Text('Tipping'),
      ],
    ),
    AdviceSnippet(
      timeDescription: 'Week 1: Day 01',
      description: 'For the first 2 hours',
      timeOffset: Duration(hours: 2),
      children: <Widget>[
        Text('Leave in plastic wrap'),
        Text('Only remove after 2 hours'),
      ],
    ),
    AdviceSnippet(
      timeDescription: 'Week 1: Day 02',
      description: 'Caring for a Sore and Itchy Tattoo',
      timeOffset: Duration(days: 2),
      children: <Widget>[
        Text('Do not itch skin'),
        Text('Moisturise tattoo area 3 times a day'),
        Text('Apply cream every 8 hours'),
      ],
    ),
    AdviceSnippet(
      timeDescription: 'Week 1: Day 03',
      description: 'Scab Central!',
      timeOffset: Duration(days: 3),
      children: <Widget>[
        Text('Do not itch skin'),
        Text('Moisturise tattoo area 3 times a day'),
        Text('Apply cream every 8 hours'),
      ],
    ),
    AdviceSnippet(
      timeDescription: 'Week 1: Day 4/5',
      description: 'More Scabbing!',
      timeOffset: Duration(days: 5),
      children: <Widget>[],
    ),
    AdviceSnippet(
      timeDescription: 'Week 2',
      description: 'Dreaded Tattoo Itch!',
      timeOffset: Duration(days: 14),
      children: <Widget>[],
    ),
    AdviceSnippet(
      timeDescription: 'Week 3',
      description: 'Final count down',
      timeOffset: Duration(days: 4 * 7),
      children: <Widget>[],
    ),
    AdviceSnippet(
      timeDescription: 'Week 4',
      description: 'More healing',
      timeOffset: Duration(days: 5 * 7),
      children: <Widget>[],
    ),
    AdviceSnippet(
      timeDescription: 'Week 5',
      description: 'More healing',
      timeOffset: Duration(days: 6 * 7),
      children: <Widget>[],
    ),
    AdviceSnippet(
      timeDescription: 'Week 6',
      description: 'Lifetime Tattoo Care!',
      timeOffset: Duration(days: 6 * 7 + 1),
      children: <Widget>[],
    ),
  ];

  bool hasAdvice(DateTime bookedTime) {
    return _adviceWidget(bookedTime) != null;
  }

  Widget _adviceWidget(DateTime bookedTime) {
    final DateTime currTime = DateTime.parse('2019-06-00 13:00:00'); //= DateTime.now();

    for (AdviceSnippet adviceDialog in snippets) {
      DateTime adviceDate;

      if (adviceDialog.preCare) {
        adviceDate = bookedTime.subtract(adviceDialog.timeOffset);
      } else {
        adviceDate = bookedTime.add(adviceDialog.timeOffset);
      }

      if (currTime.isBefore(bookedTime)) {
        if (currTime.isAfter(adviceDate)) {
          return adviceDialog;
        }
      } else {
        if (currTime.isBefore(adviceDate)) {
          return adviceDialog;
        }
      }
    }

    return expectation;
  }

  @override
  Widget build(BuildContext context) {
    final AdviceSnippet advice = _adviceWidget(bookedTime);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                advice.preCare ? 'Precare Advice' : 'Aftercare Advice',
                textScaleFactor: 1.25,
              ),
              if (advice.timeDescription != null)
                Text(
                  advice.timeDescription,
                ),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(child: advice),
    );
  }
}
