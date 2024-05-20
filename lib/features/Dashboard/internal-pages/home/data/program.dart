import 'dart:typed_data';

class Program {
  // int id;
  String name;
  String? description;
  Uint8List? img;
  String? bannerName;
  String? bannerColor;

  Program({
    // required this.id,
    required this.name,
    this.description,
    this.img,
    this.bannerName,
    this.bannerColor,
  });
}
