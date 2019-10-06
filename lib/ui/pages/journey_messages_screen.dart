import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/models/card.dart';
import 'package:inkstep/models/message.dart';

class JourneyMessagesScreen extends StatelessWidget {
  const JourneyMessagesScreen({Key key, @required this.card}) : super(key: key);

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.artist.name),
        backgroundColor: Theme.of(context).appBarTheme.color,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: FirebaseAuth.instance.signInAnonymously(),
        builder: (BuildContext context, AsyncSnapshot auth) {
          return StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('journey_messages')
                .where('auth_uid', isEqualTo: auth.hasData ? auth.data.user.uid : '-1')
                .where('journeyId', isEqualTo: this.card.journey.id)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data.documents.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message message = Message.fromMap(snapshot.data.documents[index].data);
                    return Card(
                      color: Theme.of(context).primaryColor,
                      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                      child: Text(message.journeyId),
                    );
                  },
                );
              }

              return Container(); // TODO(mdm): loading screen here
            },
          );
        },

      ),
    );
  }

/*Future<void> uploadJourney(String authUid) async {
    // Upload journey to firestore
    final Future<DocumentReference> doc = Firestore.instance.collection('journeys').add(
      <String, dynamic>{
        'artistId': int.parse(formData['artistID']),
        'auth_uid': authUid,
        'availability': formData['availability'],
        'clientEmail': formData['email'],
        'clientName': formData['name'],
        'clientPhone': '',
        'clientPhoneToken': '',
        'description': formData['mentalImage'],
        'position': formData['position'],
        'size': formData['size'],
        'style': formData['style'],
        'stage': 0,
//        'quoteLower': 100,
//        'quoteUpper': 120,
//        'date': '2019-11-22 13:00:00',
      },
    );*/
}
