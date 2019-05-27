import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TattooConcept extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TattooConceptState();
}

class _TattooConceptState extends State<TattooConcept> {

  Future<File> imageFile;

  pickImageFromGallery(ImageSource source, int index) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage(int index) {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        var ret;
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          ret = Image.file(
            snapshot.data,
            width: 150,
            height: 150,
          );
        } else if (snapshot.error != null) {
          ret = const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          );
        } else {
          ret = const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          );
        }

        return GestureDetector(
          //onTap: pickImageFromGallery(ImageSource.gallery),
          child: Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(border: Border.all(), color: Colors.black),
              height: 150,
              width: 150,
              child: ret,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Choose some reference images, showing what you want. You'll get to talk about these later."),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[showImage(0), showImage(1)]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[showImage(2), showImage(3)]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[showImage(4), showImage(5)]),
              ],
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
