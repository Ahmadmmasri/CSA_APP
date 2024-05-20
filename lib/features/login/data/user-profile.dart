import 'package:csa_app/features/login/data/user-children.dart';

class UserProfile {
  int? id;
  String? name;
  String? token;
  bool? uuid;
  String? phone;
  List<UserChildren>? childrenIds;

  // Constructor
  UserProfile({
    this.id,
    this.name,
    this.token,
    this.uuid,
    this.phone,
    this.childrenIds,
  });
}
