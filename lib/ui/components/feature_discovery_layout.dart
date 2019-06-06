import 'dart:async';

import 'package:flutter/material.dart';

// REF: matthew-carroll/flutter_ui_challenge_feature_discovery

class AnchoredOverlay extends StatelessWidget {
  const AnchoredOverlay({
    this.showOverlay,
    this.overlayBuilder,
    this.child,
  });

  final bool showOverlay;
  final Widget Function(BuildContext, Offset anchor) overlayBuilder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return OverlayBuilder(
          showOverlay: showOverlay,
          overlayBuilder: (BuildContext overlayContext) {
            final RenderBox box = context.findRenderObject();
            final center = box.size.center(box.localToGlobal(const Offset(0.0, 0.0)));
            return overlayBuilder(overlayContext, center);
          },
          child: child,
        );
      }),
    );
  }
}

class OverlayBuilder extends StatefulWidget {
  const OverlayBuilder({
    this.showOverlay = false,
    this.overlayBuilder,
    this.child,
  });

  final bool showOverlay;
  final Function(BuildContext) overlayBuilder;
  final Widget child;

  @override
  _OverlayBuilderState createState() => _OverlayBuilderState();
}

class _OverlayBuilderState extends State<OverlayBuilder> {
  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    if (widget.showOverlay) {
      showOverlay();
    }
  }

  @override
  void didUpdateWidget(OverlayBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    syncWidgetAndOverlay();
  }

  @override
  void reassemble() {
    super.reassemble();
    syncWidgetAndOverlay();
  }

  @override
  void dispose() {
    if (isShowingOverlay()) {
      hideOverlay();
    }

    super.dispose();
  }

  bool isShowingOverlay() => overlayEntry != null;

  void showOverlay() {
    overlayEntry = OverlayEntry(
      builder: widget.overlayBuilder,
    );
    addToOverlay(overlayEntry);
  }

  Future<void> addToOverlay(OverlayEntry entry) async {
    return Timer.run(() {
      Overlay.of(context).insert(entry);
    });
  }

  void hideOverlay() {
    overlayEntry.remove();
    overlayEntry = null;
  }

  void syncWidgetAndOverlay() {
    if (isShowingOverlay() && !widget.showOverlay) {
      hideOverlay();
    } else if (!isShowingOverlay() && widget.showOverlay) {
      showOverlay();
    }
  }

  Future<void> buildOverlay() async {
    return overlayEntry?.markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    Timer.run(() {
      buildOverlay();
    });

    return widget.child;
  }
}

class CenterAbout extends StatelessWidget {
  const CenterAbout({
    this.position,
    this.child,
  });

  final Offset position;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position.dy,
      left: position.dx,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: child,
      ),
    );
  }
}
