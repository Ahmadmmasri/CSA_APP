import 'package:csa_app/features/Dashboard/internal-pages/home/data/product.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/header-section.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/shop-slider.dart';
import 'package:csa_app/features/login/logic/cubit/csa_auth_cubit.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcademyShop extends StatelessWidget {
  final List<Product> products;
  const AcademyShop({super.key, required this.products});

  // void loadProducts() async {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          HeaderSection(
            title: S.of(context).shop,
            note: S.of(context).shopNote,
            onTapViewAllButton: () {
              BlocProvider.of<CsaAuthCubit>(context).navigateShop();
            },
          ),
          ShopSlider(products: products),
        ],
      ),
    );
  }
}
