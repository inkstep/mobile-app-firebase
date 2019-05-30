import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journey_bloc.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/ui/components/journey_cards.dart';

class WelcomeBackHeader extends StatelessWidget {
  const WelcomeBackHeader({Key key, @required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0, left: 56.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Welcome back,',
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.white.withOpacity(0.7)),
          ),
          Container(
            child: Text(
              'Natasha',
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(color: Colors.white),
            ),
          ),
          Container(height: 16.0),
          Text(
            'You have some journey tasks to complete',
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Colors.white.withOpacity(0.7)),
          ),
          Container(
            height: 16.0,
          )
        ],
      ),
    );
  }
}

class JourneyScreen extends StatefulWidget {
  @override
  _JourneyScreenState createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  int _currentPageIndex = 0;

  AnimationController _controller;
  Animation<double> _animation;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    final JourneyBloc journeyBloc = BlocProvider.of<JourneyBloc>(context);
    final int length = journeyBloc.currentState.length;

    // TODO(matt-malarkey): move to state
    const _isLoading = false;

    if (!_isLoading) {
      _controller.forward();
    }

    // TODO(matt-malarkey): correctly hookup page
    // ignore: unused_element
    Widget loadingPage() {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 1.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            WelcomeBackHeader(name: 'Natasha'),
            BlocBuilder<JourneyEvent, List<JourneyModel>>(
              bloc: journeyBloc,
              builder: (BuildContext context, List<JourneyModel> journeys) {
                return Expanded(
                  key: _backdropKey,
                  flex: 1,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        print('ScrollNotification = ${_pageController.page}');
                        final currentPage =
                            _pageController.page.round().toInt();
                        if (_currentPageIndex != currentPage) {
                          setState(() => _currentPageIndex = currentPage);
                        }
                      }
                    },
                    child: PageView.builder(
                      controller: _pageController,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == length) {
                          return AddCard();
                        } else {
                          return JourneyCard(model: journeys[index]);
                        }
                      },
                      itemCount: length + 1,
                    ),
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(bottom: 32.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
