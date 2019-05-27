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

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  List<Widget> _buildGridTiles(numberOfTiles) {
    List<Container> containers =
    new List<Container>.generate(numberOfTiles, (int index) {
      final imageName = index < 9
          ? 'images/image0${index + 1}.JPG'
          : 'images/image${index + 1}.JPG';
      return new Container(
        child: new Image.asset(imageName, fit: BoxFit.fill),
      );
    });
    return containers;
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GridView.extent(
            maxCrossAxisExtent: 150.0,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            padding: const EdgeInsets.all(5.0),
            children: [showImage()],
          ),
          RaisedButton(
            child: Text("Select Image from Gallery"),
            onPressed: () {
              pickImageFromGallery(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
