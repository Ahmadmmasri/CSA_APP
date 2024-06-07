import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/shared-widgets/app-text-button.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/current-evalute/widgets/down-sheet.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/evalution.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/evalutionPoint.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/level-expecation.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrentEvalute extends StatelessWidget {
  final Evalution evalution;
  final String levelName;

  const CurrentEvalute(
      {Key? key, required this.evalution, required this.levelName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showBottomSheet(BuildContext ctx) {
      List<EvalutionPoint> evalutionPoints = [
        EvalutionPoint(
          title: S.of(context).pointEvalutionOneTitle,
          description: S.of(context).pointEvalutionOneDesc,
        ),
        EvalutionPoint(
          title: S.of(context).pointEvalutionTwoTitle,
          description: S.of(context).pointEvalutionTwoDesc,
        ),
        EvalutionPoint(
          title: S.of(context).pointEvalutionThreeTitle,
          description: S.of(context).pointEvalutionThreeDesc,
        ),
        EvalutionPoint(
          title: S.of(context).pointEvalutionFourTitle,
          description: S.of(context).pointEvalutionFourDesc,
        ),
      ];
      //original
      showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: ctx,
        builder: (ctx) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(ctx).size.width,
                height: MediaQuery.of(ctx).size.height * 0.6,
                margin: EdgeInsets.symmetric(vertical: 20.w),
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).pointSystemHeader,
                            style: TextStyles.font16BoldWeight.copyWith(
                              color: ColorsManager.primary,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: IconButton(
                            icon: const Icon(
                              Icons.close_sharp,
                              color: ColorsManager.primary,
                            ),
                            onPressed: () {
                              context.pop();
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: evalutionPoints.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      evalutionPoints[index].title,
                                      style: TextStyles.font16BoldWeight
                                          .copyWith(
                                              color: ColorsManager.primary),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        evalutionPoints[index].description,
                                        textAlign: TextAlign.start,
                                        style: TextStyles.font14WhiteBoldWeight
                                            .copyWith(
                                                color: ColorsManager
                                                    .primarytinyMeduim),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: evalution.studentEvaluation != null
                ? ListView.builder(
                    shrinkWrap: false,
                    itemCount: evalution.studentEvaluation!.length,
                    itemBuilder: (context, index) {
                      var currentEvalution =
                          evalution.studentEvaluation![index];
                      return ListTile(
                        title: Text(
                          currentEvalution.criteria.name ?? '',
                          style: TextStyles.font14BlackRegularWeight,
                        ),
                        trailing: InkWell(
                          onTap: () {
                            showBottomSheet(context);
                          },
                          child: Container(
                            height: 22,
                            width: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorsManager.bluishWhite,
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Add border radius here
                            ),
                            child: Text(
                              currentEvalution.value,
                              textAlign: TextAlign.center,
                              style: TextStyles.font14WhiteBoldWeight.copyWith(
                                color: ColorsManager.primary,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    // child: NoResult(),
                    child: Text(
                      S.of(context).currentEvalutionNoData,
                      style: TextStyles.font14BlackRegularWeight,
                    ),
                  ),
          ),
          evalution.expectations != null && evalution.expectations!.isNotEmpty
              ? AppTextButton(
                  buttonText: S.of(context).finalEvaluationButton,
                  backgroundColor: ColorsManager.primary,
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return DownSheet<LevelExpectaion>(
                          items: evalution.expectations ?? [],
                          level: levelName,
                        );
                      },
                    );
                  },
                  borderRadius: 4,
                  buttonWidth: MediaQuery.of(context).size.width * 0.9,
                  textStyle: const TextStyle(color: ColorsManager.white),
                )
              : const SizedBox(),
          verticalSpace(20),
        ],
      ),
    );
  }
}
