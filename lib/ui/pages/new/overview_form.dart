import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/ui/components/bold_call_to_action.dart';
import 'package:inkstep/ui/pages/new/availability_selector.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class OverviewForm extends StatelessWidget {
  const OverviewForm({
    Key key,
    @required this.formData,
    @required this.nameController,
    @required this.descController,
    @required this.emailController,
    @required this.sizeController,
    @required this.weekCallbacks,
  }) : super(key: key);

  final Map<String, String> formData;
  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController emailController;
  final TextEditingController sizeController;
  final WeekCallbacks weekCallbacks;

  @override
  Widget build(BuildContext context) {
    formData['name'] = nameController.text;
    formData['mentalImage'] = descController.text;
    formData['email'] = emailController.text;
    formData['size'] = sizeController.text;
    formData['availability'] = getAvailability(weekCallbacks);

    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
            flex: 2,
            child: Text(
              'Check your details!',
              style: Theme.of(context).accentTextTheme.title,
            )),
        Spacer(flex: 1),
        Expanded(
          flex: 10,
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      getLabel(context, 'Name', formData, 'name'),
                      getLabel(context, 'Description', formData, 'mentalImage'),
                      getLabel(context, 'Position', formData, 'position'),
                      getLabel(context, 'Size', formData, 'size'),
                      getLabel(context, 'Availability', formData, 'availability'),
                      getLabel(context, 'Deposit', formData, 'deposit'),
                      getLabel(context, 'Email', formData, 'email'),
                    ],
                  )),
              Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getData(context, formData, 'name'),
                      getData(context, formData, 'mentalImage'),
                      getData(context, formData, 'position'),
                      getData(context, formData, 'size'),
                      getData(context, formData, 'availability'),
                      getData(context, formData, 'deposit'),
                      getData(context, formData, 'email'),
                    ],
                  ))
            ],
          ),
        ),
        Spacer(flex: 1),
        Expanded(
            flex: 2,
            child: missingData(formData)
                ? Text(
                    'Please go back and fill in your missing data!',
                    style: Theme.of(context).accentTextTheme.subtitle,
                    textAlign: TextAlign.center,
                  )
                : BoldCallToAction(
                    label: 'Contact Artist!',
                    color: Theme.of(context).backgroundColor,
                    textColor: Theme.of(context).cardColor,
                    onTap: () {
                      final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
                      journeyBloc.dispatch(
                        AddJourney(
                          Journey(
                            // TODO(DJRHails): Don't hardcode these
                            artistName: 'Ricky',
                            studioName: 'South City Market',
                            name: formData['name'],
                            size: formData['size'],
                            email: formData['email'],
                            availability: formData['availability'],
                            deposit: formData['deposit'],
                            mentalImage: formData['mentalImage'],
                            position: formData['position'],
                          ),
                        ),
                      );
                      final ScreenNavigator nav = sl.get<ScreenNavigator>();
                      nav.openJourneyScreen(context);
                    },
                  )),
        Spacer(flex: 1),
      ],
    ));
  }

  bool missingData(Map formData) {
    for (var key in formData.keys) {
      if (formData[key] == '') {
        return true;
      }
    }
    if (formData['availability'] == '0000000') {
      return true;
    }
    return false;
  }

  Widget getData(BuildContext context, Map formData, String param) {
    String data;

    if (formData[param] == '' || formData[param] == '0000000') {
      data = 'MISSING';
    } else {
      data = formData[param];
      if (param == 'availability') {
        data = 'Provided';
      }
    }

    return Expanded(
      flex: 1,
      child: AutoSizeText(data, style: Theme.of(context).accentTextTheme.body1),
    );
  }

  Widget getLabel(BuildContext context, String dataLabel, Map formData, String param) {
    final TextStyle style = (formData[param] == '' || formData[param] == '0000000')
        ? Theme.of(context).primaryTextTheme.subtitle
        : Theme.of(context).accentTextTheme.subtitle;

    return Expanded(
      flex: 1,
      child: Text(
        dataLabel + ': ',
        style: style,
      ),
    );
  }


  String getAvailability(WeekCallbacks weekCallbacks) {
    String availabilityString = '';
    if (weekCallbacks.monday.currentValue()) {
      availabilityString += '1';
    }
    else {
      availabilityString += '0';
    }
    if (weekCallbacks.tuesday.currentValue()) {
      availabilityString += '1';
    }
    else {
      availabilityString += '0';
    }
    if (weekCallbacks.wednesday.currentValue()) {
      availabilityString += '1';
    }
    else {
      availabilityString += '0';
    }
    if (weekCallbacks.thursday.currentValue()) {
      availabilityString += '1';
    }
    else {
      availabilityString += '0';
    }
    if (weekCallbacks.friday.currentValue()) {
      availabilityString += '1';
    }
    else {
      availabilityString += '0';
    }
    if (weekCallbacks.saturday.currentValue()) {
      availabilityString += '1';
    }
    else {
      availabilityString += '0';
    }
    if (weekCallbacks.sunday.currentValue()) {
      availabilityString += '1';
    }
    else {
      availabilityString += '0';
    }
    return availabilityString;
  }
}
