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
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 16.0,
                    runSpacing: 1.0,
                    children: <Widget>[
                      _chooseDayChip('Monday', weekCallbacks.monday),
                      _chooseDayChip('Tuesday', weekCallbacks.tuesday),
                      _chooseDayChip('Wednesday', weekCallbacks.wednesday),
                      _chooseDayChip('Thursday', weekCallbacks.thursday),
                      _chooseDayChip('Friday', weekCallbacks.friday),
                      _chooseDayChip('Saturday', weekCallbacks.saturday),
                      _chooseDayChip('Sunday', weekCallbacks.sunday),
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

  Widget _chooseDayChip(String day, SingleDayCallbacks dayCallback) {
    return FilterChip(
      label: Text(day),
      onSelected: dayCallback.onSwitched,
      selected: dayCallback.currentValue(),
    );
  }
}

class WeekCallbacks {
  WeekCallbacks(
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  );

  final SingleDayCallbacks monday;
  final SingleDayCallbacks tuesday;
  final SingleDayCallbacks wednesday;
  final SingleDayCallbacks thursday;
  final SingleDayCallbacks friday;
  final SingleDayCallbacks saturday;
  final SingleDayCallbacks sunday;
}

class SingleDayCallbacks {
  SingleDayCallbacks(this.onSwitched, this.currentValue);

  final BoolCallback onSwitched;
  final bool Function() currentValue;
}
