import 'package:carousel_slider/carousel_slider.dart';
import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/shared-widgets/app-text-button.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/controller/evaluate_controller.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/course.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/evalution.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/previous-evalute/inner-pages/motovation-circle.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/previous-evalute/inner-pages/prev-evalute-record.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/widget/no-result.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/memeber.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreviousEvaluteRecordScreen extends StatelessWidget {
  final List<Course> course;
  final Member member;

  const PreviousEvaluteRecordScreen(
      {super.key, required this.course, required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        title: member.name,
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
              S.of(context).prevEvaluationButton,
              style: TextStyles.font14BlackRegularWeight.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          verticalSpace(7),
          DateSlider(course: course, member: member),
        ],
      ),
    );
  }
}

class DateSlider extends StatefulWidget {
  final List<Course> course;
  final Member member;
  const DateSlider({super.key, required this.course, required this.member});

  @override
  State<DateSlider> createState() => _DateSliderState();
}

class _DateSliderState extends State<DateSlider> {
  late List prevDates;
  List<Evalution> evalutions = [];
  List<Evalution> sortedEvaluations = [];

  @override
  void initState() {
    prevDates = widget.course
        .map((e) => {'level': 'B1', 'date': e.date, 'id': e.id, 'name': e.name})
        .toList();
    prevDates.sort((a, b) => a['date'].compareTo(b['date']));
    setState(() {
      //selectedLevel = prevDates.isNotEmpty ? prevDates[0]['level'] : '';
      selectedLevel = '';
    });
    fetch();
    super.initState();
  }

  Future fetch() async {
    if (prevDates.isNotEmpty) {
      evalutions = await EvaluateController()
          .fetchStudentCourse(widget.member.id, prevDates[selectedIndex]['id']);
      setState(() {
        if (evalutions.isEmpty) return;
        sortedEvaluations = evalutions.map((evaluation) {
          String currentStage = evaluation.studentEvaluation!.first.stage;
          Evalution sortedEvaluation = Evalution();
          sortedEvaluation.evaluationType = evaluation.evaluationType ?? '';
          sortedEvaluation.expectations = evaluation.expectations;
          sortedEvaluation.studentEvaluation = evaluation.studentEvaluation!
              .where((element) => element.stage == currentStage)
              .toList();
          sortedEvaluation.evaluationState = evaluation.evaluationState;

          sortedEvaluation.studentEvaluation
              ?.sort((a, b) => a.criteria.order!.compareTo(b.criteria.order!));

          return sortedEvaluation;
        }).toList();
      });
    }
  }

  int selectedIndex = 0;
  String selectedLevel = '';

  @override
  Widget build(BuildContext context) {
    // final List prevDates = [
    //   {'level': 'B2', 'Date': '02-01-2024', 'id': '1'},
    //   {'level': 'B1', 'Date': '02-02-2024', 'id': '2'},
    //   {'level': 'A2', 'Date': '02-03-2024', 'id': '3'},
    //   {'level': 'A1', 'Date': '02-04-2024', 'id': '4'},
    //   {'level': 'C1', 'Date': '02-05-2024', 'id': '5'},
    //   {'level': 'C2', 'Date': '02-06-2024', 'id': '6'},
    //   {'level': 'B2', 'Date': '02-07-2024', 'id': '7'},
    // ];
    return Expanded(
      child: DefaultTabController(
        length: 1,
        child: Column(
          children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                initialPage: 1,
                viewportFraction: 0.45,
                enableInfiniteScroll: false,
                autoPlay: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                padEnds: false,
                height: 50.h,
                onPageChanged: (index, reason) {
                  // debugPrint(index);
                },
              ),
              itemCount: prevDates.length,
              itemBuilder: (context, index, realIndex) {
                final date = prevDates[index];
                return AppTextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = index;
                      selectedLevel = date['level'];
                      fetch();
                    });
                  },
                  buttonText: date['name'],
                  textStyle: TextStyles.font14RegularWeight.copyWith(
                    color: selectedIndex == index
                        ? ColorsManager.white
                        : ColorsManager.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor: selectedIndex == index
                      ? ColorsManager.primary
                      : ColorsManager.white,
                  borderColor: ColorsManager.primary,
                  borderRadius: 25.0,
                  buttonWidth: 170.w,
                  // buttonHeight: 44,
                );
              },
            ),
            verticalSpace(7),
            const Divider(),
            evalutions.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: NoResult(),
                  )
                : sortedEvaluations[0].evaluationType == 'points'
                    ? Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: sortedEvaluations.expand((evaluation) {
                              return evaluation.studentEvaluation!
                                  .map((studentEval) {
                                return MotivationCircle(
                                  pointValue: studentEval,
                                  level: widget.member.level?.name ?? '',
                                );
                              });
                            }).toList(),
                          ),
                        ),
                      )
                    : Expanded(
                        child: DefaultTabController(
                          length: 1,
                          child: sortedEvaluations[0].studentEvaluation == null
                              ? const Center(child: CircularProgressIndicator())
                              : PrevEvalute(evalution: sortedEvaluations[0]),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
