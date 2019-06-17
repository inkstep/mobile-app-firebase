import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/binary_input.dart';
import 'package:inkstep/ui/pages/new/availability_screen.dart';
import 'package:inkstep/ui/pages/new/deposit_screen.dart';
import 'package:inkstep/ui/pages/new/description_screen.dart';
import 'package:inkstep/ui/pages/new/image_screen.dart';
import 'package:inkstep/ui/pages/new/overview_form.dart';
import 'package:inkstep/ui/pages/new/position_picker_screen.dart';
import 'package:inkstep/ui/pages/new/size_screen.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class InfoNavigator {
  InfoNavigator() {
    descController = TextEditingController();
    widthController = TextEditingController();
    heightController = TextEditingController();
    emailController = TextEditingController();
    inspirationImages = [];
  }

  TextEditingController descController;
  TextEditingController widthController;
  TextEditingController heightController;
  TextEditingController emailController;
  List<Asset> inspirationImages;

  Map<String, String> formData = {
    'name': '',
    'email': 'james.dalboth@gmail.com',
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

  Widget getScreen(int screenNum) {
    switch (screenNum) {
      case 0:
        return DescriptionScreen(
          descController: descController,
          navigator: this,
        );
      case 1:
        return ImageScreen(
          images: inspirationImages,
          navigator: this,
          callback: (images) {
            inspirationImages = images;
            formData['noRefImgs'] = images.length.toString();
          },
        );
      case 2:
        return PositionPickerScreen(
          formData: formData,
          callback: (pos, genPos) {
            formData['position'] = pos;
            formData['generalPos'] = genPos;
          },
          navigator: this,
        );
      case 3:
        return SizeSelectorScreen(
          heightController: heightController,
          widthController: widthController,
          navigator: this,
        );
      case 4:
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
      case 5:
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
      case 6:
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

    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => getScreen(screenNum)),
    );
  }

  void next(BuildContext context) {
    screenNum++;
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => getScreen(screenNum)),
    );
  }

  void back(BuildContext context) {
    if (screenNum == 0) {
      return;
    }

    screenNum--;
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => getScreen(screenNum)),
    );
  }
}
