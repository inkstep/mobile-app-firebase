import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/binary_input.dart';
import 'package:inkstep/ui/pages/new/availability_screen.dart';
import 'package:inkstep/ui/pages/new/deposit_screen.dart';
import 'package:inkstep/ui/pages/new/description_screen.dart';
import 'package:inkstep/ui/pages/new/help_screen.dart';
import 'package:inkstep/ui/pages/new/image_screen.dart';
import 'package:inkstep/ui/pages/new/overview_form.dart';
import 'package:inkstep/ui/pages/new/position_picker_screen.dart';
import 'package:inkstep/ui/pages/new/size_screen.dart';
import 'package:inkstep/ui/routes/fade_page_route.dart';
import 'package:inkstep/ui/routes/slide_exit_enter_route.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class InfoNavigator {
  InfoNavigator(int artistId) {
    descController = TextEditingController();
    widthController = TextEditingController();
    heightController = TextEditingController();
    emailController = TextEditingController(text: 'james.dalboth@gmail.com');
    inspirationImages = [];
    formData['artistID'] = artistId.toString();
  }

  TextEditingController descController;
  TextEditingController widthController;
  TextEditingController heightController;
  TextEditingController emailController;
  List<Asset> inspirationImages;

  Map<String, String> formData = {
    'name': '',
    'email': '',
    'mentalImage': '',
    'position': '',
    'generalPos': '',
    'size': '',
    'availability': '',
    'deposit': '',
    'email': '',
    'noRefImgs': '',
    'artistID': ''
  };

  int screenNum = 0;

  // TODO(DJRHails): Style
  // Most artists do more than one style, while many develop their own style
  // by combining two or more existing ones. And some experimental artists who
  // like to push the boundaries often go on to create new styles entirely!

  // It's worth selecting what style of tattoo you like so that artists knows what's involved
  // for them

  Widget getScreen(int screenNum) {
    switch (screenNum) {
      case 0:
        return HelpScreen(
          navigator: this,
          help: 'We want to help you provide the tattoo artist with the exact info they need! \n\n'
              "In a few moments we're going to ask you for some reference images, size information, "
              "position info and more!\n\nDon't worry!\nAll of this info is easy to get! The "
              "first thing we're going to ask you for though is for a brief description about what "
              "you want! \n\nLet's go!",
        );
      case 1:
        return DescriptionScreen(
          descController: descController,
          navigator: this,
        );
      case 2:
        return HelpScreen(
          navigator: this,
          help: 'Oohhh, that tattoo sounds nice!\n\nA description goes a long way in helping the '
              'artist know the motivation for your tattoo and the kind of thing you want!'
              '\nAnother great way to help the artist is to provide a few reference images!\n'
              '\nGo online and find a few images that you think capture the kind of tattoo you '
              "want to get!\n\nDone that? Let's go!"
        );
      case 3:
        return ImageScreen(
          images: inspirationImages,
          navigator: this,
          callback: (images) {
            inspirationImages = images;
            formData['noRefImgs'] = inspirationImages.length.toString();
          },
        );
      case 4:
        return HelpScreen(
            navigator: this,
            help: 'Wow those images look great! \n\nYour tattoo artist definitely knows the kind'
                ' of thing you want now!\n\nThe next thing we want to work out is where is it '
                "going to go?\nThere's a whole variety of places it could go and all of them "
                'matter to the artist, different positions have different types of skin, and '
                'surfaces and can dramatically influence the kind of tattoo job that needs to be '
                "done!\nLet us help you out with specifying exactly where it needs to go, Let's go!"
        );
      case 5:
        return PositionPickerScreen(
          formData: formData,
          callback: (pos, genPos) {
            formData['position'] = pos;
            formData['generalPos'] = genPos;
          },
          navigator: this,
        );
      case 6:
        return HelpScreen(
          navigator: this,
          help: 'This is going great!\n\nNow your artist knows what you want and where you want '
              "it!\nNext let's supply the artist with a nice size! Sizing is one of the most "
              'important factors in doing a tattoo, artists really like to know accurate sizings '
              'going in the job because even a small change in size can lead to dramatically '
              'different times and prices!\nA good way to solve this issue is to go away and '
              'get someone to draw with a pencil a rough shape with the size you want. Once you '
              "have that, grab a ruler get measuring!\nReady? Let's go!",
        );
      case 7:
        return SizeSelectorScreen(
          heightController: heightController,
          widthController: widthController,
          navigator: this,
        );
      case 8:
        return HelpScreen(
          navigator: this,
          help: 'Fantastic!\n\nAt this stage the artist has all the information they need about '
              'the tattoo!\n\nA few questions remain however about you!\nTattoo artists are super'
              ' busy and end up booking months in advanced!\nThis does making booking quiet hard '
              'unfornately\nInstead of given an exact date, say what days your usually free on '
              "and the artist will find a date on one of those days for you\nLet's go!",
        );
      case 9:
        return AvailabilityScreen(
          navigator: this,
          callback: (List<bool> avail) {
            formData['availability'] = '';
            for (bool b in avail) {
              formData['availability'] += b ? '1' : '0';
            }
          },
          avail: formData['availability'],
        );
      case 10:
        return HelpScreen(
          navigator: this,
          help: "Phew! Getting tired? Getting a tattoo isn't a quick job and needs a lot of "
              "thought about, but don't worry! Almost done!\n\nTattoo artists want to make sure "
              "they aren't going to waste a booking slot, they rely heavily on clients turning up"
              ' to the session! it is for this reason they ask for a deposit, please understand a'
              ' tattoo artist is unlikely to accept your job if your not willing to leave a '
              "deposit\nLet's go!",
        );
      case 11:
        return DepositScreen(
          navigator: this,
          deposit: formData['deposit'],
          callback: (buttonState state) {
            if (state == buttonState.True) {
              formData['deposit'] = '1';
            } else if (state == buttonState.False) {
              formData['deposit'] = '0';
            } else if (state == buttonState.Unset) {
              formData['deposit'] = '';
            }
          },
        );
      case 12:
        return OverviewForm(
          emailController: emailController,
          heightController: heightController,
          widthController: widthController,
          descController: descController,
          formData: formData,
          images: inspirationImages,
          navigator: this,
        );
      default:
        return null;
    }
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }

  void start(BuildContext context) {
    screenNum = 0;

    Navigator.pushReplacement<dynamic, dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => getScreen(screenNum)),
    );
  }

  void next(BuildContext context, Widget exitScreen) {
    screenNum++;
    Navigator.pushReplacement<dynamic, dynamic>(
      context,
      FadeRoute(page: getScreen(screenNum)),
    );
  }

  void back(BuildContext context, Widget exitScreen) {
    if (screenNum == 0) {
      return;
    }

    screenNum--;
    Navigator.pushReplacement<dynamic, dynamic>(
      context,
      FadeRoute(page: getScreen(screenNum)),
    );
  }
}
