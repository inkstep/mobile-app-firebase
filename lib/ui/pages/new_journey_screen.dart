import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/alert_dialog.dart';
import 'package:inkstep/ui/components/binary_input.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/ui/components/long_text_input_form_element.dart';
import 'package:inkstep/ui/components/short_text_input_form_element.dart';
import 'package:inkstep/ui/pages/new/image_grid.dart';
import 'package:inkstep/ui/pages/new/overview_form.dart';
import 'package:inkstep/utils/screen_navigator.dart';
import 'package:inkstep/ui/pages/new/size_selector.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'new/availability_selector.dart';
import 'new/position_picker_form_element.dart';

class NewJourneyScreen extends StatefulWidget {
  const NewJourneyScreen(this.artistID);

  final int artistID;

  @override
  State<StatefulWidget> createState() => _NewJourneyScreenState(artistID);
}

class _NewJourneyScreenState extends State<NewJourneyScreen> {
  _NewJourneyScreenState(this.artistID);

  final int artistID;

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
    'email': '',
    'noRefImgs': '',
    'artistID': ''
  };

  final Key _formKey = GlobalKey<FormState>();

  int get autoScrollDuration => 500;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController posController = TextEditingController();

  buttonState deposit = buttonState.Unset;

  bool mon = false;
  bool tues = false;
  bool wed = false;
  bool thurs = false;
  bool fri = false;
  bool sat = false;
  bool sun = false;

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
    return <Widget>[
      ShortTextInputFormElement(
        controller: controller,
        textController: nameController,
        label: 'What do your friends call you?',
        hint: 'Natasha',
        maxLength: 16,
      ),
      ImageGrid(
        images: inspirationImages,
        updateCallback: (images) {
          setState(() {
            inspirationImages = images;
            formData['noRefImgs'] = images.length.toString();
          });
        },
        submitCallback: FormElementBuilder(
          builder: (i, d, c) {},
          controller: controller,
          onSubmitCallback: (_) {},
        ).navToNextPage,
      ),
      LongTextInputFormElement(
        controller: controller,
        textController: descController,
        label: 'Describe the image in your head of the tattoo you want?',
        hint: 'A sleeping deer protecting a crown with stars splayed behind it',
      ),
      PositionPickerFormElement(
        controller: controller,
        formData: formData,
        textController: posController,
      ),
      SizeSelector(
        controller: controller,
        widthController: widthController,
        heightController: heightController,
      ),
      AvailabilitySelector(
        controller: controller,
        weekCallbacks: weekCallbacks,
      ),
      BinaryInput(
          label: 'Are you willing to leave a deposit?',
          controller: controller,
          currentState: deposit,
          callback: (buttonPressed) {
            setState(() {
              if (buttonPressed == 'true') {
                deposit = buttonState.True;
                controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
              } else {
                deposit = buttonState.False;
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return RoundedAlertDialog(
                        title: 'Are you sure?',
                        body: 'Most artists require a deposit in order to secure you an '
                            'appointment. Don\'t worry, you won\'t have to pay this yet!',
                        dismissButtonText: 'Ok');
                  },
                );
              }
            });
          }),
      ShortTextInputFormElement(
        controller: controller,
        textController: emailController,
        keyboardType: TextInputType.emailAddress,
        label: 'What is your email address?',
        hint: 'example@inkstep.com',
      ),
      OverviewForm(
        formData: formData,
        nameController: nameController,
        descController: descController,
        emailController: emailController,
        widthController: widthController,
        heightController: heightController,
        deposit: deposit,
        weekCallbacks: weekCallbacks,
        images: inspirationImages,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    formData['artistID'] = artistID.toString();
    final SingleDayCallbacks monday = SingleDayCallbacks((switched) {
      setState(() {
        mon = switched;
      });
    }, () {
      return mon;
    });
    final SingleDayCallbacks tuesday = SingleDayCallbacks((switched) {
      setState(() {
        tues = switched;
      });
    }, () {
      return tues;
    });
    final SingleDayCallbacks wednesday = SingleDayCallbacks((switched) {
      setState(() {
        wed = switched;
      });
    }, () {
      return wed;
    });
    final SingleDayCallbacks thursday = SingleDayCallbacks((switched) {
      setState(() {
        thurs = switched;
      });
    }, () {
      return thurs;
    });
    final SingleDayCallbacks friday = SingleDayCallbacks((switched) {
      setState(() {
        fri = switched;
      });
    }, () {
      return fri;
    });
    final SingleDayCallbacks saturday = SingleDayCallbacks((switched) {
      setState(() {
        sat = switched;
      });
    }, () {
      return sat;
    });
    final SingleDayCallbacks sunday = SingleDayCallbacks((switched) {
      setState(() {
        sun = switched;
      });
    }, () {
      return sun;
    });
    final WeekCallbacks weekCallbacks =
        WeekCallbacks(monday, tuesday, wednesday, thursday, friday, saturday, sunday);

    final Form form = Form(
      key: _formKey,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.clear),
            tooltip: 'Exit',
            onPressed: () {
              final nav = sl.get<ScreenNavigator>();
              nav.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: Theme.of(context).accentIconTheme,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.keyboard_arrow_up),
                tooltip: 'Previous question',
                onPressed: () {
                  if (controller.page != 0) {
                    controller.previousPage(
                        duration: Duration(milliseconds: 500), curve: Curves.ease);
                  }
                }),
            IconButton(
                icon: Icon(Icons.keyboard_arrow_down),
                tooltip: 'Next question',
                onPressed: () {
                  if (controller.page != _formQuestions(weekCallbacks).length - 1) {
                    controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  }
                }),
          ],
        ),
        body: PageView(
          controller: controller,
          scrollDirection: Axis.vertical,
          children: _formQuestions(weekCallbacks),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: _onWillPop,
      child: form,
    );
  }
}
