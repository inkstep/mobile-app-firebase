import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/blocs/journeys_state.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/feature_discovery.dart';
import 'package:inkstep/ui/components/journey_cards.dart';
import 'package:inkstep/ui/pages/onboarding/welcome_back_header.dart';
import 'package:inkstep/utils/screen_navigator.dart';

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
    return FeatureDiscovery(
      child: BlocBuilder<JourneysEvent, JourneysState>(
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
            _animation.addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                if (loadedState.firstTime == true) {
                  FeatureDiscovery.discoverFeatures(context, ['aftercare_button_0']);
                  journeyBloc.dispatch(ShownFeatureDiscovery());
                }
              }
            });

            final void Function(ScrollNotification) onNotification = (notification) {
              if (notification is ScrollEndNotification) {
                final currentPage = _pageController.page.round().toInt();
                if (_currentPageIndex != currentPage) {
                  setState(() => _currentPageIndex = currentPage);
                }
              }
            };
            return LoadedJourneyScreen(
              animation: _animation,
              loadedState: loadedState,
              onNotification: onNotification,
              pageController: _pageController,
            );
          } else {
            print(state);
            return Container(
              child: Center(child: Text('Abort Mission')),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LoadedJourneyScreen extends StatelessWidget {
  const LoadedJourneyScreen({
    Key key,
    @required Animation<double> animation,
    @required this.loadedState,
    @required this.onNotification,
    @required PageController pageController,
  })  : _animation = animation,
        _pageController = pageController,
        super(key: key);

  final Animation<double> _animation;
  final JourneysWithUser loadedState;
  final void Function(ScrollNotification) onNotification;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    Color accentColor = Theme.of(context).accentColor;
    // TODO(DJRHails): Add this back in
    //  if (_pageController.hasClients) {
    //    accentColor = loadedState.cards[_pageController.page.toInt()].palette.vibrantColor?.color;
    //  }
    final FloatingActionButton addJourneyButton = loadedState.cards.isEmpty
        ? null
        : FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: accentColor,
            onPressed: () {
              final nav = sl.get<ScreenNavigator>();
              nav.openArtistSelection(context);
            },
          );
    return Scaffold(
      floatingActionButton: addJourneyButton,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: Navigator.of(context).canPop()
          ? AppBar(
              title: Text(''),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            )
          : null,
      body: FadeTransition(
        opacity: _animation,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(flex: 4),
              WelcomeBackHeader(
                name: loadedState.user?.name,
              ),
              Spacer(flex: 2),
              Expanded(
                flex: 60,
                child: NotificationListener<ScrollNotification>(
                  onNotification: onNotification,
                  child: PageView.builder(
                    controller: _pageController,
                    itemBuilder: (BuildContext context, int index) {
//                    final int size = loadedState.cards.length;
                      if (loadedState.cards.isEmpty) {
                        return AddCard(userID: loadedState.user.id);
                      } else {
                        // TODO(DJRHails): Animate scale
//                      final double pagePos =
//                          _pageController.offset / _pageController.position.viewportDimension;
//                      final double difference = (index - pagePos).abs();
//                      final percentageOffset = (size - difference) / size;
//                      final scale = (percentageOffset * 1.1).clamp(0.0, 1.0);
//                      print(percentageOffset);

                        return JourneyCard(model: loadedState.cards[index], scale: 1);
                      }
                    },
                    itemCount: loadedState.cards.isEmpty ? 1 : loadedState.cards.length,
                  ),
                ),
              ),
              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
