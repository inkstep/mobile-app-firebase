import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/artist.dart';
import 'package:inkstep/models/card.dart';
import 'package:inkstep/models/journey.dart';
import 'package:inkstep/models/user.dart';
import 'package:inkstep/ui/components/horizontal_divider.dart';
import 'package:inkstep/ui/components/large_two_part_header.dart';
import 'package:inkstep/ui/pages/landing_screen.dart';
import 'package:inkstep/utils/screen_navigator.dart';

import 'journeys/journey_cards.dart';

class JourneysScreen extends StatefulWidget {
  @override
  _JourneysScreenState createState() => _JourneysScreenState();
}

class _JourneysScreenState extends State<JourneysScreen> with TickerProviderStateMixin {
  int _currentPageIndex = 0;

  AnimationController _controller;
  Animation<double> _animation;
  SwiperController _swiperController;

  AnimationController loopController;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _swiperController = SwiperController();

    loopController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    loopController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();

    // For firebase notification handler
    final void Function(ScrollNotification) onNotification = (notification) {
      if (notification is ScrollEndNotification) {
        final currentPage = _swiperController.index;
        if (_currentPageIndex != currentPage) {
          setState(() => _currentPageIndex = currentPage);
        }
      }
    };

    return FutureBuilder(
      future: FirebaseAuth.instance.signInAnonymously(),
      builder: (BuildContext context, AsyncSnapshot auth) {
        return FutureBuilder(
          future: User.getName(),
          builder: (buildContext, user) {
            if (!user.hasData) {
              return LandingScreen();
            }
            return StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('journeys')
                  // TODO(mm): proper security rules for firebase
                  .where('auth_uid', isEqualTo: auth.hasData ? auth.data.user.uid : '-1')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return LandingScreen(name: user.data);
                }
                return LoadedJourneyScreen(
                  username: user.data,
                  animation: _animation,
                  onNotification: onNotification,
                  swiperController: _swiperController,
                  journeys: snapshot.data.documents,
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    loopController.dispose();
    _controller.dispose();
    super.dispose();
  }
}

class LoadedJourneyScreen extends StatelessWidget {
  const LoadedJourneyScreen({
    Key key,
    @required this.username,
    @required Animation<double> animation,
    @required this.onNotification,
    @required SwiperController swiperController,
    @required this.journeys,
  })  : _animation = animation,
        _swiperController = swiperController,
        super(key: key);

  final void Function(ScrollNotification) onNotification;
  final List<DocumentSnapshot> journeys;

  final String username;

  final Animation<double> _animation;
  final SwiperController _swiperController;

  Widget _buildJourneyCards() {
    return NotificationListener<ScrollNotification>(
      onNotification: onNotification,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          if (journeys.isEmpty) {
            return AddCard();
          }

          // Add document ID to map for use as journey ID in creating journey object
          final Map<String, dynamic> journeyMap = journeys[index].data;
          journeyMap.addAll(<String, dynamic>{'id': journeys[index].documentID});

          final Journey journey = Journey.fromMap(journeyMap);
          return JourneyCard(
            card: CardModel(
              journey: journey,
              artist: Artist.fromId(journey.artistId),
            ),
          );
        },
        loop: false,
        controller: _swiperController,
        itemCount: journeys.isEmpty ? 1 : journeys.length,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Theme.of(context).accentColor;
    // TODO(DJRHails): Add this back in
    //  if (_swiperController.hasClients) {
    //    accentColor = loadedState.cards[_swiperController.page.toInt()].palette.vibrantColor?.color;
    //  }
    final FloatingActionButton addJourneyButton = journeys.isEmpty
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
                    name: username,
                  ),
                  onLongPress: () {
                    User.logOut();
                    final ScreenNavigator nav = sl.get<ScreenNavigator>();
                    nav.restartApp(context);
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
                child: _buildJourneyCards(),
              ),
              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
