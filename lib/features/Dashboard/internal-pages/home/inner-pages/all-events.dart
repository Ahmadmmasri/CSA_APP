import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllEventsScreen extends StatefulWidget {
  final List<New> newtItems;
  const AllEventsScreen({super.key, required this.newtItems});

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  final controller = ScrollController();
  List items = [];
  bool isLoading = false;

  Future refresh() async {
    fetch();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;

    setState(() {
      isLoading = false;
      items.addAll(
        widget.newtItems.map((e) {
          return New(
            id: e.id,
            title: e.title,
            image: e.image,
            desscription: e.desscription,
            isActive: e.isActive,
          );
        }).toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(
        haveIcon: false,
        haveLogo: false,
        title: 'News & Events',
        hideBackButton: false,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          controller: controller,
          padding: const EdgeInsets.all(8),
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index < items.length) {
              final item = items[index];
              if (item.isActive) {
                return buildMemberAvatar(item, context);
              }
            }
            return null;
          },
        ),
      ),
    );
  }
}

Widget buildMemberAvatar(New events, BuildContext context) {
  String wordsDesc = '';
  if (events.desscription != null) {
    List words = events.desscription!.split(' ');
    if (words.length > 10) {
      wordsDesc =
          "${events.desscription!.split(' ').sublist(0, 10).join(' ')} ...";
    } else {
      wordsDesc = events.desscription!;
    }
  }

  return GestureDetector(
    onTap: () {
      context.pushNamed(Routes.eventDetailsScreen, arguments: events);
    },
    child: Container(
      padding: const EdgeInsets.all(3),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Hero(
                transitionOnUserGestures: true,
                tag: '${events.image}${events.id}',
                child: events.image!.isNotEmpty
                    ? Image.memory(
                        events.image!,
                        width: 343.w,
                        height: 210.h,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/icons/events-default.png',
                        fit: BoxFit.cover,
                        width: 343.w,
                        height: 210.h,
                      ),
              ),
            ),
            Container(
              width: 343.w,
              height: 120.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      events.title,
                      style: TextStyles.font16BoldWeight.copyWith(
                        color: ColorsManager.primary,
                      ),
                    ),
                    wordsDesc.isNotEmpty
                        ? Container(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Text(
                              wordsDesc,
                              style: TextStyles.font14RegularWeight.copyWith(
                                color: ColorsManager.black,
                                wordSpacing: 1.5,
                                height: 1.6,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildMemberText(List<String> memberDetails) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'title',
        style: TextStyles.font16BoldWeight.copyWith(
          color: ColorsManager.primary,
        ),
      ),
      Text(
        'subtitle',
        style: TextStyles.font14RegularWeight.copyWith(
          color: ColorsManager.primarytinyMeduim,
        ),
      ),
    ],
  );
}
