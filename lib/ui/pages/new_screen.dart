import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/main.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/ui/components/dropdown_menu.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/ui/components/inspiration_images.dart';
import 'package:inkstep/ui/components/binary_input.dart';
import 'package:inkstep/ui/components/logo.dart';
import 'package:inkstep/ui/components/long_text_input_form_element.dart';
import 'package:inkstep/ui/components/short_text_input.dart';
import 'package:inkstep/ui/components/short_text_input_form_element.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class NewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final PageController controller = PageController(
    initialPage: 0,
  );

  Map<String, String> formData = {
    'name': '',
    'email': '',
    'mentalImage': '',
    'position': '',
    'size': '',
    'availability': '',
    'deposit': '',
    'email': ''
  };

  bool mon = false;
  bool tues = false;
  bool wed = false;
  bool thurs = false;
  bool fri = false;
  bool sat = false;
  bool sun = false;

  final dynamic formKey = GlobalKey<FormState>();

  int get autoScrollDuration => 500;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();


  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    SingleDayCallbacks monday = SingleDayCallbacks((switched) {mon = switched;},
            () {return mon;});
    SingleDayCallbacks tuesday = SingleDayCallbacks((switched) {tues = switched;},
            () {return tues;});
    SingleDayCallbacks wednesday = SingleDayCallbacks((switched) {wed = switched;},
            () {return wed;});
    SingleDayCallbacks thursday = SingleDayCallbacks((switched) {mon = switched;},
            () {return mon;});
    SingleDayCallbacks friday = SingleDayCallbacks((switched) {fri = switched;},
            () {return fri;});
    SingleDayCallbacks saturday = SingleDayCallbacks((switched) {sat = switched;},
            () {return sat;});
    SingleDayCallbacks sunday = SingleDayCallbacks((switched) {sun = switched;},
            () {return sun;});
    WeekCallbacks weekCallbacks = WeekCallbacks(monday, tuesday, wednesday, thursday,
        friday, saturday, sunday);

    return Form(
        key: formKey,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBar(
            title: Hero(
              tag: 'logo',
              child: LogoWidget(),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            iconTheme: Theme.of(context).accentIconTheme,
          ),
          body: PageView(
            controller: controller,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              ShortTextInputFormElement(
                controller: controller,
                textController: nameController,
                label: 'What do your friends call you?',
                hint: 'Natasha',
                maxLength: 16,
              ),
              InspirationImages(
                controller: controller,
              ),
              LongTextInputFormElement(
                controller: controller,
                textController: descController,
                label:
                    'Describe the image in your head of the tattoo you want?',
                hint:
                    'A sleeping deer protecting a crown with stars splayed behind it',
              ),
              PositionPickerFormElement(
                controller: controller,
                formData: formData,
              ),
              ShortTextInputFormElement(
                controller: controller,
                textController: sizeController,
                label: 'How big would you like your tattoo to be?(cm)',
                hint: '7x3',
              ),
              AvailabilitySelector(
                controller: controller,
                weekCallbacks: weekCallbacks,
              ),
              BinaryInput(
                controller: controller,
                label: 'Are you happy to leave a deposit?',
                callback: (text) {
                  formData['deposit'] = text;
                },
              ),
              ShortTextInputFormElement(
                controller: controller,
                textController: emailController,
                label: 'What is your email address?',
                hint: 'example@inkstep.com',
              ),
              RaisedButton(
                onPressed: () {
                  bool missingParams = false;

                  formData['name'] = nameController.text;
                  formData['mentalImage'] = descController.text;
                  formData['email'] = emailController.text;
                  formData['size'] = sizeController.text;
                  formData['availability'] = getAvailability(weekCallbacks);
                  print(formData['availability']);
                  String missing = '';

                  for (var key in formData.keys) {
                    if (formData[key] == '') {
                      missingParams = true;

                      if (missing == '') {
                        missing = key;
                      } else {
                        missing += ', ' + key;
                      }
                    }
                  }

                  if (missingParams) {
                    final snackbar = SnackBar(
                      content: Text(
                        'You still need to provide us with ' + missing,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      backgroundColor: Theme.of(context).backgroundColor,
                    );

                    _scaffoldKey.currentState.showSnackBar(snackbar);
                  } else {
                    final JourneysBloc journeyBloc =
                        BlocProvider.of<JourneysBloc>(context);
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
                  }
                },
                elevation: 15.0,
                color: baseColors['dark'],
                textColor: baseColors['light'],
                padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Text(
                  "Let's contact your artist!",
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Signika'),
                ),
              )
            ],
          ),
        ));
  }

  String getAvailability(WeekCallbacks weekCallbacks) {
    String availability ='';
    if(mon){
      availability = availability + '1';
    } else {
      availability = availability + '0';
    }
    if(tues){
      availability = availability + '1';
    } else {
      availability = availability + '0';
    }
    if(wed){
      availability = availability + '1';
    } else {
      availability = availability + '0';
    }
    if(thurs){
      availability = availability + '1';
    } else {
      availability = availability + '0';
    }
    if(fri){
      availability = availability + '1';
    } else {
      availability = availability + '0';
    }
    if(sat){
      availability = availability + '1';
    } else {
      availability = availability + '0';
    }
    if(sun){
      availability = availability + '1';
    } else {
      availability = availability + '0';
    }
    return availability;
  }
}

