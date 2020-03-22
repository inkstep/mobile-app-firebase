import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/pages/artists_screen.dart';
import 'package:inkstep/ui/pages/guests_screen.dart';

import 'events_screen.dart';
// import 'messages_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.journeys}) : super(key: key);

  final List<DocumentSnapshot> journeys;

  @override
  State<StatefulWidget> createState() => HomeScreenState(journeys);
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  HomeScreenState(this.journeys);

  final List<DocumentSnapshot> journeys;
  final int _numTabs = 3;
  final int _journeysIndex = 1;

  final _tabs = const <Widget>[
    Tab(text: 'Artists'),
    // Tab(text: 'Journeys'),
    Tab (text: 'Guests'),
    // Tab(text: 'Messages'),
    Tab(text: 'Events'),
  ];

  List<Widget> get _tabBodies => <Widget>[
        ArtistSelectionScreen(),
        // JourneysScreen(journeys: journeys, newJourneyFunc: () => _tabController.index = 0,),
        GuestsScreen(),
        // MessagesScreen(),
        EventsScreen(),
      ];

  TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _numTabs, initialIndex: _journeysIndex);
    _tabController.addListener(_handleTabChanged);
    _currentIndex = _journeysIndex;
  }

  void _handleTabChanged() {
    setState(() => _currentIndex = _tabController.index);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'SOUTHCITYMARKET',
          child: Text(
            'SOUTHCITYMARKET',
            style: Theme.of(context).textTheme.headline.copyWith(fontSize: 22),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelStyle: Theme.of(context).textTheme.subhead.copyWith(fontSize: 22),
          unselectedLabelStyle: Theme.of(context)
              .textTheme
              .subhead
              .copyWith(fontSize: 22, color: Colors.white.withOpacity(0.7)),
          indicatorColor: Colors.white,
          tabs: _tabs,
        ),
      ),
      floatingActionButton: _currentIndex == _journeysIndex && journeys.isNotEmpty
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).accentColor,
              onPressed: () {
                _tabController.index = 0;
              },
            )
          : null,
      backgroundColor: Color.fromRGBO(40, 40, 40, 1.0), // Theme.of(context).backgroundColor,
      body: TabBarView(
        controller: _tabController,
        children: _tabBodies,
      ),
    );
  }
}
