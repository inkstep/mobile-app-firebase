import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/blocs/journeys_state.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/feature_discovery.dart';
import 'package:inkstep/ui/components/horizontal_divider.dart';
import 'package:inkstep/ui/components/large_two_part_header.dart';
import 'package:inkstep/utils/screen_navigator.dart';

import 'journeys/journey_cards.dart';

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
  SwiperController _swiperController;

  @override
  void initState() {
    widget.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _swiperController = SwiperController();
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
                  FeatureDiscovery.discoverFeatures(context, ['care_button_0']);
                  journeyBloc.dispatch(ShownFeatureDiscovery());
                }
              }
            });

            final void Function(ScrollNotification) onNotification = (notification) {
              if (notification is ScrollEndNotification) {
                final currentPage = _swiperController.index;
                if (_currentPageIndex != currentPage) {
                  setState(() => _currentPageIndex = currentPage);
                }
              }
            };
            return LoadedJourneyScreen(
              animation: _animation,
              loadedState: loadedState,
              onNotification: onNotification,
              swiperController: _swiperController,
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
    @required SwiperController swiperController,
  })  : _animation = animation,
        _swiperController = swiperController,
        super(key: key);

  final Animation<double> _animation;
  final JourneysWithUser loadedState;
  final void Function(ScrollNotification) onNotification;
  final SwiperController _swiperController;

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Theme.of(context).accentColor;
    // TODO(DJRHails): Add this back in
    //  if (_swiperController.hasClients) {
    //    accentColor = loadedState.cards[_swiperController.page.toInt()].palette.vibrantColor?.color;
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

    final double paddingSize = MediaQuery.of(context).size.width * (1 - 0.8) / 2;
    return Scaffold(
      floatingActionButton: addJourneyButton,
      backgroundColor: Theme.of(context).backgroundColor,
      body: FadeTransition(
        opacity: _animation,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(flex: 4),
              Padding(
                padding: EdgeInsets.only(left: paddingSize),
                child: GestureDetector(
                  child: LargeTwoPartHeader(
                    largeText: 'Welcome back',
                    name: loadedState.user?.name,
                  ),
                  onLongPress: () {
                    final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
                    journeyBloc.dispatch(LogOut(context));
                  },
                ),
              ),
              Spacer(flex: 1),
              HorizontalDivider(
                thickness: 4.0,
                percentage: 30,
                alignment: MainAxisAlignment.start,
                padding: EdgeInsets.only(left: paddingSize),
                color: Colors.white54,
              ),
              Spacer(flex: 2),
              Expanded(
                flex: 60,
                child: NotificationListener<ScrollNotification>(
                  onNotification: onNotification,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      if (loadedState.cards.isEmpty) {
                        return AddCard();
                      }
                      print('Adding non empty card!');
                      return JourneyCard(model: loadedState.cards[index]);
                    },
                    loop: false,
                    controller: _swiperController,
                    itemCount: loadedState.cards.isEmpty ? 1 : loadedState.cards.length,
                    viewportFraction: 0.8,
                    scale: 0.9,
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
