import 'package:flutter/material.dart';

class NotifyingPageView extends StatefulWidget {
  const NotifyingPageView({
    Key key,
    @required this.notifier,
    @required this.pages,
    this.pageController,
  }) : super(key: key);

  final List<Widget> pages;
  final ValueNotifier<double> notifier;
  final PageController pageController;

  @override
  _NotifyingPageViewState createState() => _NotifyingPageViewState();
}

class _NotifyingPageViewState extends State<NotifyingPageView> {
  PageController _pageController;

  void _onScroll() {
    widget.notifier?.value = _pageController.page;
  }

  @override
  void initState() {
    super.initState();
    final PageController defaultPageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    );
    _pageController = (widget.pageController ?? defaultPageController)..addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: widget.pages,
      controller: _pageController,
    );
  }
}
