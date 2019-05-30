import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Image.asset('assets/logo.png'),
      );
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Container(
                  height: animation.value,
                  width: animation.value,
                  child: child,
                ),
            child: child),
      );
}

class Logo extends StatefulWidget {
  @override
  _LogoState createState() => _LogoState(100.0, 100.0);
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  _LogoState(this.startSize, this.endSize);

  Animation<double> animation;
  AnimationController controller;

  final duration = Duration(seconds: 2);
  final double startSize;
  final double endSize;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: duration, vsync: this);
    animation =
        Tween<double>(begin: startSize, end: endSize).animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => GrowTransition(
        child: Hero(tag: 'logo', child: LogoWidget()),
        animation: animation,
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
