// class app router

import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/features/Dashboard/dashboard-screen.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/course.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/elevated-screen.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/current-evalute/current-evalute-record-screen.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/previous-evalute/previous-evalute-record-screen.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/memeber.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/new.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/program.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/inner-pages/all-events.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/inner-pages/all-memeber.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/inner-pages/event-details.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/data/about.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/data/contact.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/data/terms.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/inner-pages/about-us.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/inner-pages/branches-list.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/inner-pages/widgets/details.dart';
import 'package:csa_app/features/Dashboard/internal-pages/notifications/data/notification-model.dart';
import 'package:csa_app/features/Dashboard/internal-pages/notifications/notification-screen.dart';
import 'package:csa_app/features/Dashboard/internal-pages/notifications/widgets/inner-pages/notifcation-details-screen.dart';
import 'package:csa_app/features/Dashboard/internal-pages/program/widget/program-details.dart';
import 'package:csa_app/features/login/logic/cubit/csa_auth_cubit.dart';
import 'package:csa_app/features/login/ui/login_screen.dart';
import 'package:csa_app/features/login/ui/otp-screen.dart';
import 'package:csa_app/features/onboarding/onboarding_screen.dart';
import 'package:csa_app/features/onboarding/welcome-login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  CsaAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = CsaAuthCubit();
  }

  Route generateRoute(RouteSettings settings) {
    // this argumants to be passed in any screen like ( argumants as ClassName )
    final argumants = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: phoneAuthCubit!,
            child: const LoginScreen(),
          ),
        );
      case Routes.welcomeScreenLogin:
        return MaterialPageRoute(
          builder: (_) => const LoginWelcome(),
        );
      case Routes.otpScreen:
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );
      case Routes.dashboardScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: phoneAuthCubit!,
            child: const DahsboardScreen(),
          ),
        );
      case Routes.allMemebrScreen:
        final members = argumants as List<Member>;
        // final args = argumants as Map<String, dynamic>;
        // final latestCourses = args['latestCourse'] as Course;
        // final members = args['members'] as List<Member>;
        return MaterialPageRoute(
          builder: (_) => AllMemeberScreen(membersList: members),
        );
      case Routes.allEventsScreen:
        final news = argumants as List<New>;
        return MaterialPageRoute(
          builder: (_) => AllEventsScreen(newtItems: news),
        );
      case Routes.termsAndconditionScreen:
        final data = argumants as Terms;
        return MaterialPageRoute(
          builder: (_) => Details(term: data),
        );
      case Routes.eventDetailsScreen:
        final argument = argumants as New;
        return MaterialPageRoute(
          builder: (_) => EventDetailsScreen(item: argument),
        );
      case Routes.evalutionScreen:
        final argument = argumants as Member;
        return MaterialPageRoute(
          builder: (_) => EvalutionScreen(member: argument),
        );
      case Routes.notificationScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: phoneAuthCubit!,
            child: const NotificationScreen(),
          ),
        );
      case Routes.notificationDetailsScreen:
        // final notification = (argumants as RemoteNotification);
        NotificationModel notificationArg;
        if (argumants is RemoteNotification) {
          final remoteNotification = argumants;
          notificationArg = NotificationModel(
            title: remoteNotification.title ?? '',
            body: remoteNotification.body ?? '',
          );
        } else if (argumants is NotificationModel) {
          notificationArg = argumants;
        } else {
          notificationArg = argumants as NotificationModel;
        }

        return MaterialPageRoute(
          builder: (_) => NotificationDetailsScreen(
            notification: notificationArg,
          ),
        );
      case Routes.programDetailsScreen:
        final program = argumants as Program;
        return MaterialPageRoute(
          builder: (_) => ProgramDetails(programDetails: program),
        );
      case Routes.aboutUsScreen:
        final about = argumants as About;
        return MaterialPageRoute(
          builder: (_) => AboutUsScreen(aboutData: about),
        );
      case Routes.branchScreen:
        final contact = argumants as List<Contact>;
        return MaterialPageRoute(
          builder: (_) => BranchsList(
            contacts: contact,
          ),
        );
      case Routes.currentEvaluteRecordScreen:
        final args = argumants as Map<String, dynamic>;
        final latestCourses = args['latestCourse'] as Course;
        final member = args['member'] as Member;
        return MaterialPageRoute(
          builder: (_) => CurrentEvaluteRecordScreen(
              currentCourse: latestCourses, member: member),
        );
      case Routes.previousEvaluteRecordScreen:
        // final courses = argumants as List<Course>;
        final args = argumants as Map<String, dynamic>;
        final courses = args['courses'] as List<Course>;
        final member = args['member'] as Member;
        return MaterialPageRoute(
          builder: (_) =>
              PreviousEvaluteRecordScreen(course: courses, member: member),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
