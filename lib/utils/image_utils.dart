import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImageUtils {
  static void uploadImage(Image image, {String forUser, String forJourney}) async {
    final filename = '${image.hashCode}';
    final ByteData byteData = await image.toByteData();
    _uploadImageByteData(byteData, filename, forUser, forJourney);
  }

  static void uploadAsset(Asset image, {String forUser, String forJourney}) async {
    final filename = '${image.hashCode}${image.name}';
    final ByteData byteData = await image.getByteData(quality: 40);
    _uploadImageByteData(byteData, filename, forUser, forJourney);
  }

  static void _uploadImageByteData(ByteData byteData, String filename, String authUid, String journeyId) async {
    final List<int> imageData = byteData.buffer.asUint8List();

    // Get storage path and upload
    final storageFileRef = '$authUid/$journeyId/$filename';
    final StorageReference ref = FirebaseStorage.instance.ref().child(storageFileRef);
    final StorageUploadTask uploadTask = ref.putData(imageData);
    final String url = await (await uploadTask.onComplete).ref.getDownloadURL();

    // Store download url in firestore since we can't query firebase storage
    Firestore.instance.collection('images').add(
      <String, dynamic>{
        'userId': authUid,
        'journeyId': journeyId,
        'url': url,
      },
    );
  }
}
