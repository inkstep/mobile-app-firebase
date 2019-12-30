import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
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
  final int _numTabs = 3;

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: _numTabs);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _numTabs,
      child: Scaffold(
        appBar: AppBar(
          title: Text('SOUTHCITYMARKET', style: Theme.of(context).textTheme.title.copyWith(fontSize: 22)),
          backgroundColor: Theme.of(context).backgroundColor,
          bottom: TabBar(
            isScrollable: true,
            labelStyle: Theme.of(context).textTheme.subtitle,
            unselectedLabelStyle:
                Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white.withOpacity(0.7)),
            indicatorColor: Colors.white,
            tabs: const <Widget>[
              Tab(text: 'Journeys'),
              Tab(text: 'Messages'),
              Tab(text: 'Settings'),
            ],
          ),
        ),
        floatingActionButton: _tabController.index == 0 && journeys.isNotEmpty
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
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(flex: 6),
              Expanded(
                flex: 60,
                child: TabBarView(
                  children: <Widget>[
                    JourneysScreen(journeys: journeys),
                    Text('Messages'),
                    Text('Settings'),
                  ],
                ),
              ),
              Spacer(flex: 8),
            ],
          ),
        ),
      ),
    );
  }
}
