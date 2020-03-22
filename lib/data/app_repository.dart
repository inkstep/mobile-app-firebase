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

  // Update whether or not this user should get notifications for this artist
  Future<void> _updateSubscriptions(int artistId, String uid, {@required bool subscribe}) async {
    // Get current artist subscriptions
    final QuerySnapshot subs = await Firestore.instance
        .collection('artist_subs')
        .where('auth_uid', isEqualTo: uid)
        .getDocuments();

    if (subs.documents.isEmpty) {
      final List<int> subscriptions = subscribe ? [artistId] : [];
      Firestore.instance
          .collection('artist_subs')
          .add(<String, dynamic>{'auth_uid': uid, 'artistIds': subscriptions});
    } else {
      final List<dynamic> existing = subs.documents[0].data['artistIds'];
      final List<int> subscriptions = [];
      existing.forEach(subscriptions.add);

      if (subscribe) {
        // Add to list if not already there
        if (!subscriptions.contains(artistId)) {
          subscriptions.add(artistId);
        }
      } else {
        // Remove from list if there
        subscriptions.removeWhere((dynamic id) => id == artistId);
      }

      // Update existing doc
      Firestore.instance
          .collection('artist_subs')
          .document(subs.documents[0].documentID)
          .updateData(<String, dynamic>{'artistIds': subscriptions});
    }
  }

  void subscribeToArtist({@required String authUid, @required int artistId}) async {
    await _updateSubscriptions(artistId, authUid, subscribe: true);
  }

  void unsubscribeFromArtist({@required String authUid, @required int artistId}) async {
    await _updateSubscriptions(artistId, authUid, subscribe: false);
  }
}
