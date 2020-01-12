import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/alert_dialog.dart';
import 'package:inkstep/ui/components/logo.dart';
import 'package:inkstep/ui/pages/artists_screen.dart';
import 'package:inkstep/ui/pages/journeys_screen.dart';
import 'package:inkstep/utils/screen_navigator.dart';

import 'messages_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.journeys}) : super(key: key);

  final List<DocumentSnapshot> journeys;

  @override
  State<StatefulWidget> createState() => HomeScreenState(journeys);
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  HomeScreenState(this.journeys);

  final List<DocumentSnapshot> journeys;
  final int _numTabs = 4;

  final _tabs = const <Widget>[
    Tab(text: 'Artists'),
    Tab(text: 'Events'),
    Tab(text: 'Journeys'),
    Tab(text: 'Messages'),
  ];

  List<Widget> get _tabBodies => <Widget>[
    ArtistSelectionScreen(),
    Text('Events'),
    JourneysScreen(journeys: journeys),
    MessagesScreen(),
  ];

  TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: _numTabs);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
      print('index: $_currentIndex');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _numTabs,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'SOUTHCITYMARKET',
            style: Theme.of(context).textTheme.headline.copyWith(fontSize: 22),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          bottom: TabBar(
            isScrollable: true,
            labelStyle: Theme.of(context).textTheme.subhead.copyWith(fontSize: 22),
            unselectedLabelStyle:
                Theme.of(context).textTheme.subhead.copyWith(fontSize: 22, color: Colors.white.withOpacity(0.7)),
            indicatorColor: Colors.white,
            tabs: _tabs,
          ),
        ),
        floatingActionButton: _currentIndex == 2 && journeys.isNotEmpty
            ? FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).accentColor,
                onPressed: () {
                  final nav = sl.get<ScreenNavigator>();
                  nav.openArtistSelection(context);
                },
              )
            : null,
        backgroundColor: Theme.of(context).backgroundColor,
        body: TabBarView(
          children: _tabBodies,
        ),
      ),
    );
  }
}
