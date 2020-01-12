import 'package:flutter/cupertino.dart';

class GentleLoader extends StatefulWidget {
  const GentleLoader({
    Key key,
    this.loadConditions,
    this.loading,
    this.loaded,
    this.holdDelay = const Duration(seconds: 2),
  }) : super(key: key);

  final List<bool> loadConditions;
  final Widget loading;
  final Widget loaded;
  final Duration holdDelay;

  @override
  State<StatefulWidget> createState() => GentleLoaderState(
        loading,
        loaded,
        loadConditions,
        holdDelay,
      );
}

class GentleLoaderState extends State<GentleLoader> {
  GentleLoaderState(this.loading, this.loaded, this.loadConditions, this.holdDelay);

  final List<bool> loadConditions;
  final Widget loading;
  final Widget loaded;
  final Duration holdDelay;

  bool _shouldHoldLoading = false;

  @override
  Widget build(BuildContext context) {
    if (loadConditions.any((c) => !c)) {
      _shouldHoldLoading = true;
      Future<dynamic>.delayed(
        holdDelay,
        () => setState(() => _shouldHoldLoading = false),
      );
      return loading;
    }

    return _shouldHoldLoading ? loading : loaded;
  }
}
