import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/shared-widgets/app-text-button.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/controller/evaluate_controller.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/course.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/widget/diagrams.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/memeber.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EvalutionScreen extends StatefulWidget {
  final Member member;
  const EvalutionScreen({super.key, required this.member});

  @override
  State<EvalutionScreen> createState() => _EvalutionScreenState();
}

class _EvalutionScreenState extends State<EvalutionScreen> {
  late Future<List<Course>> coursesFuture;
  List<Course> courses = [];
  // bool isLoading = false;

  @override
  void initState() {
    super.initState();
    coursesFuture = EvaluateController().fetchCourses(widget.member.id);
    coursesFuture.then((value) {
      setState(() {
        courses = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final snackBar = SnackBar(
      content: const Text('no data currently available'),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
              height: heightScreen,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ResizeImage(
                    AssetImage('assets/images/evalution-bg.png'),
                    width: 1080,
                    height: 2148,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/logo.png',
                    width: 100.w,
                    cacheWidth: 165,
                  ),
                  verticalSpace(20),
                  Diagrambars(member: widget.member),
                  verticalSpace(20),
                  Column(
                    children: [
                      AppTextButton(
                        buttonText: S.of(context).currentEvaluationLabel,
                        textStyle: courses.isEmpty
                            ? const TextStyle(color: ColorsManager.lightGrey)
                            : const TextStyle(color: ColorsManager.white),
                        backgroundColor: courses.isEmpty
                            ? Colors.grey
                            : ColorsManager.primary,
                        disabled: courses.isEmpty ? true : false,
                        onPressed: () {
                          if (courses.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            context.pushNamed(
                              Routes.currentEvaluteRecordScreen,
                              arguments: {
                                'latestCourse': courses.last,
                                'member': widget.member,
                              },
                            );
                          }
                        },
                        borderRadius: 4,
                        buttonWidth: widthScreen * 0.9,
                      ),
                      verticalSpace(15),
                      AppTextButton(
                        buttonText: S.of(context).prevEvaluationButton,
                        backgroundColor:
                            courses.isEmpty ? Colors.grey : ColorsManager.white,
                        borderRadius: 4,
                        buttonWidth: widthScreen * 0.9,
                        disabled: courses.isEmpty ? true : false,
                        textStyle: courses.isEmpty
                            ? const TextStyle(color: ColorsManager.lightGrey)
                            : const TextStyle(color: ColorsManager.primary),
                        onPressed: () {
                          if (courses.isNotEmpty) {
                            context.pushNamed(
                              Routes.previousEvaluteRecordScreen,
                              arguments: {
                                'courses': courses,
                                'member': widget.member,
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                      )
                    ],
                  )
                ],
              )),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1,
          left: context.isArabic ? MediaQuery.of(context).size.width - 80 : 20,
          child: FloatingActionButton(
            onPressed: () {
              context.pop();
            },
            backgroundColor: ColorsManager.white.withOpacity(0.95),
            shape: const CircleBorder(),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: ColorsManager.primarytinyMeduim,
            ),
          ),
        ),
      ],
    );
  }
}