class PositionPickerFormElement extends StatefulWidget {
  const PositionPickerFormElement(
      {Key key, @required this.controller, @required this.formData})
      : super(key: key);

  final PageController controller;
  final Map formData;

  @override
  State<StatefulWidget> createState() =>
      _PositionPickerFormElementState(controller, formData);
}

class _PositionPickerFormElementState extends State<StatefulWidget> {
  _PositionPickerFormElementState(this.controller, this.formData) {
    positions = {
      'Leg': ['Lower Leg', 'Calf'],
      'Arm': ['Inner Wrist', 'Inner Arm', 'Biceps', 'Upper Arm', 'Side'],
      'Chest': ['Full Front Chest', 'Pec', 'Ribs'],
      'Foot': ['Ankle'],
      'Head': ['Inner Ear', 'Behind Ear'],
      'Hand': ['Fingers'],
      'Back': ['Back', 'Shoulders', 'Neck'],
      'Other': [],
    };
  }

  final PageController controller;
  final Map formData;

  String generalPos;

  Map<String, List<String>> positions;

  @override
  Widget build(BuildContext context) {
    return FormElementBuilder(
      builder: (context, focus, onSubmitCallback) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                  flex: generalPos == 'Other' ? 10 : 4,
                  child: Text(
                    'Where would you like your tattoo? (Arm, leg,'
                        ' etc)',
                    style: Theme
                        .of(context)
                        .accentTextTheme
                        .title,
                    textAlign: TextAlign.center,
                  )),
              Spacer(flex: 1),
              Flexible(
                flex: generalPos == 'Other' ? 10 : 3,
                child: DropdownMenu(
                  hintText: generalPos == null ? 'General Area' : generalPos,
                  callback: (value) {
                    setState(() {
                      generalPos = value;
                      formData['position'] = null;
                    });
                  },
                  items: positions.keys.toList(),
                ),
              ),
              Spacer(flex: 1),
              generalPos == 'Other'
                  ? Spacer(flex: 1)
                  : Flexible(
                flex: 2,
                child: Text(
                  'Specifics...',
                  style: Theme
                      .of(context)
                      .accentTextTheme
                      .title,
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(flex: 1),
              Flexible(
                flex: generalPos == 'Other' ? 30 : 4,
                child: Container(
                  child: generalPos == 'Other'
                      ? ShortTextInput(
                    controller: null,
                    label: 'Specific Area',
                    hint: '...',
                    maxLength: 20,
                    callback: onSubmitCallback,
                  )
                      : DropdownMenu(
                    hintText: formData['position'] == null
                        ? 'Specifc Area'
                        : formData['position'],
                    callback: onSubmitCallback,
                    items:
                    generalPos == null ? [] : positions[generalPos],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      onSubmitCallback: (value) {
        setState(() {
          formData['position'] = value;
        });
      },
      controller: controller,
    );
  }
}

class AvailabilitySelector extends StatelessWidget {

  const AvailabilitySelector({
    Key key,
    @required this.controller,
    this.duration = 500,
    @required this.weekCallbacks})
      : super(key: key);

  final PageController controller;
  final int duration;
  final WeekCallbacks weekCallbacks;


  Widget build(BuildContext context) {
    return FormElementBuilder(
        builder: (context, focus, onSubmitCallback) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'What days are you normally available?',
                        style: Theme
                            .of(context)
                            .accentTextTheme
                            .title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _buildSwitch(context, weekCallbacks.monday, 'Mon: '),
                                _buildSwitch(context, weekCallbacks.tuesday, 'Tues: '),
                                _buildSwitch(context, weekCallbacks.wednesday, 'Wed: '),
                                _buildSwitch(context, weekCallbacks.thursday, 'Thurs: '),
                                _buildSwitch(context, weekCallbacks.friday, 'Fri:'),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _buildSwitch(context, weekCallbacks.saturday, 'Sat:'),
                                _buildSwitch(context, weekCallbacks.sunday, 'Sun:'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text('Faked Padding'),
                    ),
                    Expanded(
                      child: Text(
                        'Note: You have to slide these switches, not just tap on them!',
                        style: Theme
                            .of(context)
                            .accentTextTheme
                            .title,
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.75,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        controller.nextPage(duration: Duration(milliseconds: duration),
                        curve: Curves.ease);
                      },
                      elevation: 15.0,
                      padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      child: Text('Next!', style: TextStyle(fontSize: 20.0, fontFamily: 'Signika'),
                  ),
                ),
              ],

            ),
          )])
          );
        }
    );
  }

  Widget _buildSwitch(BuildContext context, SingleDayCallbacks dayCallbacks,String day) {
    bool initial = dayCallbacks.currentValue();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(day, style: Theme.of(context).accentTextTheme.title,),

        Switch(
          value: initial,
          onChanged: dayCallbacks.onSwitched,
          inactiveTrackColor: Theme.of(context).primaryColor,
        ),
      ],
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

class SingleDayCallbacks{
  SingleDayCallbacks(this.onSwitched, this.currentValue);

  final BoolCallback onSwitched;
  final bool Function() currentValue;
}
