import 'dart:typed_data';

class New {
  int id;
  String title;
  String? desscription;
  Uint8List? image;
  bool isActive;

  New({
    required this.id,
    required this.title,
    this.desscription,
    this.image,
    required this.isActive,
  });
}
