import 'package:csa_app/core/routing/app_router.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/utility/shared_prefrences.dart';
import 'package:csa_app/features/login/logic/cubit/csa_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class CsaApp extends StatelessWidget {
  final AppRouter appRouter;

  const CsaApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        _fetchUserInfo(),
        _fetchIndecatorState(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingScreen();
        } else if (snapshot.hasError) {
          return _buildErrorScreen(snapshot.error.toString());
        } else {
          String userInfo = snapshot.data![0];
          bool indecator = snapshot.data![1];

          return _buildApp(context, userInfo, indecator);
        }
      },
    );
  }

  Future<String> _fetchUserInfo() async {
    UserSharedPrefrences userSharedPrefrences = UserSharedPrefrences();
    return await userSharedPrefrences.getToken();
  }

  Future<bool> _fetchIndecatorState() async {
    UserSharedPrefrences userSharedPrefrences = UserSharedPrefrences();
    bool s = await userSharedPrefrences.getIndecatorState();
    return s;
  }

  Widget _buildLoadingScreen() {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorScreen(String error) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }

  Widget _buildApp(BuildContext context, String token, bool hideIndecator) {
    debugInvertOversizedImages = false;
    return BlocProvider<CsaAuthCubit>(
      create: (context) => CsaAuthCubit()..getSavedLang(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<CsaAuthCubit, CsaAuthState>(
            builder: (context, state) {
              if (state is CurrentLang) {
                return ScreenUtilInit(
                  designSize:
                      const Size(375, 812), // size of screen in design h and w,
                  minTextAdapt: true, //adapt text to screen size
                  child: MaterialApp(
                    title: 'CSA App',
                    theme: ThemeData(
                      primaryColor: ColorsManager.primary,
                      scaffoldBackgroundColor: Colors.white,
                    ),
                    // locale: const Locale('ar'),
                    locale: Locale(state.locale.languageCode),
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    // navigatorKey: GlobalKey<NavigatorState>(),
                    navigatorKey: navigatorKey,
                    debugShowCheckedModeBanner: false,
                    initialRoute: token.isNotEmpty
                        ? Routes.dashboardScreen
                        : hideIndecator
                            ? Routes.welcomeScreenLogin
                            : Routes.onBoardingScreen,
                    onGenerateRoute: appRouter.generateRoute,
                  ),
                );
              }
              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}



//backup

// final navigatorKey = GlobalKey<NavigatorState>();

// class CsaApp extends StatelessWidget {
//   final AppRouter appRouter;
//   const CsaApp({Key? key, required this.appRouter}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String>(
//       future: _fetchUserInfo(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return _buildLoadingScreen();
//         } else if (snapshot.hasError) {
//           return _buildErrorScreen(snapshot.error.toString());
//         } else {
//           String userInfo = snapshot.data!;
//           return _buildApp(userInfo);
//         }
//       },
//     );
//   }

//   Future<String> _fetchUserInfo() async {
//     UserSharedPrefrences userSharedPrefrences = UserSharedPrefrences();
//     return await userSharedPrefrences.getToken();
//   }

//   Widget _buildLoadingScreen() {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorScreen(String error) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text('Error: $error'),
//         ),
//       ),
//     );
//   }

//   Widget _buildApp(String token) {
//     debugInvertOversizedImages = true;
//     return BlocProvider<CsaAuthCubit>(
//       create: (context) => CsaAuthCubit()..getSavedLang(),
//       child: BlocBuilder<CsaAuthCubit, CsaAuthState>(
//         buildWhen: (previousState, currentState) =>
//             previousState != currentState,
//         builder: (context, state) {
//           if (state is CurrentLang) {
//             return ScreenUtilInit(
//               designSize:
//                   const Size(375, 812), // size of screen in design h and w,
//               minTextAdapt: true, //adapt text to screen size
//               child: MaterialApp(
//                 title: 'CSA App',
//                 theme: ThemeData(
//                   primaryColor: ColorsManager.primary,
//                   scaffoldBackgroundColor: Colors.white,
//                 ),
//                 // locale: const Locale('ar'),
//                 locale: Locale(state.locale.languageCode),
//                 localizationsDelegates: const [
//                   S.delegate,
//                   GlobalMaterialLocalizations.delegate,
//                   GlobalWidgetsLocalizations.delegate,
//                   GlobalCupertinoLocalizations.delegate,
//                 ],
//                 supportedLocales: S.delegate.supportedLocales,
//                 navigatorKey: navigatorKey,
//                 debugShowCheckedModeBanner: false,
//                 initialRoute: token.isNotEmpty
//                     ? Routes.dashboardScreen
//                     : Routes.onBoardingScreen,
//                 onGenerateRoute: appRouter.generateRoute,
//               ),
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }
