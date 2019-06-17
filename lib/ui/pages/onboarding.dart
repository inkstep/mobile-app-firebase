import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/bold_call_to_action.dart';
import 'package:inkstep/ui/components/logo.dart';
import 'package:inkstep/ui/components/notifying_page_view.dart';
import 'package:inkstep/ui/components/text_button.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class Onboarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  final ValueNotifier<double> _notifier = ValueNotifier<double>(0);
  final Tween inkRatio = Tween<double>(begin: 0.9, end: 2.0);
  final PageController _controller = PageController();
  double position;

  @override
  void dispose() {
    _controller?.dispose();
    _notifier?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      FirstPage(controller: _controller),
      _buildOnboardingSlice(
        context,
        Icons.memory,
        'Feel Smarter',
        'You get guided as to what artists want you to say.',
        'Wow',
      ),
      _buildOnboardingSlice(
          context,
          Icons.calendar_today,
          'Get the artist you want',
          'Help artists out by taking a cancellation slot and you\'re more likely to get seen.',
          "That's cool"),
      _buildOnboardingSlice(
          context,
          Icons.healing,
          'Care Made Easy',
          'Personal, artist specified pre-care and aftercare in one place, and only when you need it',
          'Awesome!'),
      _buildOnboardingSlice(
          context,
          Icons.favorite,
          "Be the Artist's Favourite",
          "Make your artist happy! They'll be delighted to have a client like you.",
          "Enough! Let's get to it.",
          last: true),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _notifier,
        builder: (context, _) => CustomPaint(
              painter: InkSplash(Theme.of(context).backgroundColor,
                  inkRatio.transform(_notifier.value / pages.length)),
              child: NotifyingPageView(
                notifier: _notifier,
                pageController: _controller,
                pages: pages,
              ),
            ),
      ),
    );
  }

  Widget _buildOnboardingSlice(
      BuildContext context, IconData icon, String header, String body, String buttonText,
      {bool last}) {
    const EdgeInsets buttonPadding = EdgeInsets.only(top: 16.0);
    return Column(
      children: [
        Spacer(flex: 4),
        Icon(
          icon,
          size: 120,
        ),
        Spacer(),
        Text(
          header,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Text(
            body,
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(
          flex: 8,
        ),
        Container(
          child: Column(
            children: <Widget>[
              BoldCallToAction(
                onTap: () {
                  if (last == null) {
                    _controller.nextPage(
                        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                  } else if (last) {
                    final ScreenNavigator nav = sl.get<ScreenNavigator>();
                    nav.openArtistSelectionReplace(context);
                  }
                },
                label: buttonText,
                textColor: Theme.of(context).primaryColor,
                color: Theme.of(context).cardColor,
              ),
              Padding(padding: buttonPadding),
              Padding(padding: buttonPadding),
              Padding(padding: buttonPadding),
            ],
          ),
        ),
      ],
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key key, @required this.controller}) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    const EdgeInsets buttonPadding = EdgeInsets.only(top: 16.0);
    final boldButtonKey = UniqueKey();
    return Column(
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
                style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w700),
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
        Container(
          child: Column(
            children: <Widget>[
              BoldCallToAction(
                key: boldButtonKey,
                onTap: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
//                    final ScreenNavigator nav = sl.get<ScreenNavigator>();
//                    nav.openArtistSelectionReplace(context);
                },
                label: "Let's get started!",
                textColor: Theme.of(context).primaryColor,
                color: Theme.of(context).cardColor,
              ),
              Padding(padding: buttonPadding),
              TextButton(
                onTap: () {
                  final ScreenNavigator nav = sl.get<ScreenNavigator>();
                  nav.openLoginScreen(context);
                },
                label: "I'VE BEEN HERE BEFORE",
                color: Theme.of(context).backgroundColor,
              ),
              Padding(padding: buttonPadding),
            ],
          ),
        ),
      ],
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
