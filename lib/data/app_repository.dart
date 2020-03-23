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

  Future<List<int>> getArtistSubscriptions(String authUid) async {
    DocumentSnapshot doc = await Firestore.instance
        .collection('artist_subs')
        .document(authUid)
        .get();
    if (doc.exists) {
      List<dynamic> ids = doc.data['artistIds'];
      return ids.map((dynamic i) => i as int).toList();
    }
    return Future.value([]);
  }

  // Update whether or not this user should get notifications for this artist
  Future<void> _updateSubscriptions(int artistId, String uid, {@required bool subscribe}) async {
    final DocumentReference doc = Firestore.instance.collection('artist_subs').document(uid);
    final DocumentSnapshot e = await doc.get();

    // Does not exist, create
    if (!e.exists) {
      await doc.setData(<String, dynamic>{
        'artistIds': <int>[],
      });
    }

    await doc.updateData(<String, dynamic>{
      'artistIds': subscribe
          ? FieldValue.arrayUnion(<int>[artistId])
          : FieldValue.arrayRemove(<int>[artistId]),
    });
  }

  void subscribeToArtist({@required String authUid, @required int artistId}) async {
    await _updateSubscriptions(artistId, authUid, subscribe: true);
  }

  void unsubscribeFromArtist({@required String authUid, @required int artistId}) async {
    await _updateSubscriptions(artistId, authUid, subscribe: false);
  }
}
