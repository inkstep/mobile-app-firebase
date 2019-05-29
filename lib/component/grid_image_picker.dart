import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GridImagePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GridImagePickerState();
}

class _GridImagePickerState extends State<GridImagePicker> {
  Future<File> _tattooImage;

  void pickImageFromGallery(ImageSource source) {
    setState(() {
      _tattooImage = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: _tattooImage,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        Image ret;
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          ret = Image.file(
            snapshot.data,
            width: 150,
            height: 150,
          );
        } else if (snapshot.error != null) {
          ret = Image.network(
              'https://dummyimage.com/400/000/fff.png&text=Error+selecting');
        } else {
          ret = Image.network(
              'https://dummyimage.com/400/000/fff.png&text=No+image+selected');
        }
        return GestureDetector(
          // onTap: pickImageFromGallery(ImageSource.gallery, index),
          child: Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
            decoration:
                BoxDecoration(border: Border.all(), color: Colors.black),
            height: 150,
            width: 150,
            child: ret,
          ),
        );
      },
    );
  }

  Widget getTattooImages() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[showImage(), showImage()]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[showImage(), showImage()]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[showImage(), showImage()]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
                "Choose some reference images, showing what you want. You'll get to talk about these later."),
            Expanded(
              child: getTattooImages(),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            pickImageFromGallery(ImageSource.gallery);
          },
        ),
      ),
    );
  }
}
