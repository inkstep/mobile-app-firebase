import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journey_bloc.dart';
import 'package:inkstep/blocs/journey_event.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/main.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/ui/components/logo.dart';
import 'package:inkstep/ui/components/long_text_input.dart';
import 'package:inkstep/ui/components/short_text_input.dart';
import 'package:inkstep/utils/screen_navigator.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class NewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  _NewScreenState() {
    for (var key in formFields) {
      formData.putIfAbsent(key, () => '');
    }
  }

  final PageController controller = PageController(
    initialPage: 0,
  );

  List<String> formFields = ['name', 'email', 'mentalImage', 'position', 'size',
    'availability', 'deposit', 'email'];

  Map<String, String> formData = Map();

  final dynamic formKey = GlobalKey<FormState>();
  int get autoScrollDuration => 500;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
              ShortTextInput(
                controller: controller,
                callback: (text) {
                  formData["name"] = text;
                },
                label: 'What do your friends call you?',
                hint: 'Natasha',
                input: formData["name"],
                maxLength: 16,
              ),
              InspirationImages(
                controller: controller,
              ),
              LongTextInput(
                controller: controller,
                label:
                    'Describe the image in your head of the tattoo you want?',
                hint:
                    'A sleeping deer protecting a crown with stars splayed behind it',
                callback: (term) {
                  formData["mentalImage"] = term;
                },
              ),
              ShortTextInput(
                controller: controller,
                label: 'Where on your body do you want the tattoo',
                hint: 'Lower left forearm',
                callback: (term) {
                  formData["position"] = term;
                },
              ),
              ShortTextInput(
                controller: controller,
                label: 'How big would you like your tattoo to be?(cm)',
                hint: '7x3',
                callback: (text) {
                  formData["size"] = text;
                },
              ),
              ShortTextInput(
                controller: controller,
                label: 'What days of the week are you normally available?',
                hint: 'Mondays, Tuesdays and Saturdays',
                callback: (text) {
                  formData["availability"] = text;
                },
              ),
              ShortTextInput(
                controller: controller,
                label: 'Are you happy to leave a deposit?',
                hint: 'Yes!',
                callback: (text) {
                  formData["deposit"] = text;
                },
              ),
              ShortTextInput(
                controller: controller,
                label: 'What is your email address?',
                hint: 'example@inkstep.com',
                callback: (text) {
                  formData["email"] = text;
                },
              ),
              RaisedButton(
                onPressed: () {
                  bool missingParams = false;

                  String missing = "";

                  for (var key in formData.keys) {
                    if (formData[key] == '') {
                      missingParams = true;

                      if (missing == "") {
                        missing = key;
                      } else {
                        missing += ", " + key;
                      }
                    }
                  }

                  if (missingParams) {
                    final snackbar = SnackBar(
                      content: Text(
                        "You still need to provide us with " + missing,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      backgroundColor: Theme.of(context).backgroundColor,
                    );

                    _scaffoldKey.currentState.showSnackBar(snackbar);
                  } else {
                    final JourneyBloc journeyBloc =
                    BlocProvider.of<JourneyBloc>(context);
                    journeyBloc.dispatch(
                      AddJourney(
                        Journey(
                          // TODO(DJRHails): Don't hardcode these
                          artistName: 'Ricky',
                          studioName: 'South City Market',
                          name: formData["name"],
                          size: formData["size"],
                          email: formData["email"],
                          availability: formData["availability"],
                          deposit: formData["deposit"],
                          mentalImage: formData["mentalImage"],
                          position: formData["position"],
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
}

class InspirationImages extends StatefulWidget {
  const InspirationImages({Key key, this.controller, this.autoScrollDuration})
      : super(key: key);

  final PageController controller;
  final int autoScrollDuration;

  @override
  State<StatefulWidget> createState() =>
      _InspirationImagesState(controller, autoScrollDuration);
}

class _InspirationImagesState extends State<StatefulWidget> {
  _InspirationImagesState(this.controller, this.autoScrollDuration);

  final PageController controller;
  final int autoScrollDuration;

  List<Asset> images = <Asset>[];

  // ignore: unused_field
  String _error;

  Widget buildImageThumbnail(int i, double size) {
    Widget inner;
    if (i < images.length) {
      final Asset asset = images[i];
      inner = Container(
        decoration: BoxDecoration(
          border: Border.all(),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 3,
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
        color: baseColors['dark'],
      );
    }
    return Container(
      margin: EdgeInsets.all(8.0),
      width: size,
      height: size,
      child: InkWell(
        child: inner,
        onTap: updateAssets,
      ),
    );
  }

  Future<void> updateAssets() async {
    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 6, selectedAssets: images);
    } on PlatformException catch (e) {
      setState(() {
        _error = e.message;
      });
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double thumbSizeFactor = images.length > 1 ? 0.18 : 0.2;
    final double thumbSize =
        MediaQuery.of(context).size.height * thumbSizeFactor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Show us your inspiration',
              style: Theme.of(context).accentTextTheme.title,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: <Widget>[
                  Text(
                    "Choose some reference images, showing what you want. You'll get to talk about these later.",
                    style: Theme.of(context).accentTextTheme.subhead,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildImageThumbnail(0, thumbSize),
                  buildImageThumbnail(1, thumbSize)
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildImageThumbnail(2, thumbSize),
                  buildImageThumbnail(3, thumbSize)
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildImageThumbnail(4, thumbSize),
                  buildImageThumbnail(5, thumbSize)
                ]),
          ],
        ),
        images.length > 1
            ? RaisedButton(
                child: Text('That enough?'),
                onPressed: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: autoScrollDuration),
                      curve: Curves.ease);
                },
              )
            : Container(),
      ],
    );
  }
}
