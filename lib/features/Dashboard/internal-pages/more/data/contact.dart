import 'dart:typed_data';

class Contact {
  String title;
  String subTitle;
  Uint8List? image;
  String? phoneNumber;
  String? location;
  Contact({
    required this.title,
    required this.subTitle,
    this.image,
    required this.phoneNumber,
    this.location,
  });
}
