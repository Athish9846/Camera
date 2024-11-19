import 'dart:io';
import 'package:camera/db/db_helper.dart';
import 'package:camera/model/gallery_model.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key, this.model});
  final GalleryModel? model;

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  // int? _reloading;
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
          centerTitle: true,
          title: const Text(
            'Gallery',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.grey),
        ),
        body: SafeArea(
            child: ValueListenableBuilder(
          valueListenable: galleryNotifier,
          builder: (context, value, child) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 1 / 1.5),
            itemBuilder: (BuildContext context, int count) {
              final sortedList = value[count];
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(File(sortedList.image!)),
                      fit: BoxFit.cover),
                ),
                child: GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext ctx) => ImageDialog(
                      images: sortedList,
                    ),
                  ),
                ),
              );
            },
            itemCount: galleryNotifier.value.length,
          ),
        )));
  }
}

class ImageDialog extends StatelessWidget {
  final GalleryModel images;
  const ImageDialog({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 800,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: FileImage(File(images.image!)),
            )),
          ),
          const SizedBox(
            height: 1,
          ),
          ElevatedButton.icon(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext ctx) => AlertDialog(
                        content: const Text('Are you sure want to delete'),
                        actions: [
                          ElevatedButton.icon(
                              onPressed: () {
                                deleteimage(images.id!);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.black87,
                              ),
                              label: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.black87),
                              )),
                        ],
                      ));
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            label: const Text(
              'Delete',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
