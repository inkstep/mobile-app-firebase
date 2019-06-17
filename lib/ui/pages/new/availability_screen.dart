import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/utils/info_navigator.dart';

import 'info_widget.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({Key key, this.navigator, this.callback, this.avail}) : super(key: key);

  final InfoNavigator navigator;
  final void Function(List<bool>) callback;
  final String avail;

  @override
  State<StatefulWidget> createState() => _AvailabilityScreenState(navigator, callback, avail);
}

class WeekCallbacks {
  WeekCallbacks(this.callbacks);

  final List<SingleDayCallback> callbacks;
}

class SingleDayCallback {
  SingleDayCallback(this.onSwitched, this.currentValue);

  final BoolCallback onSwitched;
  final bool Function() currentValue;
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  _AvailabilityScreenState(this.navigator, this.callback, String avail) {
    weekCallbacks = WeekCallbacks([
      callbackForDay(0),
      callbackForDay(1),
      callbackForDay(2),
      callbackForDay(3),
      callbackForDay(4),
      callbackForDay(5),
      callbackForDay(6)
    ]);

    for(int i = 0; i < avail.length; i++) {
      final char = avail[i];
      availability[i] = char == '1';
    }
  }

  final InfoNavigator navigator;
  final void Function(List<bool>) callback;

  WeekCallbacks weekCallbacks;

  List<bool> availability = List.filled(7, false);

  SingleDayCallback callbackForDay(int day) {
    return SingleDayCallback((switched) {
      setState(() {
        availability[day] = switched;
      });
    }, () {
      return availability[day];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AvailabilityWidget(weekCallbacks, navigator, availability, callback);
  }
}

class AvailabilityWidget extends InfoWidget {
  AvailabilityWidget(this.weekCallbacks, this.navigator, this.availability, this.callback);

  final int duration = 500;
  final WeekCallbacks weekCallbacks;
  final InfoNavigator navigator;
  final List<bool> availability;
  final void Function(List<bool>) callback;

  @override
  Widget getWidget(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'What days of the week are you normally available?',
          style: Theme.of(context).accentTextTheme.title,
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: <Widget>[
                _chooseDayChip('Monday', weekCallbacks.callbacks[0], context),
                _chooseDayChip('Tuesday', weekCallbacks.callbacks[1], context),
                _chooseDayChip('Wednesday', weekCallbacks.callbacks[2], context),
                _chooseDayChip('Thursday', weekCallbacks.callbacks[3], context),
                _chooseDayChip('Friday', weekCallbacks.callbacks[4], context),
                _chooseDayChip('Saturday', weekCallbacks.callbacks[5], context),
                _chooseDayChip('Sunday', weekCallbacks.callbacks[6], context),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _chooseDayChip(String day, SingleDayCallback dayCallback, BuildContext context) {
    return Flexible(
      child: Row(
        children: <Widget>[
          Text(
            day,
            textScaleFactor: 1.5,
            style: Theme.of(context).accentTextTheme.subtitle,
          ),
          Spacer(),
          FilterChip(
            label: Text('   '),
            onSelected: dayCallback.onSwitched,
            selected: dayCallback.currentValue(),
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
    callback(availability);
  }

  @override
  bool valid() {
    return availability.contains(true);
  }
}
