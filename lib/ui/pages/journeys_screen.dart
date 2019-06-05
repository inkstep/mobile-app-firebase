import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/blocs/journeys_state.dart';
import 'package:inkstep/ui/components/journey_cards.dart';
import 'package:inkstep/ui/pages/onboarding/welcome_back_header.dart';

class JourneysScreen extends StatefulWidget {
  const JourneysScreen({Key key, this.onInit}) : super(key: key);

  @override
  _JourneysScreenState createState() => _JourneysScreenState();

  final void Function() onInit;
}

class _JourneysScreenState extends State<JourneysScreen> with SingleTickerProviderStateMixin {
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
    final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
    return BlocBuilder<JourneysEvent, JourneysState>(
      bloc: journeyBloc,
      builder: (BuildContext context, JourneysState state) {
        if (state is JourneyError) {
          print('JourneyError');
          Navigator.pop(context);
        }

        if (state is JourneysNoUser) {
          return Container(
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          );
        } else if (state is JourneysWithUser) {
          final JourneysWithUser loadedState = state;
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
                    name: loadedState.journeys.isEmpty ? '' : loadedState.userId.toString(),
                    tasksToComplete: 0,
                  ),
                  Expanded(
                    flex: 1,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification) {
                          final currentPage = _pageController.page.round().toInt();
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
        } else {
          print(state);
          return Container(
            child: Center(child: Text('Abort Mission')),
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
