import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/main-branch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class Branch extends StatelessWidget {
  final List<MainBranch> branches;
  const Branch({super.key, required this.branches});

  @override
  Widget build(BuildContext context) {
    launchCaller(phone) async {
      if (await canLaunch(phone)) {
        await launch(phone);
      } else {
        throw 'Could not launch $phone';
      }
    }

    Future<void> launchGeoLocation(bool isDir, String locationUrl) async {
      String url = locationUrl;

      // if (isDir) {
      //   url =
      //       'https://www.google.com/maps/dir/?api=1&origin=Googleplex&destination';
      // }

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    List<Widget> buildBranchList() {
      return branches.map((branch) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  branch.name,
                  style: TextStyles.font16BoldWeight.copyWith(
                    color: ColorsManager.primary,
                  ),
                ),
                // Text(
                //   '',
                //   style: TextStyles.font14RegularWeight,
                // ),
              ],
            ),
            tileColor: Colors.white,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                branch.location != ''
                    ? Container(
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
                              launchGeoLocation(false, branch.location!);
                            },
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  width: 10.w,
                ),
                branch.contactNumberOne != '' || branch.contactNumberTwo != ''
                    ? Container(
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
                              try {
                                if (branch.contactNumberOne != '') {
                                  await launchCaller(
                                      "tel: ${branch.contactNumberOne}");
                                } else if (branch.contactNumberTwo != '') {
                                  await launchCaller(
                                      "tel: ${branch.contactNumberTwo}");
                                }
                              } catch (e) {
                                const SnackBar(
                                  duration: Duration(seconds: 4),
                                  backgroundColor: Colors.red,
                                  content: Text('invalid mobile number'),
                                );
                              }
                            },
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            leading: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                'assets/icons/logo.png',
              ),
            ),
            contentPadding: const EdgeInsets.all(0),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            onTap: null,
            enabled: true,
          ),
        );
      }).toList();
    }

    return Column(
      children: buildBranchList(),
    );
  }
}
