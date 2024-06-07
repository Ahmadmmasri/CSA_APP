import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/shared-widgets/app-text-button.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/controller/evaluate_controller.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/current-evalute/inner-pages/current-evalute-record.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/current-evalute/widgets/down-sheet.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/course.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/evalution.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/level-expecation.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/previous-evalute/inner-pages/motovation-circle.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/memeber.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CurrentEvaluteRecordScreen extends StatefulWidget {
  final Course currentCourse;
  final Member member;

  const CurrentEvaluteRecordScreen({
    Key? key,
    required this.currentCourse,
    required this.member,
  }) : super(key: key);

  @override
  State<CurrentEvaluteRecordScreen> createState() =>
      _CurrentEvaluateRecordScreenState();
}

class _CurrentEvaluateRecordScreenState
    extends State<CurrentEvaluteRecordScreen> {
  List<Evalution> evaluations = [];
  Evalution sortedEvaluations = Evalution();
  Evalution sortedEvaluationsFiltered = Evalution();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchEvaluations('first');
  }

  Future<void> fetchEvaluations(String stage) async {
    setState(() => isLoading = true);
    evaluations = await EvaluateController().fetchStudentCourse(
      widget.member.id,
      widget.currentCourse.id,
    );
    sortEvaluations(stage);
    setState(() => isLoading = false);
  }

  void sortEvaluations(String stage) {
    sortedEvaluations = evaluations.isNotEmpty
        ? evaluations.firstWhere(
            (e) => (e).evaluationType == 'points',
            orElse: () => evaluations.first,
          )
        : evaluations.first;

    if (evaluations.first.evaluationType == 'criteria') {
      if (stage == 'first' || stage == 'final') {
        sortedEvaluationsFiltered.studentEvaluation = evaluations
            .first.studentEvaluation
            ?.where((element) => element.stage == stage)
            .toList();
        sortedEvaluationsFiltered.expectations = evaluations.first.expectations;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        title: widget.member.name,
        haveIcon: false,
        haveLogo: false,
        hideBackButton: false,
      ),
      body: Column(
        children: [
          verticalSpace(20),
          Center(
            child: Image.asset('assets/icons/circler-logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 2),
            child: Text(
              S.of(context).currentEvaluationLabel,
              style: TextStyles.font14BlackRegularWeight.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (sortedEvaluations.evaluationType != 'points')
            Text(
              'Level ${widget.member.level?.name}',
              style: TextStyles.font14BlackRegularWeight.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          verticalSpace(7),
          isLoading
              ? Lottie.asset(
                  'assets/animated/loading.json',
                  width: 100.w,
                  height: 100.h,
                )
              : sortedEvaluations.evaluationType != 'points'
                  ? Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorColor: ColorsManager.purble,
                              onTap: (value) => sortEvaluations(
                                  value == 0 ? 'first' : 'final'),
                              tabs: [
                                Tab(
                                  child: Text(
                                    S.of(context).currentEvalutionFirstTab,
                                    style: TextStyles.font16BoldWeight.copyWith(
                                      color: ColorsManager.purble,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    S.of(context).currentEvalutionFinalTab,
                                    style: TextStyles.font16BoldWeight.copyWith(
                                      color: ColorsManager.lightBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 60.h,
                              color: ColorsManager.periwinkle,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).currentEvalutinCriteria,
                                    style: const TextStyle(
                                      color: ColorsManager.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    S.of(context).currentEvalutionTitle,
                                    style: const TextStyle(
                                      color: ColorsManager.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: List.generate(
                                  2,
                                  (index) => CurrentEvalute(
                                    evalution: sortedEvaluationsFiltered,
                                    levelName: widget.member.level?.name ??
                                        'not set yet',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Column(
                              children: sortedEvaluations.studentEvaluation
                                      ?.map(
                                        (studentEval) => MotivationCircle(
                                          pointValue: studentEval,
                                          level:
                                              widget.member.level?.name ?? '',
                                        ),
                                      )
                                      .toList() ??
                                  [],
                            ),
                            evaluations.first.expectations != null &&
                                    evaluations.first.expectations!.isNotEmpty
                                ? AppTextButton(
                                    buttonText:
                                        S.of(context).finalEvaluationButton,
                                    backgroundColor: ColorsManager.primary,
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return DownSheet<LevelExpectaion>(
                                            items: evaluations
                                                    .first.expectations ??
                                                [],
                                            level: widget.member.level?.name,
                                          );
                                        },
                                      );
                                    },
                                    borderRadius: 4,
                                    buttonWidth:
                                        MediaQuery.of(context).size.width * 0.9,
                                    textStyle: const TextStyle(
                                        color: ColorsManager.white),
                                  )
                                : const SizedBox(),
                            verticalSpace(20),
                          ],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}

// class CurrentEvaluteRecordScreen extends StatefulWidget {
//   final Course currentCourse;
//   final Member member;

//   const CurrentEvaluteRecordScreen(
//       {super.key, required this.currentCourse, required this.member});

//   @override
//   State<CurrentEvaluteRecordScreen> createState() =>
//       _CurrentEvaluteRecordScreenState();
// }

// class _CurrentEvaluteRecordScreenState
//     extends State<CurrentEvaluteRecordScreen> {
//   List<Evalution> evalutions = [];
//   List<Evalution> sortedEvaluationsPoints = [];

//   Evalution sortedEvalutions = Evalution();
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchEvaluations();
//   }

//   Future<void> fetchEvaluations() async {
//     // Wait for the future to complete and then assign the result to evaluations
//     isLoading = true;
//     evalutions = await EvaluateController().fetchStudentCourse(
//       widget.member.id,
//       widget.currentCourse.id,
//     ); // Trigger a rebuild to reflect the changes
//     setState(() {
//       if (evalutions[0].evaluationType == "points") {
//         points();
//       } else {
//         sortStages('first');
//       }
//       isLoading = false;
//     });
//   }

//   void sortStages(String stage) {
//     setState(() {
//       if (evalutions.isEmpty) return;
//       sortedEvalutions.evaluationType = evalutions[0].evaluationType ?? '';
//       sortedEvalutions.expectations = evalutions[0].expectations;
//       sortedEvalutions.studentEvaluation = evalutions[0]
//           .studentEvaluation!
//           .where((element) => element.stage == stage)
//           .toList();

//       sortedEvalutions.studentEvaluation
//           ?.sort((a, b) => a.criteria.order!.compareTo(b.criteria.order!));
//     });
//   }

//   void points() {
//     setState(() {
//       sortedEvaluationsPoints = evalutions.map((evaluation) {
//         Evalution sortedEvaluation = Evalution();
//         sortedEvaluation.evaluationType = evaluation.evaluationType ?? '';
//         sortedEvaluation.expectations = evaluation.expectations;
//         sortedEvaluation.studentEvaluation = evaluation.studentEvaluation!
//             // .where((element) => element.stage != false && element.stage == 'final')
//             .toList();
//         sortedEvaluation.evaluationState = evaluation.evaluationState;

//         // sortedEvaluation.studentEvaluation
//         //     ?.sort((a, b) => a.criteria.order!.compareTo(b.criteria.order!));

//         return sortedEvaluation;
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Color> colors = [ColorsManager.purble, ColorsManager.lightBlue];

//     return Scaffold(
//       appBar: DashboardAppBar(
//         title: widget.member.name,
//         haveIcon: false,
//         haveLogo: false,
//         hideBackButton: false,
//       ),
//       body: Column(
//         children: [
//           verticalSpace(20),
//           Center(
//             child: Image.asset('assets/icons/circler-logo.png'),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0, bottom: 2),
//             child: Text(
//               S.of(context).currentEvaluationLabel,
//               style: TextStyles.font14BlackRegularWeight.copyWith(
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           sortedEvaluationsPoints.isEmpty
//               ? const SizedBox()
//               : Text(
//                   'Level ${widget.member.level?.name}',
//                   style: TextStyles.font14BlackRegularWeight.copyWith(
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//           verticalSpace(7),
//           isLoading
//               ? Lottie.asset(
//                   'assets/animated/loading.json',
//                   width: 100.w,
//                   height: 100.h,
//                 )
//               : Expanded(
//                   child: sortedEvaluationsPoints.isEmpty
//                       ? DefaultTabController(
//                           length: colors.length,
//                           child: Column(
//                             children: [
//                               TabBar(
//                                 indicatorSize: TabBarIndicatorSize.tab,
//                                 indicatorColor: ColorsManager.purble,
//                                 onTap: (value) {
//                                   if (value == 0) {
//                                     sortStages("first");
//                                   } else {
//                                     sortStages("final");
//                                   }
//                                 },
//                                 tabs: [
//                                   Tab(
//                                     child: Text(
//                                       S.of(context).currentEvalutionFirstTab,
//                                       style:
//                                           TextStyles.font16BoldWeight.copyWith(
//                                         color: colors[0],
//                                       ),
//                                     ),
//                                   ),
//                                   Tab(
//                                     child: Text(
//                                       S.of(context).currentEvalutionFinalTab,
//                                       style:
//                                           TextStyles.font16BoldWeight.copyWith(
//                                         color: colors[1],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Container(
//                                 height: 60.h,
//                                 color: ColorsManager.periwinkle,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 15.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       S.of(context).currentEvalutinCriteria,
//                                       style: const TextStyle(
//                                         color: ColorsManager.primary,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     Text(
//                                       S.of(context).currentEvalutionTitle,
//                                       style: const TextStyle(
//                                         color: ColorsManager.primary,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: isLoading
//                                     ? Lottie.asset(
//                                         'assets/animated/loading.json',
//                                         width: 100.w,
//                                         height: 100.h,
//                                       )
//                                     : TabBarView(
//                                         children: [
//                                           CurrentEvalute(
//                                             evalution: sortedEvalutions,
//                                             levelName:
//                                                 widget.member.level?.name ??
//                                                     'not set yet',
//                                           ),
//                                           CurrentEvalute(
//                                             evalution: sortedEvalutions,
//                                             levelName:
//                                                 widget.member.level?.name ??
//                                                     'not set yet',
//                                           ),
//                                         ],
//                                       ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : SingleChildScrollView(
//                           scrollDirection: Axis.vertical,
//                           child: Column(
//                             children:
//                                 sortedEvaluationsPoints.expand((evaluation) {
//                               return evaluation.studentEvaluation!
//                                   .map((studentEval) {
//                                 return MotivationCircle(
//                                   pointValue: studentEval,
//                                   level: widget.member.level?.name ?? '',
//                                 );
//                               });
//                             }).toList(),
//                           ),
//                         ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
