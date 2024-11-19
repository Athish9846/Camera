class GalleryModel {
  int? id;
  String? image;

  GalleryModel({this.id, required this.image});

  factory GalleryModel.fromMap(Map<String, dynamic> map) {
    return GalleryModel(id: map['id'], image: map['image']);
  }
}
