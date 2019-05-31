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
  final PageController controller = PageController(
    initialPage: 0,
  );

  String name, mentalImage, size, email, availability, deposit, position;
  final dynamic formKey = GlobalKey<FormState>();
  int get autoScrollDuration => 500;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Scaffold(
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
                label: 'What do your friends call you?',
                hint: 'Natasha',
                input: name,
                maxLength: 16,
                callback: (text) {
                  name = text;
                },
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
                input: mentalImage,
                callback: (term) {
                  mentalImage = term;
                },
              ),
              ShortTextInput(
                controller: controller,
                label: 'Where on your body do you want the tattoo',
                hint: 'Lower left forearm',
                input: position,
                callback: (term) {
                  position = term;
                },
              ),
              ShortTextInput(
                controller: controller,
                label: 'How big would you like your tattoo to be?(cm)',
                hint: '7x3',
                input: size,
                callback: (text) {
                  size = text;
                },
              ),
              ShortTextInput(
                controller: controller,
                label: 'What days of the week are you normally available?',
                hint: 'Mondays, Tuesdays and Saturdays',
                input: availability,
                callback: (text) {
                  availability = text;
                },
              ),
              ShortTextInput(
                controller: controller,
                label: 'Are you happy to leave a deposit?',
                hint: 'Yes!',
                input: deposit,
                callback: (text) {
                  deposit = text;
                },
              ),
              ShortTextInput(
                controller: controller,
                label: 'What is your email address?',
                hint: 'example@inkstep.com',
                input: email,
                callback: (text) {
                  email = text;
                },
              ),
              RaisedButton(
                onPressed: () {
                  final JourneyBloc journeyBloc =
                      BlocProvider.of<JourneyBloc>(context);
                  journeyBloc.dispatch(
                    AddJourney(
                      Journey(
                        // TODO(DJRHails): Don't hardcode these
                        artistName: 'Ricky',
                        studioName: 'South City Market',
                        name: name,
                        size: size,
                        email: email,
                        availability: availability,
                        deposit: deposit,
                        mentalImage: mentalImage,
                        position: position,
                      ),
                    ),
                  );
                  final ScreenNavigator nav = sl.get<ScreenNavigator>();
                  nav.openJourneyScreen(context);
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
