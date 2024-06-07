import 'dart:typed_data';

import 'package:csa_app/features/Dashboard/internal-pages/home/data/level.dart';

class Member {
  String name;
  Uint8List? urlImage;
  int id;
  Level? level;
  Member({
    required this.name,
    required this.urlImage,
    required this.id,
    this.level,
  });
}
