import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/product.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/shop-slider.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopScreen extends StatelessWidget {
  final List<Product> products;
  const ShopScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        title: S.of(context).shop,
        haveIcon: false,
        haveLogo: false,
        hideBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 55.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorsManager.primary,
              ),
              child: Center(
                child: Text(
                  S.of(context).shopNote,
                  style: TextStyles.font16RegularWeight.copyWith(
                    color: ColorsManager.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Wrap(
                spacing: 0,
                runSpacing: 10.w,
                children: products.map((product) {
                  return ShopCard(
                    productItem: product,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
