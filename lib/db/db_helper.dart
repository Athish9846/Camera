import 'package:camera/model/gallery_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<GalleryModel>> galleryNotifier = ValueNotifier([]);

late Database _db;
Future<void> initialiazeDataBase() async {
  _db = await openDatabase('gallery.db', version: 1,
      onCreate: (Database db, int version) async {
    await db
        .execute('CREATE TABLE gallery(id INTEGER PRIMARY KEY, image TEXT)');
  });
}

Future<void> addImage(GalleryModel value) async {
  await _db.rawInsert('INSERT INTO gallery(image) VALUES(?)', [value.image]);

  await getGallery();
}

Future<void> getGallery() async {
  final values = await _db.rawQuery('SELECT * FROM gallery');
  galleryNotifier.value.clear();
  for (var list in values) {
    final user = GalleryModel.fromMap(list);
    galleryNotifier.value.add(user);
    // galleryNotifier.notifyListeners();
  }
}

Future<void> deleteimage(int id) async {
  await _db.rawDelete('DELETE FROM gallery WHERE id = ?', [id]);
  await getGallery();
  galleryNotifier.notifyListeners();

}
