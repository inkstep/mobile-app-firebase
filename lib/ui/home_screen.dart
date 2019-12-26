import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/pages/journeys_screen.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.journeys}) : super(key: key);

  final List<DocumentSnapshot> journeys;

  @override
  State<StatefulWidget> createState() => HomeScreenState(journeys);
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  HomeScreenState(this.journeys);

  final List<DocumentSnapshot> journeys;

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
              Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                // TODO(mm): fade out at edge
                child: TabBar(
                  isScrollable: true,
                  labelStyle: Theme.of(context).textTheme.title,
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white.withOpacity(0.7)),
                  indicatorColor: Colors.white,
                  tabs: const <Widget>[
                    Tab(text: 'Journeys'),
                    Tab(text: 'Messages'),
                    Tab(text: 'Settings'),
                  ],
                ),
              ),
              Spacer(flex: 3),
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
              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
