import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/binary_input.dart';
import 'package:inkstep/ui/pages/new/availability_screen.dart';
import 'package:inkstep/ui/pages/new/deposit_screen.dart';
import 'package:inkstep/ui/pages/new/description_screen.dart';
import 'package:inkstep/ui/pages/new/email_screen.dart';
import 'package:inkstep/ui/pages/new/image_screen.dart';
import 'package:inkstep/ui/pages/new/overview_form.dart';
import 'package:inkstep/ui/pages/new/position_picker_screen.dart';
import 'package:inkstep/ui/pages/new/size_screen.dart';
import 'package:inkstep/ui/pages/new/style_screen.dart';
import 'package:inkstep/ui/routes/fade_page_route.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class InfoNavigator {
  InfoNavigator(int artistId) {
    descController = TextEditingController();
    widthController = TextEditingController();
    heightController = TextEditingController();
    styleController = TextEditingController();
    emailController = TextEditingController();
    inspirationImages = [];
    formData['artistID'] = artistId.toString();
  }

  TextEditingController descController;
  TextEditingController widthController;
  TextEditingController heightController;
  TextEditingController emailController;
  TextEditingController styleController;
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
    'artistID': '',
    'style': '',
  };

  int screenNum = 0;

  // TODO(DJRHails): Style
  // Most artists do more than one style, while many develop their own style
  // by combining two or more existing ones. And some experimental artists who
  // like to push the boundaries often go on to create new styles entirely!

  // It's worth selecting what style of tattoo you like so that artists knows what's involved
  // for them

  List<Widget> getScreens(BuildContext context) {
    return [
      DescriptionScreen(
        descController: descController,
        navigator: this,
      ),
      ImageScreen(
        images: inspirationImages,
        navigator: this,
        callback: (images) {
          inspirationImages = images;
          formData['noRefImgs'] = inspirationImages.length.toString();
        },
      ),
      StyleScreen(
        navigator: this,
        styleController: styleController,
      ),
      PositionPickerScreen(
        formData: formData,
        callback: (pos, genPos) {
          formData['position'] = pos;
          formData['generalPos'] = genPos;
        },
        navigator: this,
      ),
      SizeSelectorScreen(
        heightController: heightController,
        widthController: widthController,
        navigator: this,
      ),
      AvailabilityScreen(
        navigator: this,
        callback: (List<bool> avail) {
          formData['availability'] = '';
          for (bool b in avail) {
            formData['availability'] += b ? '1' : '0';
          }
        },
        avail: formData['availability'],
      ),
      DepositScreen(
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
      ),
      EmailScreen(
        navigator: this,
        emailController: emailController,
      ),
      OverviewForm(
        emailController: emailController,
        heightController: heightController,
        widthController: widthController,
        descController: descController,
        styleController: styleController,
        formData: formData,
        images: inspirationImages,
        navigator: this,
      )
    ];
  }

  Widget getScreen(BuildContext context, int screenNum) {
    final screens = getScreens(context);
    if (screenNum < screens.length && screenNum >= 0) {
      return screens[screenNum];
    }
    return null;
  }

  void start(BuildContext context) {
    screenNum = 0;

    Navigator.pushReplacement<dynamic, dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => getScreen(context, screenNum)),
    );
  }

  void next(BuildContext context, Widget exitScreen) {
    screenNum++;
    Navigator.pushReplacement<dynamic, dynamic>(
      context,
      FadeRoute(page: getScreen(context, screenNum)),
    );
  }

  void back(BuildContext context, Widget exitScreen) {
    if (screenNum == 0) {
      return;
    }

    screenNum--;
    Navigator.pushReplacement<dynamic, dynamic>(
      context,
      FadeRoute(page: getScreen(context, screenNum)),
    );
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }

  void showHelp(BuildContext context, Widget help) {
    Navigator.push<dynamic>(
      context,
      FadeRoute(page: help),
    );
  }
}
