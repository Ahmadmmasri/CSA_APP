// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Dive into the \n Champion's World`
  String get onBoardingOneTitle {
    return Intl.message(
      'Dive into the \n Champion\'s World',
      name: 'onBoardingOneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Learn from experienced coaches and join a community of passionate swimmers. CSA offers comprehensive training programs that cater to swimmers of all levels, from beginners to professionals.`
  String get onBoardingOneContent {
    return Intl.message(
      'Learn from experienced coaches and join a community of passionate swimmers. CSA offers comprehensive training programs that cater to swimmers of all levels, from beginners to professionals.',
      name: 'onBoardingOneContent',
      desc: '',
      args: [],
    );
  }

  /// `Set Goals, \n Measure Progress`
  String get onBoardingTwoTitle {
    return Intl.message(
      'Set Goals, \n Measure Progress',
      name: 'onBoardingTwoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Use CSA’s evaluation system to set goals for yourself or your child and track progress. With regular updates and feedback from our coaches, you can stay on top of your swimming game and steadily progress towards your goals.`
  String get onBoardingTwoContent {
    return Intl.message(
      'Use CSA’s evaluation system to set goals for yourself or your child and track progress. With regular updates and feedback from our coaches, you can stay on top of your swimming game and steadily progress towards your goals.',
      name: 'onBoardingTwoContent',
      desc: '',
      args: [],
    );
  }

  /// `Connect with the CSA \n Community`
  String get onBoardingThreeTitle {
    return Intl.message(
      'Connect with the CSA \n Community',
      name: 'onBoardingThreeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Join a community of like-minded swimmers and parents who share your passion for swimming. Connect with others, ask questions, and get support from fellow CSA members through our online forums and events.`
  String get onBoardingThreeContent {
    return Intl.message(
      'Join a community of like-minded swimmers and parents who share your passion for swimming. Connect with others, ask questions, and get support from fellow CSA members through our online forums and events.',
      name: 'onBoardingThreeContent',
      desc: '',
      args: [],
    );
  }

  /// `Login to your account`
  String get loginButton {
    return Intl.message(
      'Login to your account',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOutButton {
    return Intl.message(
      'Log Out',
      name: 'logOutButton',
      desc: '',
      args: [],
    );
  }

  /// `Continue as Guest`
  String get guestButton {
    return Intl.message(
      'Continue as Guest',
      name: 'guestButton',
      desc: '',
      args: [],
    );
  }

  /// `Resend Verification Code`
  String get resendOTPButton {
    return Intl.message(
      'Resend Verification Code',
      name: 'resendOTPButton',
      desc: '',
      args: [],
    );
  }

  /// `Login to your account`
  String get loginHeaderScreenTitle {
    return Intl.message(
      'Login to your account',
      name: 'loginHeaderScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter Mobile Number`
  String get mobileNumberTitle {
    return Intl.message(
      'Enter Mobile Number',
      name: 'mobileNumberTitle',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get invalidNumberTitle {
    return Intl.message(
      'Invalid phone number',
      name: 'invalidNumberTitle',
      desc: '',
      args: [],
    );
  }

  /// `Verify Your Mobile Number`
  String get otpScreenTitle {
    return Intl.message(
      'Verify Your Mobile Number',
      name: 'otpScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Send Verification`
  String get otpScreenSendButton {
    return Intl.message(
      'Send Verification',
      name: 'otpScreenSendButton',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get otpScreenCancelButton {
    return Intl.message(
      'Cancel',
      name: 'otpScreenCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Invalid or Unregistered \n Mobile Number`
  String get failLoginDialogTitle {
    return Intl.message(
      'Invalid or Unregistered \n Mobile Number',
      name: 'failLoginDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, the mobile number you entered is not valid or is not registered in our system. Please check and try again.`
  String get failLoginDialogDetail {
    return Intl.message(
      'Sorry, the mobile number you entered is not valid or is not registered in our system. Please check and try again.',
      name: 'failLoginDialogDetail',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get okButton {
    return Intl.message(
      'OK',
      name: 'okButton',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Programs`
  String get programs {
    return Intl.message(
      'Programs',
      name: 'programs',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop {
    return Intl.message(
      'Shop',
      name: 'shop',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Members`
  String get members {
    return Intl.message(
      'Members',
      name: 'members',
      desc: '',
      args: [],
    );
  }

  /// `Events & News`
  String get eventsAndNews {
    return Intl.message(
      'Events & News',
      name: 'eventsAndNews',
      desc: '',
      args: [],
    );
  }

  /// `Our Programs`
  String get OurPrograms {
    return Intl.message(
      'Our Programs',
      name: 'OurPrograms',
      desc: '',
      args: [],
    );
  }

  /// `Our Branches`
  String get ourbranches {
    return Intl.message(
      'Our Branches',
      name: 'ourbranches',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `No level details`
  String get noLevelDetails {
    return Intl.message(
      'No level details',
      name: 'noLevelDetails',
      desc: '',
      args: [],
    );
  }

  /// `Only sold at the CSA Academy`
  String get shopNote {
    return Intl.message(
      'Only sold at the CSA Academy',
      name: 'shopNote',
      desc: '',
      args: [],
    );
  }

  /// `JOD`
  String get jd {
    return Intl.message(
      'JOD',
      name: 'jd',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get appLanguage {
    return Intl.message(
      'App Language',
      name: 'appLanguage',
      desc: '',
      args: [],
    );
  }

  /// `About CSA`
  String get about {
    return Intl.message(
      'About CSA',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact {
    return Intl.message(
      'Contact us',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Champions Swimming Academy`
  String get facebookTitleLink {
    return Intl.message(
      'Champions Swimming Academy',
      name: 'facebookTitleLink',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get policy {
    return Intl.message(
      'Privacy Policy',
      name: 'policy',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get terms {
    return Intl.message(
      'Terms and Conditions',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `No Notifications Yet!`
  String get noNotificationsTitle {
    return Intl.message(
      'No Notifications Yet!',
      name: 'noNotificationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `When you get notifications, they’ll show up here`
  String get noNotificationsSubTitle {
    return Intl.message(
      'When you get notifications, they’ll show up here',
      name: 'noNotificationsSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logOutDialogMessage {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logOutDialogMessage',
      desc: '',
      args: [],
    );
  }

  /// `Yes, Confirm`
  String get logOutDialogConfirm {
    return Intl.message(
      'Yes, Confirm',
      name: 'logOutDialogConfirm',
      desc: '',
      args: [],
    );
  }

  /// `No, Cancel`
  String get logOutDialogCancel {
    return Intl.message(
      'No, Cancel',
      name: 'logOutDialogCancel',
      desc: '',
      args: [],
    );
  }

  /// `Current Course Evaluation`
  String get currentEvaluationLabel {
    return Intl.message(
      'Current Course Evaluation',
      name: 'currentEvaluationLabel',
      desc: '',
      args: [],
    );
  }

  /// `final Expectations for this level`
  String get finalEvaluationButton {
    return Intl.message(
      'final Expectations for this level',
      name: 'finalEvaluationButton',
      desc: '',
      args: [],
    );
  }

  /// `Previous Course Evaluation`
  String get prevEvaluationButton {
    return Intl.message(
      'Previous Course Evaluation',
      name: 'prevEvaluationButton',
      desc: '',
      args: [],
    );
  }

  /// `first`
  String get currentEvalutionFirstTab {
    return Intl.message(
      'first',
      name: 'currentEvalutionFirstTab',
      desc: '',
      args: [],
    );
  }

  /// `final`
  String get currentEvalutionFinalTab {
    return Intl.message(
      'final',
      name: 'currentEvalutionFinalTab',
      desc: '',
      args: [],
    );
  }

  /// `Evaluation`
  String get currentEvalutionTitle {
    return Intl.message(
      'Evaluation',
      name: 'currentEvalutionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Criteria`
  String get currentEvalutinCriteria {
    return Intl.message(
      'Criteria',
      name: 'currentEvalutinCriteria',
      desc: '',
      args: [],
    );
  }

  /// `No Evaluation Data Available`
  String get currentEvalutionNoData {
    return Intl.message(
      'No Evaluation Data Available',
      name: 'currentEvalutionNoData',
      desc: '',
      args: [],
    );
  }

  /// `The results are not yet available.`
  String get noData {
    return Intl.message(
      'The results are not yet available.',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `no level details`
  String get nolevel {
    return Intl.message(
      'no level details',
      name: 'nolevel',
      desc: '',
      args: [],
    );
  }

  /// `Book a swimming course`
  String get bookCourse {
    return Intl.message(
      'Book a swimming course',
      name: 'bookCourse',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get Confirmbook {
    return Intl.message(
      'Confirm',
      name: 'Confirmbook',
      desc: '',
      args: [],
    );
  }

  /// `Point System`
  String get pointSystemHeader {
    return Intl.message(
      'Point System',
      name: 'pointSystemHeader',
      desc: '',
      args: [],
    );
  }

  /// `Final Expectations Level `
  String get evaluationSystemHeader {
    return Intl.message(
      'Final Expectations Level ',
      name: 'evaluationSystemHeader',
      desc: '',
      args: [],
    );
  }

  /// `No Available Courses Currently`
  String get noCoursesBookMessage {
    return Intl.message(
      'No Available Courses Currently',
      name: 'noCoursesBookMessage',
      desc: '',
      args: [],
    );
  }

  /// `Select Course`
  String get selectCourseMessage {
    return Intl.message(
      'Select Course',
      name: 'selectCourseMessage',
      desc: '',
      args: [],
    );
  }

  /// `Join request sent successfully`
  String get successBookMessage {
    return Intl.message(
      'Join request sent successfully',
      name: 'successBookMessage',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, we couldn’t book your course.`
  String get failBookMessage {
    return Intl.message(
      'Sorry, we couldn’t book your course.',
      name: 'failBookMessage',
      desc: '',
      args: [],
    );
  }

  /// `1. Below Average`
  String get pointEvalutionOneTitle {
    return Intl.message(
      '1. Below Average',
      name: 'pointEvalutionOneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Attempts to demonstrate but does not show the proper technique.`
  String get pointEvalutionOneDesc {
    return Intl.message(
      'Attempts to demonstrate but does not show the proper technique.',
      name: 'pointEvalutionOneDesc',
      desc: '',
      args: [],
    );
  }

  /// `2. Average`
  String get pointEvalutionTwoTitle {
    return Intl.message(
      '2. Average',
      name: 'pointEvalutionTwoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Able to somewhat perform the proper technique.`
  String get pointEvalutionTwoDesc {
    return Intl.message(
      'Able to somewhat perform the proper technique.',
      name: 'pointEvalutionTwoDesc',
      desc: '',
      args: [],
    );
  }

  /// `3. Above Average`
  String get pointEvalutionThreeTitle {
    return Intl.message(
      '3. Above Average',
      name: 'pointEvalutionThreeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Perform the technique properly a lot of the time.`
  String get pointEvalutionThreeDesc {
    return Intl.message(
      'Perform the technique properly a lot of the time.',
      name: 'pointEvalutionThreeDesc',
      desc: '',
      args: [],
    );
  }

  /// `4. Exemplary Performance`
  String get pointEvalutionFourTitle {
    return Intl.message(
      '4. Exemplary Performance',
      name: 'pointEvalutionFourTitle',
      desc: '',
      args: [],
    );
  }

  /// `Always performs the technique properly.`
  String get pointEvalutionFourDesc {
    return Intl.message(
      'Always performs the technique properly.',
      name: 'pointEvalutionFourDesc',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
