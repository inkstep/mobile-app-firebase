import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/card.dart';
import 'package:inkstep/models/journey.dart';
import 'package:inkstep/resources/artists.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class MessagesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MessagesScreenState();
}

class MessagesScreenState extends State<MessagesScreen> {
  bool _shouldHoldLoading = false;

  bool disposed = false;

  Widget _buildLoading() {
    return Center(
        child: SpinKitChasingDots(
      color: Theme.of(context).cardColor,
      size: 50.0,
    ));
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  void _safeSetHolding() {
    if (!disposed) {
      setState(() => _shouldHoldLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AuthResult>(
      future: FirebaseAuth.instance.signInAnonymously(),
      builder: (BuildContext context, AsyncSnapshot<AuthResult> auth) {
        if (auth == null || !auth.hasData) {
          _shouldHoldLoading = true;
          Future<dynamic>.delayed(
            const Duration(seconds: 1),
            _safeSetHolding,
          );
          return _buildLoading();
        }

        return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('journeys')
              .where('auth_uid', isEqualTo: auth == null ? '-1' : auth.data.user.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // Check if we are done loading by the time loading spinner has been displayed
            if (!snapshot.hasData) {
              _shouldHoldLoading = true;
              Future<dynamic>.delayed(
                const Duration(seconds: 1),
                _safeSetHolding,
              );
              return _buildLoading();
            }

            // If we had to display loading, display it for minimum of k seconds
            if (_shouldHoldLoading) {
              return _buildLoading();
            }

            final journeys =
                snapshot.data.documents.map((doc) => Journey.fromMap(doc.data, id: doc.documentID)).toList();

            if (journeys.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Start a new journey to see your messages here',
                      style: Theme.of(context).accentTextTheme.body1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: journeys.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: JourneyConvoCard(journey: journeys[index]),
                );
              },
            );
          },
        );
      },
    );
  }
}

class JourneyConvoCard extends StatelessWidget {
  const JourneyConvoCard({
    Key key,
    @required this.journey,
  }) : super(key: key);

  final Journey journey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final ScreenNavigator nav = sl.get<ScreenNavigator>();
        nav.openJourneyMessagesScreen(
          context,
          CardModel(
            journey: journey,
            artist: offlineArtists[journey.artistId],
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 120,
              child: Card(
                color: Colors.black,
                clipBehavior: Clip.antiAlias,
                child: offlineArtists[journey.artistId].profileImage,
                shape: CircleBorder(),
                elevation: 1,
                margin: EdgeInsets.all(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 8.0),
              child: Text(
                journey.description + ' with ' + offlineArtists[journey.artistId].name,
                style: Theme.of(context).accentTextTheme.body2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
