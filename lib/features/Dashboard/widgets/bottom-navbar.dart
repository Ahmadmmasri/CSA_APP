import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/features/Dashboard/data/nav_name_enum.dart';
import 'package:csa_app/features/login/logic/cubit/csa_auth_cubit.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) onTap;
  final TabController tabController;
  const BottomNavBar(
      {super.key, required this.onTap, required this.tabController});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.tabController,
      indicatorPadding: EdgeInsets.zero,
      indicator: const BoxDecoration(
          border: Border(
              top: BorderSide(
        color: ColorsManager.primary,
        width: 3.0,
      ))),
      dividerColor: ColorsManager.primary,
      indicatorColor: ColorsManager.primary,
      labelColor: ColorsManager.primary,
      labelPadding: const EdgeInsets.symmetric(horizontal: 0),
      unselectedLabelColor: Colors.blueGrey,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 3.0,
      labelStyle: TextStyle(
        fontSize: 11.sp, // Set the font size for the selected item
        fontWeight:
            FontWeight.bold, // Set the font weight for the selected item
      ),
      onTap: (index) {
        if (index == 3) {
          BlocProvider.of<CsaAuthCubit>(context).getSavedLang();
        }
        setState(() {
          _selectedIndex = index;
        });
        widget.onTap(index);
      },
      tabs: [
        Tab(
          icon: Opacity(
            opacity: _selectedIndex == NavigationItem.Home.index ? 1.0 : 0.8,
            child: SvgPicture.asset(
              'assets/icons/nav-home.svg',
            ),
          ),
          text: S.of(context).home,
        ),
        Tab(
          icon: Opacity(
            opacity:
                _selectedIndex == NavigationItem.Programs.index ? 1.0 : 0.8,
            child: SvgPicture.asset(
              'assets/icons/nav-program.svg',
            ),
          ),
          text: S.of(context).programs,
        ),
        Tab(
          icon: Opacity(
            opacity: _selectedIndex == NavigationItem.Shop.index ? 1.0 : 0.8,
            child: SvgPicture.asset(
              'assets/icons/nav-shop.svg',
            ),
          ),
          text: S.of(context).shop,
        ),
        Tab(
          icon: Opacity(
            opacity: _selectedIndex == NavigationItem.Account.index ? 1.0 : 0.8,
            child: SvgPicture.asset(
              'assets/icons/nav-account.svg',
            ),
          ),
          text: S.of(context).account,
        ),
        Tab(
          icon: Opacity(
            opacity: _selectedIndex == NavigationItem.More.index ? 1.0 : 0.8,
            child: SvgPicture.asset(
              'assets/icons/nav-more.svg',
            ),
          ),
          text: S.of(context).more,
        ),
      ],
    );
  }
}
