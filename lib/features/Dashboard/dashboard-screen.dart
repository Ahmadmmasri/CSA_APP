import 'package:csa_app/core/networking/firebaase-api.dart';
import 'package:csa_app/features/Dashboard/internal-pages/account/account-screen.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/course.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/controller/home_controller.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/controller/memeber_controller.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/home-screen.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/more-screen.dart';
import 'package:csa_app/features/Dashboard/internal-pages/program/program-screen.dart';
import 'package:csa_app/features/Dashboard/internal-pages/shop/shop-screen.dart';
import 'package:csa_app/features/Dashboard/widgets/bottom-navbar.dart';
import 'package:csa_app/features/login/data/user-profile.dart';
import 'package:csa_app/features/login/logic/cubit/csa_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class DahsboardScreen extends StatefulWidget {
  const DahsboardScreen({Key? key}) : super(key: key);

  @override
  State<DahsboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DahsboardScreen>
    with SingleTickerProviderStateMixin {
  UserProfile? userInfo;
  bool isLoading = true;
  late final TabController _tabController;
  int pageIndex = 0;
  List<Widget> pages = [];
  final HomeController _homeController = HomeController();
  final MemberController _memberController = MemberController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // var s = await UserSharedPrefrences().getFcmToken();
      final userProfile =
          await BlocProvider.of<CsaAuthCubit>(context).getUserDetails();
      final fetchedPrograms = await _homeController.fetchAllPrograms();
      final fetchedProducts = await _homeController.fetchProducts();
      final fetchedMembers = await _memberController.initializeMemeber();
      final fetchedBranch = await _homeController.fetchAllBranch();
      final fetchedNews = await _homeController.fetchAllNews();
      List<Course>? fetchCourse =
          userProfile.id != null ? await _homeController.fetchAllCourses() : [];
      if (userProfile.id != null) {
        await FirebaseApi().initNotification();
      }
      if (mounted) {
        setState(() {
          userInfo = userProfile;
          pages = [
            HomeScreen(
              user: userInfo!,
              allBranch: fetchedBranch,
              news: fetchedNews,
              allProduct: fetchedProducts,
              allProgram: fetchedPrograms,
              memberFuture: fetchedMembers.isEmpty ? [] : fetchedMembers,
              fetchCourses: fetchCourse,
            ),
            ProgramScreen(programs: fetchedPrograms),
            ShopScreen(products: fetchedProducts),
            AccountScreen(userinfo: userInfo!, members: fetchedMembers),
            const MoreScreen(),
          ];
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle error
      debugPrint('Error loading data: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _refresh() async {
    setState(() {
      isLoading = true;
    });
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: isLoading
            ? Center(
                child: Lottie.asset(
                  'assets/animated/loading.json',
                  width: 100.w,
                  height: 100.h,
                ), // Show loading indicator
              )
            : BlocListener<CsaAuthCubit, CsaAuthState>(
                listener: (context, state) {
                  if (state is CurrentTabProgram && pageIndex != 1) {
                    setState(() {
                      pageIndex = 1;
                      _tabController.index = 1;
                    });
                  } else if (state is CurrentTabShop && pageIndex != 2) {
                    setState(() {
                      pageIndex = 2;
                      _tabController.index = 2;
                    });
                  }
                },
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: IndexedStack(index: pageIndex, children: pages),
                ),
              ),
        bottomNavigationBar: isLoading
            ? const SizedBox()
            : BottomNavBar(
                tabController: _tabController,
                onTap: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
              ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}


//prev code


// class DahsboardScreen extends StatefulWidget {
//   // final UserProfile? userProfile;

//   const DahsboardScreen({Key? key}) : super(key: key);

//   @override
//   State<DahsboardScreen> createState() => _DahsboardScreenState();
// }

// class _DahsboardScreenState extends State<DahsboardScreen>
//     with SingleTickerProviderStateMixin {
//   UserProfile? userInfo;
//   List<Widget> pages = [];
//   late final _tabController = TabController(length: 5, vsync: this);
//   bool isLoading = true;
//   List<Program> allPrograms = [];
//   List<Product> allProduct = [];
//   List<Member> membersList = [];
//   List<MainBranch> allBranch = [];
//   List<Course> allCourses = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     // Retrieve user details asynchronously
//     UserProfile userProfile =
//         await BlocProvider.of<CsaAuthCubit>(context).getUserDetails();
//     List<Program> fetchedPrograms = await HomeController().fetchAllPrograms();
//     List<Product> fetchedProducts = await HomeController().fetchProducts();
//     List<Member> fetchMembers = await MemberController().initializeMemeber();
//     List<MainBranch> fetchedBranch = await HomeController().fetchAllBranch();
//     List<New> fetchedNews = await HomeController().fetchAllNews();
//     List<Course> fetchCourses =
//         userProfile.id != null ? await HomeController().fetchAllCourses() : [];
//     List<New> news = [];

//     setState(() {
//       userInfo = userProfile;
//       allPrograms = fetchedPrograms;
//       allProduct = fetchedProducts;
//       membersList = fetchMembers;
//       allBranch = fetchedBranch;
//       news = fetchedNews;
//       allCourses = fetchCourses;
//       isLoading = false;
//     });

//     pages = [
//       HomeScreen(
//         user: userInfo!,
//         allBranch: allBranch,
//         news: news,
//         allProduct: allProduct,
//         allProgram: allPrograms,
//         memberFuture: membersList.isEmpty ? [] : membersList,
//         fetchCourses: allCourses,
//       ),
//       ProgramScreen(programs: allPrograms),
//       ShopScreen(products: allProduct),
//       AccountScreen(userinfo: userInfo!, members: membersList),
//       const MoreScreen()
//     ];
//   }

//   int pageIndex = 0;

//   Future refresh() async {
//     context.pushReplacementNamed(Routes.dashboardScreen);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: NavigationItem.values.length,
//       child: Scaffold(
//         body: isLoading
//             ? Center(
//                 child: Lottie.asset(
//                   'assets/animated/loading.json',
//                   width: 100.w,
//                   height: 100.h,
//                 ), // Show loading indicator
//               )
//             : BlocBuilder<CsaAuthCubit, CsaAuthState>(
//                 builder: (context, state) {
//                   if (state is CurrentTabProgram && pageIndex != 1) {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       BlocProvider.of<CsaAuthCubit>(context).otherCurrentTab();
//                       setState(() {
//                         pageIndex = 1;
//                         _tabController.index = 1;
//                       });
//                     });
//                   } else if (state is CurrentTabShop && pageIndex != 2) {
//                     BlocProvider.of<CsaAuthCubit>(context).otherCurrentTab();
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       setState(() {
//                         pageIndex = 2;
//                         _tabController.index = 2;
//                       });
//                     });
//                   }
//                   return RefreshIndicator(
//                     onRefresh: refresh,
//                     child: IndexedStack(index: pageIndex, children: pages),
//                   );
//                 },
//               ),
//         bottomNavigationBar: isLoading
//             ? const SizedBox()
//             : BottomNavBar(
//                 tabController: _tabController,
//                 onTap: (index) {
//                   setState(() {
//                     pageIndex = index;
//                   });
//                 },
//               ),
//       ),
//     );
//   }
// }
