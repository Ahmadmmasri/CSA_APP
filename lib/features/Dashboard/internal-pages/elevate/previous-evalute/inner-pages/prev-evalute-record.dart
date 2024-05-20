import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/evalution.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/previous-evalute/inner-pages/widget/student-state.dart';
import 'package:flutter/material.dart';

class PrevEvalute extends StatelessWidget {
  final Evalution evalution;

  const PrevEvalute({super.key, required this.evalution});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //NoResult() //when empty
          Expanded(
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: evalution.studentEvaluation!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    evalution.studentEvaluation![index].criteria.name ?? '-',
                    style: TextStyles.font14BlackRegularWeight,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      index == 0
                          ? StudentState(title: evalution.evaluationState!)
                          : Container(
                              height: 22,
                              width: 22,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorsManager.bluishWhite,
                                borderRadius: BorderRadius.circular(
                                    10), // Add border radius here
                              ),
                              child: Text(
                                evalution.studentEvaluation![index].value,
                                textAlign: TextAlign.center,
                                style:
                                    TextStyles.font14WhiteBoldWeight.copyWith(
                                  color: ColorsManager.primary,
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
