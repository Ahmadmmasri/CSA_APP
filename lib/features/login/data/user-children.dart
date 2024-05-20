import 'dart:typed_data';

import 'package:csa_app/features/Dashboard/internal-pages/home/data/level.dart';

class UserChildren {
  int? id;
  Level? level;
  String? name;
  Uint8List? img;

  UserChildren({
    this.id,
    this.name,
    this.level,
    this.img,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'level': level, 'img': img};
  }

  factory UserChildren.fromJson(Map<dynamic, dynamic> json) {
    return UserChildren(
      id: json['id'],
      name: json['name'],
      level: json['level'],
      img: json['img'],
    );
  }
}
