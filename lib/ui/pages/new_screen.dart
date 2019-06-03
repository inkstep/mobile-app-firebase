import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/ui/components/binary_input.dart';
import 'package:inkstep/ui/components/bold_call_to_action.dart';
import 'package:inkstep/ui/components/dropdown_menu.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/ui/components/logo.dart';
import 'package:inkstep/ui/components/long_text_input_form_element.dart';
import 'package:inkstep/ui/components/short_text_input.dart';
import 'package:inkstep/ui/components/short_text_input_form_element.dart';
import 'package:inkstep/utils/screen_navigator.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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

  final Key _formKey = GlobalKey<FormState>();

  int get autoScrollDuration => 500;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  List<Asset> inspirationImages = <Asset>[];
  // ignore: unused_field
  String _imagesError;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
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
            _buildImageGrid(context),
            LongTextInputFormElement(
              controller: controller,
              textController: descController,
              label: 'Describe the image in your head of the tattoo you want?',
              hint: 'A sleeping deer protecting a crown with stars splayed behind it',
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
            ShortTextInputFormElement(
              controller: controller,
              textController: null,
              label: 'What days of the week are you normally available?',
              hint: 'Mondays, Tuesdays and Saturdays',
              // TODO(Felination): Refactor availability to 'pills' rather than text input
              onSubmitCallback: (term) {
                formData['availability'] = term;
              },
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
            ContactForm(
              formData: formData,
              nameController: nameController,
              descController: descController,
              emailController: emailController,
              sizeController: sizeController,
              scaffoldKey: _scaffoldKey,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Show us your inspiration',
          style: Theme.of(context).accentTextTheme.title,
        ),
        Spacer(),
        Expanded(
          child: AutoSizeText(
            "Choose some reference images, showing what you want. You'll get to talk about these later.",
            style: Theme.of(context).accentTextTheme.subhead,
            textAlign: TextAlign.center,
          ),
          flex: 10,
        ),
        Spacer(flex: 2),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraint) {
              const double thumbNoWidth = 2;
              const double thumbNoHeight = 3;
              const double thumbSizeFactor = 0.9;
              final double thumbHeight =
                  constraint.maxHeight * thumbSizeFactor * (1 / thumbNoHeight);
              final double thumbWidth = constraint.maxWidth * thumbSizeFactor * (1 / thumbNoWidth);
              final double thumbSize = min(thumbHeight, thumbWidth);

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildImageThumbnail(0, thumbSize),
                      _buildImageThumbnail(1, thumbSize)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildImageThumbnail(2, thumbSize),
                      _buildImageThumbnail(3, thumbSize)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildImageThumbnail(4, thumbSize),
                      _buildImageThumbnail(5, thumbSize)
                    ],
                  ),
                ],
              );
            },
          ),
          flex: 60,
        ),
        inspirationImages.length > 1
            ? Expanded(
                child: Center(
                  child: RaisedButton(
                    child: Text('That enough?'),
                    onPressed: () {
                      controller.nextPage(
                          duration: Duration(milliseconds: autoScrollDuration), curve: Curves.ease);
                    },
                  ),
                ),
                flex: 10,
              )
            : Container(),
      ],
    );
  }

  Widget _buildImageThumbnail(int i, double size) {
    Widget inner;
    if (i < inspirationImages.length) {
      final Asset asset = inspirationImages[i];
      inner = Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 10,
              offset: Offset(-1, 1),
            )
          ],
        ),
        child: AssetThumb(
          asset: asset,
          width: size.floor(),
          height: size.floor(),
        ),
      );
    } else {
      inner = Icon(
        Icons.add,
        size: 60.0,
        color: Theme.of(context).accentIconTheme.color,
      );
    }
    return Container(
      width: size,
      height: size,
      child: InkWell(
        child: inner,
        onTap: _updateAssets,
      ),
    );
  }

  Future<void> _updateAssets() async {
    List<Asset> resultList;

    try {
      resultList =
          await MultiImagePicker.pickImages(maxImages: 6, selectedAssets: inspirationImages);
    } on PlatformException catch (e) {
      setState(() {
        _imagesError = e.message;
      });
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      inspirationImages = resultList;
    });
  }
}

class ContactForm extends StatelessWidget {
  const ContactForm({
    Key key,
    @required this.formData,
    @required this.nameController,
    @required this.descController,
    @required this.emailController,
    @required this.sizeController,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final Map<String, String> formData;
  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController emailController;
  final TextEditingController sizeController;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    formData['name'] = nameController.text;
    formData['mentalImage'] = descController.text;
    formData['email'] = emailController.text;
    formData['size'] = sizeController.text;

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

    return false;
  }

  Widget getData(BuildContext context, Map formData, String param) {
    String data;

    if (formData[param] == '') {
      data = 'MISSING';
    } else {
      data = formData[param];
    }

    return Expanded(
      flex: 1,
      child: AutoSizeText(data, style: Theme.of(context).accentTextTheme.body1),
    );
  }

  Widget getLabel(BuildContext context, String dataLabel, Map formData, String param) {
    final TextStyle style = formData[param] == ''
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
}

class PositionPickerFormElement extends StatefulWidget {
  const PositionPickerFormElement({Key key, @required this.controller, @required this.formData})
      : super(key: key);

  final PageController controller;
  final Map formData;

  @override
  State<StatefulWidget> createState() => _PositionPickerFormElementState(controller, formData);
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
                    style: Theme.of(context).accentTextTheme.title,
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
                        style: Theme.of(context).accentTextTheme.title,
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
                          callback: (term) {},
                        )
                      : DropdownMenu(
                          hintText:
                              formData['position'] == null ? 'Specifc Area' : formData['position'],
                          callback: onSubmitCallback,
                          items: generalPos == null ? [] : positions[generalPos],
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
