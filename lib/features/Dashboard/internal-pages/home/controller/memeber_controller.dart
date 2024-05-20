import 'package:csa_app/features/Dashboard/internal-pages/home/controller/home_controller.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/memeber.dart';
import 'package:csa_app/features/login/data/user-children.dart';

class MemberController {
  HomeController homeController = HomeController();
  List<UserChildren> children = [];
  List<Member> membersList = [];
  Future<List<Member>> initializeMemeber() async {
    children = await homeController.fetchChildren();
    membersList = children
        .map((child) => Member(
              name: child.name!,
              id: child.id!,
              urlImage: child.img,
              level: child.level!,
            ))
        .toList();

    return membersList;
  }
}
