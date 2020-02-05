import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:inkstep/models/artist.dart';
import 'package:inkstep/models/card.dart';
import 'package:inkstep/models/journey.dart';

import 'journeys/journey_cards.dart';

class JourneysScreen extends StatefulWidget {
  const JourneysScreen({Key key, this.journeys, this.newJourneyFunc}) : super(key: key);

  final List<DocumentSnapshot> journeys;
  final Function newJourneyFunc;

  @override
  _JourneysScreenState createState() => _JourneysScreenState(journeys, newJourneyFunc);
}

class _JourneysScreenState extends State<JourneysScreen> with TickerProviderStateMixin {
  _JourneysScreenState(this.journeys, this.newJourneyFunc);

  final List<DocumentSnapshot> journeys;
  final Function newJourneyFunc;

  int _currentPageIndex = 0;
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Spacer(flex: 6),
          Expanded(
            flex: 60,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                if (journeys.isEmpty) {
                  return AddCard(newJourneyFunc);
                }

                final Journey journey = Journey.fromMap(
                  journeys[index].data,
                  id: journeys[index].documentID,
                );
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: JourneyCard(
                    key: ObjectKey(journey),
                    card: CardModel(
                      journey: journey,
                      artist: Artist.fromId(journey.artistId),
                    ),
                  ),
                );
              },
              loop: false,
              controller: _swiperController,
              itemCount: journeys.isEmpty ? 1 : journeys.length,
              viewportFraction: 0.85,
              scale: 0.9,
            ),
          ),
          Spacer(flex: 6),
        ],
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
