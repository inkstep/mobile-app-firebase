import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';

class AvailabilitySelector extends StatelessWidget {
  const AvailabilitySelector(
      {Key key, @required this.controller, this.duration = 500, @required this.weekCallbacks})
      : super(key: key);

  final PageController controller;
  final int duration;
  final WeekCallbacks weekCallbacks;

  @override
  Widget build(BuildContext context) {
    return FormElementBuilder(
        controller: controller,
        onSubmitCallback: (_) {},
        builder: (context, focus, onSubmitCallback) {
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
              RaisedButton(
                onPressed: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: duration), curve: Curves.ease);
                },
                elevation: 15.0,
                padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                child: Text(
                  'Next!',
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Signika'),
                ),
              ),
            ],
          ));
        });
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
