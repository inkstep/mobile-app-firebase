import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AppRepository {

  Stream<String> getAuthenticationStateChange() {
    return FirebaseAuth.instance.onAuthStateChanged.asyncMap((user) => user.uid);
  }

  Future<String> signInAnonymously() async {
    AuthResult auth = await FirebaseAuth.instance.signInAnonymously();
    return auth?.user.uid;
  }

  Stream<List<List<int>>> getArtistSubscriptions(String authUid) {
    return Firestore.instance
        .collection('artist_subs')
        .where('auth_uid', isEqualTo: authUid)
        .snapshots()
        .map<List<List<int>>>((querySnapshot) {
      return querySnapshot.documents
          .map<List<int>>((documentSnapshot) {
            List<dynamic> ids = documentSnapshot.data['artistIds'];
            return ids.map((dynamic i) => i as int).toList();
          })
          .toList();
    });
  }

  void subscribeToArtist({@required String authUid, @required int artistId}) async {

  }

  void unsubscribeFromArtist({@required String authUid, @required int artistId}) async {

  }
}
