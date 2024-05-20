import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/controller/moreController.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/data/about.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/data/contact.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/data/terms.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late About aboutCsa = About(name: '', description: '', imgUrl: '');
  bool isloading = false;
  late Terms termsCsa = Terms(name: '', heade: '');
  late Terms privacyCsa = Terms(name: '', heade: '');
  late List<Contact> contactsCsa = [];

  @override
  void initState() {
    super.initState();
    isloading = true;
    _loadData();
  }

  Future<void> _loadData() async {
    final Future<About> about = MoreController().fetchAboutCsa();
    final Future<Terms> terms = MoreController().fetchTerms(0);
    final Future<Terms> privacy = MoreController().fetchTerms(1);
    final Future<List<Contact>> contact = MoreController().fetchContactInfo();

    final List<dynamic> results =
        await Future.wait([about, terms, privacy, contact]);

    setState(() {
      aboutCsa = results[0] as About;
      termsCsa = results[1] as Terms;
      privacyCsa = results[2] as Terms;
      contactsCsa = results[3] as List<Contact>;
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    Future<void> launchSocialMediaURL(url) async {
      try {
        bool launched = await launch(url, forceSafariVC: false);

        if (!launched) {
          launch(url);
        }
      } catch (e) {
        launch(url);
      }
    }

    List items = [
      {
        'title': S.of(context).about,
        'icon': Image.asset(
          'assets/icons/circler-logo.png',
          width: 40,
        ),
        'urlPath': Routes.aboutUsScreen,
        'argument': aboutCsa,
        'socialMedia': false,
      },
      {
        'title': S.of(context).contact,
        'icon': Image.asset(
          'assets/icons/call-icon.png',
          width: 40,
        ),
        'urlPath': Routes.branchScreen,
        'argument': contactsCsa,
        'socialMedia': false,
      },
      {
        'title': S.of(context).facebookTitleLink,
        'icon': Image.asset(
          'assets/icons/facebook-icon.png',
          width: 40,
        ),
        'argument': null,
        'urlPath': "https://www.facebook.com/csaamman/",
        'socialMedia': true,
      },
      {
        'title': 'csa_amman',
        'icon': Image.asset(
          'assets/icons/instagram-icon.png',
          width: 40,
        ),
        'argument': null,
        'urlPath': "https://www.instagram.com/csa_amman/",
        'socialMedia': true,
      },
      {
        'title': S.of(context).policy,
        'icon': Image.asset(
          'assets/icons/privacy-icon.png',
          width: 40,
        ),
        'argument': termsCsa,
        'urlPath': Routes.termsAndconditionScreen,
        'socialMedia': false,
      },
      {
        'title': S.of(context).terms,
        'icon': Image.asset(
          'assets/icons/terms-icon.png',
          width: 40,
        ),
        'argument': privacyCsa,
        'urlPath': Routes.termsAndconditionScreen,
        'socialMedia': false,
      },
    ];

    return Scaffold(
      appBar: DashboardAppBar(
        title: S.of(context).more,
        haveIcon: false,
        haveLogo: false,
        hideBackButton: true,
      ),
      body: isloading
          ? Center(
              child: Lottie.asset(
                'assets/animated/loading.json',
                width: 100.w,
                height: 100.h,
              ),
            )
          : ListView.separated(
              separatorBuilder: (context, index) =>
                  const Opacity(opacity: 0.3, child: Divider()),
              controller: controller,
              padding: const EdgeInsets.all(8),
              itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index < items.length) {
                  final item = items[index];
                  return InkWell(
                    onTap: () {
                      item['socialMedia']
                          ? launchSocialMediaURL(item['urlPath'])
                          : context.pushNamed(item['urlPath'],
                              arguments: item['argument']);
                    },
                    child: ListTile(
                      title: Text(
                        item['title'],
                        style: TextStyles.font14RegularWeight.copyWith(
                          color: ColorsManager.primary,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: ColorsManager.primary,
                      ),
                      leading: item['icon'],
                    ),
                  );
                }
                return null;
              },
            ),
    );
  }
}
