import 'dart:typed_data';

import 'package:csa_app/features/Dashboard/internal-pages/home/data/branch-academy.dart';

class Product {
  int id;
  double? price;
  bool? isActive;
  Uint8List img;

  String name;
  List<BranchAcademy>? availableBranchs;

  Product(
      {required this.id,
      this.price,
      this.isActive,
      required this.img,
      required this.name,
      this.availableBranchs});
}
