import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/new.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/event-slider.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/header-section.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsEvents extends StatelessWidget {
  final List<New> news;

  const NewsEvents({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          HeaderSection(
            title: S.of(context).eventsAndNews,
            onTapViewAllButton: () => {
              context.pushNamed(Routes.allEventsScreen, arguments: news),
            },
          ),
          EventSlider(news: news),
        ],
      ),
    );
  }
}
