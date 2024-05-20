import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/notifications/data/controller/notification-controller.dart';
import 'package:csa_app/features/Dashboard/internal-pages/notifications/data/notification-model.dart';
import 'package:csa_app/features/Dashboard/internal-pages/notifications/widgets/no-notification.dart';
import 'package:csa_app/features/login/data/user-profile.dart';
import 'package:csa_app/features/login/logic/cubit/csa_auth_cubit.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<bool> isAuthFuture;
  late ScrollController _scrollController;
  late List<NotificationModel> notifications;
  bool isLoading = false;
  int _pageNumber = 1;
  int _pageSize = 12; // Set your preferred page size here

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    isAuthFuture = getUserinfo();
    notifications = [];
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    setState(() {
      isLoading = true;
    });
    List<NotificationModel> newNotifications = await getNotification(
      pageNumber: _pageNumber,
      pageSize: _pageSize,
    );
    setState(() {
      notifications.addAll(newNotifications);
      isLoading = false;
    });
  }

  Future<List<NotificationModel>> getNotification(
      {required int pageNumber, required int pageSize}) async {
    List<NotificationModel> fetchedNotifications =
        await NotificationController().fetchNotification(
      pageSize,
      pageNumber,
    );
    return fetchedNotifications;
  }

  Future<bool> getUserinfo() async {
    UserProfile userProfile =
        await BlocProvider.of<CsaAuthCubit>(context).getUserDetails();
    return userProfile.token != null;
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // At the bottom of the list
      setState(() {
        _pageNumber++; // Increment page number
        loadNotifications(); // Load more notifications
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        haveIcon: false,
        haveLogo: false,
        title: S.of(context).notifications,
        hideBackButton: false,
      ),
      body: Column(
        children: [
          FutureBuilder<bool>(
            future: isAuthFuture,
            builder: (context, authSnapshot) {
              if (authSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset(
                    'assets/animated/loading.json',
                    width: 100.w,
                    height: 100.h,
                  ),
                );
              } else if (authSnapshot.hasError) {
                return Center(
                  child: Text('Error: ${authSnapshot.error}'),
                );
              } else {
                bool isAuth = authSnapshot.data!;
                return isAuth
                    ? Expanded(child: _buildNotificationList())
                    : const NoNotification();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    return notifications.isNotEmpty
        ? ListView.separated(
            controller: _scrollController,
            separatorBuilder: (context, index) => const Divider(),
            padding: const EdgeInsets.all(8),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final item = notifications[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    Routes.notificationDetailsScreen,
                    arguments: item,
                  );
                },
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title!,
                        style: TextStyles.font14RegularWeight.copyWith(
                          color: ColorsManager.primary,
                        ),
                      ),
                      Text(
                        item.body!,
                        style: TextStyles.font12RegularWeight.copyWith(
                          color: ColorsManager.primarytinyMeduim,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: ColorsManager.primary,
                  ),
                  // leading: const CircleAvatar(
                  //   radius: 4,
                  //   backgroundColor: ColorsManager.darkRed,
                  // ),
                ),
              );
            },
          )
        : !isLoading
            ? const NoNotification()
            : Center(
                child: Lottie.asset(
                  'assets/animated/loading.json',
                  width: 100.w,
                  height: 100.h,
                ),
              );
  }
}


//prev code

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   late Future<bool> isAuthFuture;
//   late Future<List<NotificationModel>> notificationsFuture;

//   @override
//   void initState() {
//     super.initState();
//     isAuthFuture = getUserinfo();
//     notificationsFuture = getNotification();
//   }

//   Future<List<NotificationModel>> getNotification() async {
//     List<NotificationModel> notifications =
//         await NotificationController().fetchNotification();
//     return notifications;
//   }

//   Future<bool> getUserinfo() async {
//     UserProfile userProfile =
//         await BlocProvider.of<CsaAuthCubit>(context).getUserDetails();
//     return userProfile.token != null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: DashboardAppBar(
//         haveIcon: false,
//         haveLogo: false,
//         title: S.of(context).notifications,
//         hideBackButton: false,
//       ),
//       body: FutureBuilder<List<dynamic>>(
//         future: Future.wait([isAuthFuture, notificationsFuture]),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: Lottie.asset(
//                 'assets/animated/loading.json',
//                 width: 100.w,
//                 height: 100.h,
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             bool isAuth = snapshot.data![0];
//             var notifications = snapshot.data![1];
//             return isAuth
//                 ? _buildNotificationList(notifications)
//                 : const NoNotification();
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildNotificationList(List<NotificationModel> notifications) {
//     return notifications.isNotEmpty
//         ? ListView.separated(
//             separatorBuilder: (context, index) => const Divider(),
//             padding: const EdgeInsets.all(8),
//             itemCount: notifications.length,
//             itemBuilder: (context, index) {
//               final item = notifications[index];
//               return InkWell(
//                 onTap: () {
//                   Navigator.of(context).pushNamed(
//                     Routes.notificationDetailsScreen,
//                     arguments: item,
//                   );
//                 },
//                 child: ListTile(
//                   title: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         item.title!,
//                         style: TextStyles.font14RegularWeight.copyWith(
//                           color: ColorsManager.primary,
//                         ),
//                       ),
//                       Text(
//                         item.body!,
//                         style: TextStyles.font12RegularWeight.copyWith(
//                           color: ColorsManager.primarytinyMeduim,
//                         ),
//                       ),
//                     ],
//                   ),
//                   trailing: const Icon(
//                     Icons.chevron_right,
//                     color: ColorsManager.primary,
//                   ),
//                   leading: const CircleAvatar(
//                     radius: 4,
//                     backgroundColor: ColorsManager.darkRed,
//                   ),
//                 ),
//               );
//             },
//           )
//         : const NoNotification();
//   }
// }
