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
        Text('Your tattoo is going to be sore for the rest of day one. '
            'It might look a bit red and swollen and feel warm to the touch due to blood rushing'
            ' to the spot while it heals.'),
        Text(''),
        BulletElement('Be gentle with your freshly inked tattoo, especially once you unwrap it,'
            ' and avoid touching your tattoo – or letting anyone else touch it!'),
        Text(''),
        BulletElement('The wrap is basically a temporary bandage. Leave it on for as long as '
            'directed by your artist – this can be anything from an hour to the whole day, '
            'sometimes even longer.'),
        BulletElement('Cut through the wrap carefully using scissors instead of peeling it right '
            'off as this could pull out some ink that hasn’t settled yet, especially if you were '
            'given a cloth wrap which tends to stick to the skin.'),
        BulletElement('Refrain from long and/or hot showers – opt for shorter showers in room '
            'temperature water, and try to keep your tattoo from getting wet.'),
        BulletElement('For up to 48 hours after getting inked, avoid all of these – sorry, '
            'you’re going to have to delay that freshly inked party you were planning on throwing!')
      ],
    ),
    AdviceSnippet(
      timeDescription: 'Week 1: Day 02',
      description: 'Caring for a Sore and Itchy Tattoo',
      timeOffset: Duration(days: 2),
      children: <Widget>[
        Text('You’re likely still going to feel sore on the tattoo area for a few days more, '
            'up to a week (or slightly longer for larger or more detailed tattoos).'),
        Text(''),
        BulletElement('Cleanse and moisturize at least twice during the day and once at '
            'night before you sleep – that’s three times a day!'),
        Text(''),
        BulletElement('Your tattoo might also start to get itchy at this point. '
            'And what are we NOT going to do? That’s right, we WILL NOT scratch!'),
        BulletElement('Wear loose, comfortable clothing in smooth fabrics.'),
        BulletElement('Do not apply any sunscreen or heavy products until your '
            'tattoo is fully healed. Keep it out of the sun and water as much as possible.'),
        BulletElement('It’s going to be uncomfortable for at least a week, especially if the '
            'tattoo is quite large or is placed in a spot that is hard to avoid sleeping on.')
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
      children: <Widget>[
        Text('You may have heard about this stage already – an itchy tattoo during week 2!'),
        Text(''),
        BulletElement('Annoying enough just because you have to refrain from scratching, '
            'this stage is also hard because your tattoo is going to start peeling and '
            'flaking and won’t look its best.'),
        Text(''),
        BulletElement('The scabs are now fully formed and are starting to come off, '
            'which is what is causing the peeling, flaking, and itching.'),
        BulletElement('And just like the previous 5 days, what are we not going to do? '
            'Scratch, rub, pick at, or pull off the peeling skin.'),
        BulletElement('Keep the area very clean and well-moisturized (using a light lotion, '
            'preferably your recommended aftercare lotion, or alternatively a light oil '
            'such as baby oil).'),
        BulletElement('Moisturize after every wash and once before bed.'),
      ],
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
    final DateTime currTime = DateTime.now();

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
