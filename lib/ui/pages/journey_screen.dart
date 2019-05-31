import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journey_bloc.dart';
import 'package:inkstep/blocs/journey_event.dart';
import 'package:inkstep/blocs/journey_state.dart';
import 'package:inkstep/ui/components/journey_cards.dart';

class WelcomeBackHeader extends StatelessWidget {
  const WelcomeBackHeader({
    Key key,
    @required this.name,
    @required this.tasksToComplete,
  }) : super(key: key);

  final String name;
  final int tasksToComplete;

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
              style: Theme.of(context).textTheme.headline,
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
  const JourneyScreen({Key key, this.onInit}) : super(key: key);

  @override
  _JourneyScreenState createState() => _JourneyScreenState();

  final void Function() onInit;
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
    widget.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final JourneyBloc journeyBloc = BlocProvider.of<JourneyBloc>(context);
    return BlocBuilder<JourneyEvent, JourneyState>(
      bloc: journeyBloc,
      builder: (BuildContext context, JourneyState state) {
        if (state is JourneyUninitialised) {
          return Container(
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          );
        } else if (state is JourneyLoaded) {
          final JourneyLoaded loadedState = state;
          _controller.forward();
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
                  WelcomeBackHeader(
                    // TODO(DJRHails): Use a user bloc
                    name: loadedState.journeys.first.name,
                    tasksToComplete: 0,
                  ),
                  Expanded(
                    key: _backdropKey,
                    flex: 1,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification) {
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
                          if (index == state.journeys.length) {
                            return AddCard();
                          } else {
                            return JourneyCard(model: state.journeys[index]);
                          }
                        },
                        itemCount: state.journeys.length + 1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 32.0),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
