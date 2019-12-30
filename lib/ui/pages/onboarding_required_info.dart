import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/user.dart';
import 'package:inkstep/ui/components/short_text_input.dart';
import 'package:inkstep/utils/screen_navigator.dart';

import '../../theme.dart';

class OnboardingRequiredInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OnboardingRequiredInfoState();
}

class OnboardingRequiredInfoState extends State<OnboardingRequiredInfo> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: appTheme.accentIconTheme,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: ShortTextInput(
          controller: nameController,
          maxLength: 16,
          capitalisation: TextCapitalization.words,
          hint: 'They call me...',
          label: 'What do your friends call you?',
          callback: (name) {
            if (name == '') {
              // TODO(mm): shake the text box or something here
              return;
            }
            User.setName(name);
            final ScreenNavigator nav = sl.get<ScreenNavigator>();
            nav.openHomeScreen(context);
          },
        ),
      ),
    );
  }
}
