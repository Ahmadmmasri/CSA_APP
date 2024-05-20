import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/notifications/data/notification-model.dart';
import 'package:flutter/material.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final NotificationModel notification;
  const NotificationDetailsScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(
        haveIcon: false,
        haveLogo: false,
        title: 'CSA',
        hideBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            verticalSpace(15),
            Center(
              child: Text(
                notification.title.toString() != ''
                    ? notification.title.toString()
                    : 'Champions Swimming Academy',
                //  'Notification title',
                style: TextStyles.font16RegularWeight.copyWith(
                  color: ColorsManager.primary,
                ),
              ),
            ),
            verticalSpace(15),
            Center(
              child: Text(
                'Notification date',
                style: TextStyles.font14RegularWeight.copyWith(
                  color: ColorsManager.primarytinyMeduim,
                ),
              ),
            ),
            verticalSpace(5),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                notification.body.toString() != ''
                    ? notification.body.toString()
                    : 'At this stage of our swimmers journey, the focus will be on developing his/her strokes advanced techniques in a swim squad, as well as his/her fitness level with regards to the speed and stamina. During this level, students will be motivated to participate in the swim competitions in order to gain the experience of the box and monitor their development with regards to their swim time, so they can be advised to join any of the Jordanian swim clubs to be part of the competitive swimming community or practice it for their own fitness and for along healthy life style approach.',
                style: TextStyles.font14BlackRegularWeight.copyWith(
                  color: ColorsManager.black,
                  letterSpacing: 1.1,
                  height: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
