import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    );
  }

  Widget _buildPageView() {
    if (journeys.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: AddCard(newJourneyFunc),
      );
    }

    return PageView.builder(
      controller: _pageController,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: journeys.length,
      itemBuilder: (BuildContext context, int index) {
        // Add document ID to map for use as journey ID in creating journey object
        final Map<String, dynamic> journeyMap = journeys[index].data;
        journeyMap.addAll(<String, dynamic>{'id': journeys[index].documentID});

        final Journey journey = Journey.fromMap(journeyMap);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: JourneyCard(
            key: ObjectKey(journey),
            card: CardModel(
              journey: journey,
              artist: Artist.fromId(journey.artistId),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        return true;
      },
      child: _buildPageView(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
