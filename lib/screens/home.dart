import 'dart:io';
import 'package:camera/model/gallery_model.dart';
import 'package:camera/screens/gallery.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../db/db_helper.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGallery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'CAMERA',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: () async{
                  await _pickImageFromGallery();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const Gallery()));
                },
                icon: const Icon(Icons.camera_alt_rounded),
                label: const Text(
                  'CAM',
                  style: TextStyle(color: Colors.black),
                )),
            const SizedBox(
              width: 50,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const Gallery()));
                },
                icon: const Icon(Icons.browse_gallery_rounded),
                label: const Text('GALLERY')),
          ],
        ),
      )),
    );
  }
}

Future<File?> _pickImageFromGallery() async {
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  if (pickedImage != null) {
    final GalleryModel galleryModel = GalleryModel(image: pickedImage.path);
    addImage(galleryModel);

    // return File(pickedImage.path);
  }
  return null;
}
