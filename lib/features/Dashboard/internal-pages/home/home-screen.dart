import 'package:csa_app/core/helpers/divider-line.dart';
import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/shared-widgets/app-text-button.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/course.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/controller/home_controller.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/main-branch.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/memeber.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/new.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/product.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/program.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/academy-branch.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/academy-program.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/academy-shop.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/club-membes.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/news-events.dart';
import 'package:csa_app/features/login/data/user-profile.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  final UserProfile? user;
  final List<Member>? memberFuture;
  final List<New> news;
  final List<Program> allProgram;
  final List<MainBranch> allBranch;
  final List<Product> allProduct;
  final List<Course>? fetchCourses;

  const HomeScreen({
    super.key,
    this.user,
    this.memberFuture,
    this.fetchCourses,
    required this.news,
    required this.allProgram,
    required this.allBranch,
    required this.allProduct,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Course? selectedCourse;
    void showSnackBar(BuildContext ctx, String title, Color color) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 4500),
          showCloseIcon: true,
          content: SizedBox(
            height: 30.h,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          backgroundColor: color,
        ),
      );
    }

    void showBottomSheet(BuildContext ctx) {
      List<bool> isCheckedList =
          List.filled(widget.user!.childrenIds!.length, false);
      List<int> childIds = [];
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
                height: MediaQuery.of(ctx).size.height * 0.8,
                margin: EdgeInsets.symmetric(vertical: 20.w),
                color: Colors.transparent,
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: widget.user!.childrenIds!.length + 1,
                  itemBuilder: (context, index) {
                    return index != widget.user!.childrenIds!.length
                        ? CheckboxListTile(
                            title: Text(widget.user!.childrenIds![index].name!),
                            value: isCheckedList[index],
                            activeColor: ColorsManager.blue,
                            onChanged: (value) async {
                              setState(() {
                                isCheckedList[index] = value!;
                                childIds
                                    .add(widget.user!.childrenIds![index].id!);
                              });
                            },
                          )
                        : widget.user!.childrenIds == null
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  children: [
                                    DropdownButton<Course>(
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(10),
                                      hint: widget.fetchCourses!.isEmpty
                                          ? Text(
                                              S
                                                  .of(context)
                                                  .noCoursesBookMessage,
                                              style: TextStyles.font12BoldWeight
                                                  .copyWith(
                                                color: ColorsManager.orange,
                                              ))
                                          : Text(
                                              S.of(context).selectCourseMessage,
                                              style: TextStyles.font12BoldWeight
                                                  .copyWith(
                                                color: ColorsManager.primary,
                                              ),
                                            ),
                                      value: selectedCourse,
                                      items: widget.fetchCourses!
                                          .where((element) =>
                                              element.state == "open")
                                          .map((Course course) {
                                        return DropdownMenuItem<Course>(
                                          value: course,
                                          child: Text(course.name),
                                        );
                                      }).toList(),
                                      onChanged: (Course? newValue) {
                                        setState(() {
                                          selectedCourse = newValue!;
                                        });
                                      },
                                    ),
                                    verticalSpace(30),
                                    AppTextButton(
                                      buttonText: S.of(context).Confirmbook,
                                      disabled: selectedCourse == null ||
                                              childIds.isEmpty
                                          ? true
                                          : false,
                                      textStyle:
                                          TextStyles.font14WhiteBoldWeight,
                                      onPressed: () async {
                                        bool success = await HomeController()
                                            .joinCourseRequest(
                                                childIds, selectedCourse!.id);

                                        if (success) {
                                          setState(() {
                                            showSnackBar(
                                                context,
                                                S
                                                    .of(context)
                                                    .successBookMessage,
                                                Colors.green);
                                            Navigator.pop(context);
                                          });
                                        } else {
                                          setState(() {
                                            showSnackBar(
                                                context,
                                                S.of(context).failBookMessage,
                                                Colors.red);
                                            Navigator.pop(context);
                                          });
                                        }
                                      },
                                      backgroundColor: childIds.isEmpty ||
                                              selectedCourse == null
                                          ? Colors.grey
                                          : ColorsManager.blue,
                                      borderRadius: 8,
                                      buttonHeight: 50.h,
                                    ),
                                  ],
                                ),
                              );
                  },
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: DashboardAppBar(
        haveIcon: true,
        haveLogo: true,
        title: S.of(context).home,
        hideBackButton: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // widget.memberFuture!.isNotEmpty
                  widget.user?.childrenIds != null &&
                          widget.user!.childrenIds!.isNotEmpty
                      ? ClubMemebrs(
                          memberFuture: widget.memberFuture!,
                        )
                      : Container(),
                  // const ClubMemebrs(),
                  verticalSpace(5),
                  NewsEvents(news: widget.news),
                  verticalSpace(20),
                  dividerLine(4),
                  verticalSpace(5),
                  AcademyProgram(allPrograms: widget.allProgram),
                  verticalSpace(20),
                  dividerLine(4),
                  verticalSpace(5),
                  AcademyBranch(branchs: widget.allBranch),
                  dividerLine(4),
                  verticalSpace(5),
                  AcademyShop(products: widget.allProduct),
                  verticalSpace(50),
                ],
              ),
            ),
          ),
          // const Loading(),
          widget.memberFuture!.isEmpty
              ? const SizedBox()
              : Positioned(
                  bottom: 20,
                  width: MediaQuery.of(context).size.width * 0.92,
                  child: AppTextButton(
                    buttonText: S.of(context).bookCourse,
                    backgroundColor: const Color(0xff0084FF),
                    borderRadius: 8,
                    onPressed: () async {
                      showBottomSheet(context);
                    },
                    textStyle: TextStyles.font14WhiteBoldWeight,
                  ),
                )
        ],
      ),
    );
  }
}
