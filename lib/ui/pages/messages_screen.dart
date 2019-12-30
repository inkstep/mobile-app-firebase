import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inkstep/models/journey.dart';
import 'package:inkstep/resources/artists.dart';

class MessagesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MessagesScreenState();
}

class MessagesScreenState extends State<MessagesScreen> {
  bool _shouldHoldLoading = false;

  Widget _buildLoading() {
    return Center(
        child: SpinKitChasingDots(
      color: Theme.of(context).cardColor,
      size: 50.0,
    ));
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
            () => setState(() => _shouldHoldLoading = false),
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
                () => setState(() => _shouldHoldLoading = false),
              );
              return _buildLoading();
            }

            // If we had to display loading, display it for minimum of k seconds
            if (_shouldHoldLoading) {
              return _buildLoading();
            }

            final journeys =
                snapshot.data.documents.map((doc) => Journey.fromMap(doc.data)).toList();

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
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        journeys[index].description +
                            ' with ' +
                            offlineArtists[journeys[index].artistId].name,
                        style: Theme.of(context).accentTextTheme.body1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
