import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/blocs/journeys_state.dart';
import 'package:inkstep/ui/components/binary_input.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'new/availability_screen.dart';

class NewJourneyScreen extends StatefulWidget {
  const NewJourneyScreen(this.artistID);

  final int artistID;

  @override
  State<StatefulWidget> createState() => _NewJourneyScreenState(artistID);
}

class _NewJourneyScreenState extends State<NewJourneyScreen> {
  _NewJourneyScreenState(this.artistID);

  final int artistID;

  PageController controller = PageController(initialPage: 0);

  Map<String, String> formData = {
    'name': '',
    'email': '',
    'mentalImage': '',
    'position': '',
    'size': '',
    'availability': '',
    'deposit': '',
    'email': '',
    'noRefImgs': '',
    'artistID': ''
  };

  final Key _formKey = GlobalKey<FormState>();

  int get autoScrollDuration => 500;

  final TextEditingController descController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController posController = TextEditingController();

  buttonState deposit = buttonState.Unset;

  List<bool> availability = List.filled(7, false);

  List<Asset> inspirationImages = <Asset>[];

  // ignore: unused_field
  String _imagesError;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    posController.addListener(() {
      setState(() {
        formData['position'] = posController.text;
      });
    });
  }

  Future<bool> _onWillPop() {
    if (controller.page == 0) {
      return Future.value(true);
    }

    controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
    return Future.value(false);
  }

  List<Widget> _formQuestions(dynamic weekCallbacks) {
    return [];
  }

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
    formData['artistID'] = artistID.toString();

    final WeekCallbacks weekCallbacks = WeekCallbacks([
      callbackForDay(0),
      callbackForDay(1),
      callbackForDay(2),
      callbackForDay(3),
      callbackForDay(4),
      callbackForDay(5),
      callbackForDay(6)
    ]);

    final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);

    final Form form = Form(
        key: _formKey,
        child: BlocBuilder<JourneysEvent, JourneysState>(
            bloc: journeyBloc,
            builder: (BuildContext context, JourneysState state) {
              if (state is JourneysWithUser) {
                formData['name'] = state.user.name;
              } else {
                throw StateError('A new user should not have made it here');
              }
              final List<Widget> formWidgets = _formQuestions(weekCallbacks);

              return Scaffold(
                key: _scaffoldKey,
                backgroundColor: Theme.of(context).cardColor,
                resizeToAvoidBottomPadding: false,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  iconTheme: Theme.of(context).accentIconTheme,
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.keyboard_arrow_up),
                        tooltip: 'Previous question',
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (controller.page != 0) {
                            controller.previousPage(
                                duration: Duration(milliseconds: 500), curve: Curves.ease);
                          }
                        }),
                    IconButton(
                        icon: Icon(Icons.keyboard_arrow_down),
                        tooltip: 'Next question',
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (controller.page != formWidgets.length - 1) {
                            controller.nextPage(
                                duration: Duration(milliseconds: 500), curve: Curves.ease);
                          }
                        }),
                  ],
                ),
                body: PageView(
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  children: formWidgets,
                ),
              );
            }));

    return WillPopScope(
      onWillPop: _onWillPop,
      child: form,
    );
  }
}
