import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/main.dart';
import 'package:inkstep/models/form_result_model.dart';
import 'package:inkstep/ui/components/bold_call_to_action.dart';
import 'package:inkstep/ui/components/horizontal_divider.dart';
import 'package:inkstep/utils/info_navigator.dart';
import 'package:inkstep/utils/screen_navigator.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'info_widget.dart';

class OverviewForm extends StatelessWidget {
  const OverviewForm({
    Key key,
    @required this.formData,
    @required this.descController,
    @required this.emailController,
    @required this.widthController,
    @required this.heightController,
    @required this.images,
    this.navigator,
  }) : super(key: key);

  final Map<String, String> formData;
  final TextEditingController descController;
  final TextEditingController emailController;
  final TextEditingController widthController;
  final TextEditingController heightController;
  final List<Asset> images;
  final InfoNavigator navigator;

  @override
  Widget build(BuildContext context) => OverviewFormWidget(formData, descController,
      emailController, widthController, heightController, images, navigator);
}

class OverviewFormWidget extends InfoWidget {
  OverviewFormWidget(this.formData, this.descController, this.emailController, this.widthController,
      this.heightController, this.images, this.navigator);

  final Map<String, String> formData;
  final TextEditingController descController;
  final TextEditingController emailController;
  final TextEditingController widthController;
  final TextEditingController heightController;
  final List<Asset> images;
  final InfoNavigator navigator;

  @override
  Widget getWidget(BuildContext context) {
    formData['mentalImage'] = descController.text;
    formData['size'] = widthController.text == '' || heightController.text == ''
        ? ''
        : widthController.text + 'cm by ' + heightController.text + 'cm';

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
          flex: 12,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Row(
                children: <Widget>[
                  getLabel(context, 'Email ', formData, 'email'),
                  getData(context, formData, 'email'),
                ],
              )),
              HorizontalDivider(),
              Expanded(
                  child: Row(
                children: <Widget>[
                  getLabel(context, 'Images ', formData, 'noRefImgs'),
                  getData(context, formData, 'noRefImgs'),
                ],
              )),
              HorizontalDivider(),
              Expanded(
                  child: Row(
                children: <Widget>[
                  getLabel(context, 'Description ', formData, 'mentalImage'),
                  getData(context, formData, 'mentalImage'),
                ],
              )),
              HorizontalDivider(),
              Expanded(
                  child: Row(
                children: <Widget>[
                  getLabel(context, 'Position ', formData, 'position'),
                  getData(context, formData, 'position'),
                ],
              )),
              HorizontalDivider(),
              Expanded(
                  child: Row(
                children: <Widget>[
                  getSizeLabel(context, formData),
                  getSizeData(context, formData),
                ],
              )),
              HorizontalDivider(),
              Expanded(
                  child: Row(
                children: <Widget>[
                  getLabel(context, 'Availability ', formData, 'availability'),
                  getData(context, formData, 'availability'),
                ],
              )),
              HorizontalDivider(),
              Expanded(
                  child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Deposit: ',
                          style: Theme.of(context).accentTextTheme.subtitle,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        child: AutoSizeText('Is willing to leave a deposit',
                            style: Theme.of(context).accentTextTheme.body1),
                      )),
                ],
              )),
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
                            result: FormResult(
                          name: formData['name'],
                          email: formData['email'],
                          size: formData['size'],
                          availability: formData['availability'],
                          mentalImage: formData['mentalImage'],
                          position: formData['position'],
                          images: images,
                          artistID: int.parse(formData['artistID']),
                        )),
                      );
                      final ScreenNavigator nav = sl.get<ScreenNavigator>();
                      nav.openViewJourneysScreen(context);
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
    } else if (param == 'noRefImgs' && formData[param] == '1') {
      data = 'NEED AT LEAST 2';
    } else {
      data = formData[param];
      if (param == 'availability') {
        data = 'Provided';
      }
    }

    return Expanded(
        flex: 3,
        child: Container(
          alignment: Alignment.center,
          child: AutoSizeText(data, style: Theme.of(context).accentTextTheme.body1),
        ));
  }

  Widget getLabel(BuildContext context, String dataLabel, Map formData, String param) {
    final TextStyle style = (formData[param] == '' ||
            formData[param] == '0000000' ||
            (param == 'noRefImgs' && formData[param] == '1'))
        ? Theme.of(context).accentTextTheme.subtitle.copyWith(color: baseColors['error'])
        : Theme.of(context).accentTextTheme.subtitle;

    return Expanded(
        flex: 2,
        child: Container(
          alignment: Alignment.centerRight,
          child: Text(
            dataLabel + ': ',
            style: style,
          ),
        ));
  }

  Widget getSizeLabel(BuildContext context, Map<String, String> formData) {
    final TextStyle style = (formData['size'] == '')
        ? Theme.of(context).accentTextTheme.subtitle.copyWith(color: baseColors['error'])
        : Theme.of(context).accentTextTheme.subtitle;

    return Expanded(
        flex: 2,
        child: Container(
          alignment: Alignment.centerRight,
          child: Text(
            'Size: ',
            style: style,
          ),
        ));
  }

  Widget getSizeData(BuildContext context, Map<String, String> formData) {
    String data;

    if (formData['size'] == '') {
      data = 'MISSING';
    } else {
      data = formData['size'];
    }

    return Expanded(
        flex: 3,
        child: Container(
          alignment: Alignment.center,
          child: AutoSizeText(data, style: Theme.of(context).accentTextTheme.body1),
        ));
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
  bool valid() {
    return false;
  }
}
