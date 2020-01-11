import 'package:flutter/cupertino.dart';

class ScaleOnTap extends StatefulWidget {
  const ScaleOnTap({Key key, @required this.child, @required this.onTap, this.scale = 0.95}) : super(key: key);

  final Widget child;
  final Function onTap;
  final double scale;

  @override
  State<StatefulWidget> createState() => ScaleOnTapState(child, onTap, scale);
}

class ScaleOnTapState extends State<ScaleOnTap> with SingleTickerProviderStateMixin {
  ScaleOnTapState(this.child, this.onTap, this.scale);

  final Widget child;
  final Function onTap;
  final double scale;

  AnimationController _controller;

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
    Future<dynamic>.delayed(
      const Duration(milliseconds: 100),
      () {
        _controller.reverse();
        onTap();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 10),
      lowerBound: 0.0,
      upperBound: 1 - scale,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      child: Transform.scale(
        scale: 1 - _controller.value,
        child: child,
      ),
    );
  }
}
