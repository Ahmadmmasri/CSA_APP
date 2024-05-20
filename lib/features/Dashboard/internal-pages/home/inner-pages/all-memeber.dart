import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/memeber.dart';
import 'package:csa_app/features/login/data/user-children.dart';
import 'package:flutter/material.dart';

class AllMemeberScreen extends StatefulWidget {
  final List<Member> membersList;
  const AllMemeberScreen({super.key, required this.membersList});

  @override
  State<AllMemeberScreen> createState() => _AllMemeberScreenState();
}

class _AllMemeberScreenState extends State<AllMemeberScreen> {
  final controller = ScrollController();
  List items = [];
  int page = 1;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;

    if (widget.membersList.isNotEmpty) {
      setState(() {
        isLoading = false;
        items.addAll(
          widget.membersList.map((e) {
            return UserChildren(
              id: e.id,
              name: e.name,
              level: e.level,
              img: e.urlImage,
            );
          }).toList(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(
        haveIcon: false,
        haveLogo: false,
        title: 'Members',
        hideBackButton: false,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        controller: controller,
        padding: const EdgeInsets.all(8),
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index < items.length) {
            final item = items[index];
            return InkWell(
              onTap: () {
                context.pushNamed(
                  Routes.evalutionScreen,
                  arguments: Member(
                    id: item.id,
                    name: item.name,
                    urlImage: item.img,
                    level: item.level,
                  ),
                );
              },
              child: ListTile(
                title: buildMemberText(item),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: ColorsManager.primary,
                ),
                leading: buildMemberAvatar(""),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}

Widget buildMemberAvatar(String avatar) {
  return Container(
    padding: const EdgeInsets.all(3),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color:
          ColorsManager.primarytinyLight, // Adjust the border color as needed
    ),
    child: CircleAvatar(
      radius: 25.0,
      backgroundImage: avatar.isEmpty
          ? const AssetImage("assets/icons/member-default.png")
          : NetworkImage(
              avatar,
            ) as ImageProvider,
    ),
  );
}

Widget buildMemberText(UserChildren memberDetails) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        memberDetails.name!,
        style: TextStyles.font16BoldWeight.copyWith(
          color: ColorsManager.primary,
        ),
      ),
      // Text(
      //   'subtitle',
      //   style: TextStyles.font14RegularWeight.copyWith(
      //     color: ColorsManager.primarytinyMeduim,
      //   ),
      // ),
    ],
  );
}
