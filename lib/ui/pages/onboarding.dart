import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/bold_call_to_action.dart';
import 'package:inkstep/ui/components/logo.dart';
import 'package:inkstep/ui/components/text_button.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class Onboarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  _OnboardingState();

  @override
  Widget build(BuildContext context) {
    const EdgeInsets buttonPadding = EdgeInsets.only(top: 16.0);
    final ScreenNavigator nav = sl.get<ScreenNavigator>();
    final boldButtonKey = UniqueKey();
    final bottom = Container(
      child: Column(
        children: <Widget>[
          BoldCallToAction(
            key: boldButtonKey,
            onTap: () {
              nav.openArtistSelectionReplace(context);
            },
            label: "Let's get started!",
            textColor: Theme.of(context).primaryColor,
            color: Theme.of(context).cardColor,
          ),
          Padding(padding: buttonPadding),
          TextButton(
            onTap: () {
              nav.openLoginScreen(context);
            },
            label: "I'VE BEEN HERE BEFORE",
            color: Theme.of(context).backgroundColor,
          ),
          Padding(padding: buttonPadding),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: InkSplash(Theme.of(context).backgroundColor, 0.9),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Spacer(flex: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Logo(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'inkstep.',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                'Tattoos done right',
                style: Theme.of(context).textTheme.headline,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                child: Text(
                  "We're here to make you feel like a tattoo pro.",
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(
                flex: 8,
              ),
              bottom,
            ],
          ),
        ),
      ),
    );
  }
}

class InkSplash extends CustomPainter {
  InkSplash(this.color, this.ratio);

  final Color color;
  final double ratio;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    final Paint paint = Paint();

    final double height = size.height * ratio;

    path.lineTo(0, height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.10,
      height * 0.7,
      size.width * 0.15,
      height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.20,
      height * 0.8,
      size.width * 0.25,
      height * 0.7,
    );
    path.quadraticBezierTo(
      size.width * 0.40,
      height * 0.40,
      size.width * 0.50,
      height * 0.7,
    );
    path.quadraticBezierTo(
      size.width * 0.60,
      height * 0.85,
      size.width * 0.65,
      height * 0.65,
    );
    path.quadraticBezierTo(
      size.width * 0.70,
      height * 0.8,
      size.width,
      0,
    );
    path.close();

    paint.color = Colors.black26;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, height * 0.50);
    path.quadraticBezierTo(size.width * 0.10, height * 0.80, size.width * 0.15, height * 0.60);
    path.quadraticBezierTo(size.width * 0.20, height * 0.45, size.width * 0.27, height * 0.60);
    path.quadraticBezierTo(size.width * 0.45, height, size.width * 0.50, height * 0.80);
    path.quadraticBezierTo(size.width * 0.55, height * 0.45, size.width * 0.8, height * 0.7);
    path.quadraticBezierTo(size.width * 0.95, height * 0.8, size.width, height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = Colors.black54;

    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, height * 0.7);
    path.quadraticBezierTo(size.width * 0.10, height * 0.55, size.width * 0.22, height * 0.7);
    path.quadraticBezierTo(size.width * 0.30, height * 0.8, size.width * 0.40, height * 0.7);
    path.quadraticBezierTo(size.width * 0.52, height * 0.50, size.width * 0.65, height * 0.7);
    path.quadraticBezierTo(size.width * 0.75, height * 0.85, size.width, height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
