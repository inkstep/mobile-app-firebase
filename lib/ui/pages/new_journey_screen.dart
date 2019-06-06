import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/alert_dialog.dart';
import 'package:inkstep/ui/components/binary_input.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/ui/components/logo.dart';
import 'package:inkstep/ui/components/long_text_input_form_element.dart';
import 'package:inkstep/ui/components/short_text_input_form_element.dart';
import 'package:inkstep/ui/pages/new/image_grid.dart';
import 'package:inkstep/ui/pages/new/overview_form.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'new/availability_selector.dart';
import 'new/position_picker_form_element.dart';

class NewJourneyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewJourneyScreenState();
}

class _NewJourneyScreenState extends State<NewJourneyScreen> {
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

  final Key _formKey = GlobalKey<FormState>();

  int get autoScrollDuration => 500;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
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
      Navigator.of(context).pop();
    }
    controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    final SingleDayCallbacks monday = SingleDayCallbacks((switched) {
      mon = switched;
    }, () {
      return mon;
    });
    final SingleDayCallbacks tuesday = SingleDayCallbacks((switched) {
      tues = switched;
    }, () {
      return tues;
    });
    final SingleDayCallbacks wednesday = SingleDayCallbacks((switched) {
      wed = switched;
    }, () {
      return wed;
    });
    final SingleDayCallbacks thursday = SingleDayCallbacks((switched) {
      thurs = switched;
    }, () {
      return thurs;
    });
    final SingleDayCallbacks friday = SingleDayCallbacks((switched) {
      fri = switched;
    }, () {
      return fri;
    });
    final SingleDayCallbacks saturday = SingleDayCallbacks((switched) {
      sat = switched;
    }, () {
      return sat;
    });
    final SingleDayCallbacks sunday = SingleDayCallbacks((switched) {
      sun = switched;
    }, () {
      return sun;
    });
    final WeekCallbacks weekCallbacks =
        WeekCallbacks(monday, tuesday, wednesday, thursday, friday, saturday, sunday);

    Form form = Form(
      key: _formKey,
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
            ImageGrid(
              images: inspirationImages,
              updateCallback: (images) {
                setState(() {
                  inspirationImages = images;
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
                label: 'Are you willing to leave a deposit?',
                controller: controller,
                currentState: deposit,
                callback: (buttonPressed) {
                  setState(() {
                    if (buttonPressed == 'true') {
                      deposit = buttonState.True;
                      controller.nextPage(
                          duration: Duration(milliseconds: 500), curve: Curves.ease);
                    } else {
                      deposit = buttonState.False;
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          // TODO(Felination): Replace this with useful text
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
              label: 'What is your email address?',
              hint: 'example@inkstep.com',
            ),
            OverviewForm(
              formData: formData,
              nameController: nameController,
              descController: descController,
              emailController: emailController,
              sizeController: sizeController,
              deposit: deposit,
              weekCallbacks: weekCallbacks,
              images: inspirationImages,
            )
          ],
        ),
      ),
    );

    return WillPopScope(
      onWillPop: _onWillPop,
      child: form,
    );
  }
}
