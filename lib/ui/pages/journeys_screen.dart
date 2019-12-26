import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:inkstep/models/artist.dart';
import 'package:inkstep/models/card.dart';
import 'package:inkstep/models/journey.dart';

import 'journeys/journey_cards.dart';

class JourneysScreen extends StatefulWidget {
  const JourneysScreen({Key key, this.journeys}) : super(key: key);

  final List<DocumentSnapshot> journeys;

  @override
  _JourneysScreenState createState() => _JourneysScreenState(journeys);
}

class _JourneysScreenState extends State<JourneysScreen> with TickerProviderStateMixin {
  _JourneysScreenState(this.journeys);

  int _currentPageIndex = 0;

  final List<DocumentSnapshot> journeys;
  AnimationController _controller;

  SwiperController _swiperController;

  AnimationController loopController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _swiperController = SwiperController();

    loopController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    loopController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          final currentPage = _swiperController.index;
          if (_currentPageIndex != currentPage) {
            setState(() => _currentPageIndex = currentPage);
          }
          return true;
        }
        return false;
      },
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
            key: ObjectKey(journey),
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
  void dispose() {
    loopController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
