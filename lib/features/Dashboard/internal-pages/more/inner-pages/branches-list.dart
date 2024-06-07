import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/data/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchsList extends StatelessWidget {
  final List<Contact> contacts;
  const BranchsList({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    launchCaller(String phone) async {
      String url = "tel:$phone";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<void> launchGeoLocation(String location) async {
      String url = location;

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    final List<Map<String, dynamic>> branches = contacts.map((e) {
      return {
        'title': e.title,
        'subtitle': e.subTitle,
        'leadingImage': e.image,
        'haslocation': e.location != "" ? true : false,
        'location': e.location != '' ? e.location : '',
        'phone': e.phoneNumber != '' ? e.phoneNumber : '',
      };
    }).toList();

    Widget buildBranchList(int index) {
      return ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              branches[index]['title'],
              style: TextStyles.font16BoldWeight.copyWith(
                color: ColorsManager.primary,
              ),
            ),
            Text(
              branches[index]['subtitle'],
              style: TextStyles.font14RegularWeight.copyWith(
                color: ColorsManager.primarytinyMeduim,
              ),
            ),
          ],
        ),
        trailing: branches[index]['haslocation']
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManager.bluishWhite,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: IconButton(
                        icon: const Icon(Icons.place),
                        color: ColorsManager.primary,
                        onPressed: () {
                          launchGeoLocation(branches[index]['location']);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManager.bluishWhite,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: IconButton(
                        icon: const Icon(Icons.phone_in_talk),
                        color: ColorsManager.primary,
                        onPressed: () async {
                          await launchCaller(branches[index]['phone']);
                        },
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsManager.bluishWhite,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: IconButton(
                    icon: const Icon(Icons.phone_in_talk),
                    color: ColorsManager.primary,
                    onPressed: () async {
                      await launchCaller(branches[index]['phone']);
                    },
                  ),
                ),
              ),
        leading: branches[index]['leadingImage'].isEmpty
            ? Image.asset(
                'assets/icons/logo.png',
                width: 40.0,
                height: 40.0,
                cacheWidth: 40,
                cacheHeight: 40,
              )
            : Image.memory(
                branches[index]['leadingImage'],
                width: 40.0,
                height: 40.0,
              ),
      );
    }

    return Scaffold(
      appBar: const DashboardAppBar(
        title: 'Contact Us',
        haveIcon: false,
        haveLogo: false,
        hideBackButton: false,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) =>
            const Opacity(opacity: 0.3, child: Divider()),
        padding: const EdgeInsets.all(8),
        itemCount: branches.length,
        itemBuilder: (context, index) {
          return buildBranchList(index);
        },
      ),
    );
  }
}
