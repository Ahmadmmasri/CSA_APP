import 'package:carousel_slider/carousel_slider.dart';
import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/font-weight-helper.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/product.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopSlider extends StatelessWidget {
  final List<Product> products;
  const ShopSlider({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        initialPage: 1,
        viewportFraction: 0.52,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: false,
        autoPlay: false,
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        padEnds: false,
        onPageChanged: (index, reason) {
          // debugPrint(index);
        },
      ),
      itemCount: products.length,
      itemBuilder: (context, index, realIndex) {
        final product = products[index];
        return ShopCard(
          productItem: product,
        );
      },
    );
  }
}

class ShopCard extends StatelessWidget {
  final Product productItem;
  const ShopCard({
    super.key,
    required this.productItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: productItem.img.isNotEmpty
                  ? Image.memory(
                      productItem.img,
                      width: 168.w,
                      height: 200.h,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/logo.png',
                      width: 168.w,
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
            ),
            Positioned(
              top: 0,
              right: context.isArabic ? 0 : null,
              left: context.isArabic ? null : 0,
              child: Container(
                width: 80.w,
                height: 28.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomRight: context.isArabic
                        ? const Radius.circular(0)
                        : const Radius.circular(10),
                    topLeft: context.isArabic
                        ? const Radius.circular(0)
                        : const Radius.circular(10),
                    bottomLeft: context.isArabic
                        ? const Radius.circular(10)
                        : const Radius.circular(0),
                    topRight: context.isArabic
                        ? const Radius.circular(10)
                        : const Radius.circular(0),
                  ),
                ),
                padding: const EdgeInsets.all(0),
                child: Text(
                  '${productItem.price} ${S.of(context).jd}',
                  style: TextStyles.font14WhiteBoldWeight,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width / 2.2,
                // height: 65.h,
                color: ColorsManager.white,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0),
                child: Center(
                  child: Column(
                    children: [
                      verticalSpace(5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          productItem.name,
                          style: TextStyles.font12BoldWeight.copyWith(
                            color: ColorsManager.black,
                          ),
                        ),
                      ),
                      verticalSpace(5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: productItem.availableBranchs!
                            .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    alignment: WrapAlignment.center,
                                    spacing: 5.0,
                                    runSpacing: 5.0,
                                    children: [
                                      Text(
                                        e.name,
                                        style: TextStyles.font12MediumWeight
                                            .copyWith(
                                          color: ColorsManager.primarytinyLight,
                                          fontWeight: FontWeightHelper.medium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                      // Text(
                      //   productItem.availableBranchs![0].name,
                      //   style: TextStyles.font14RegularWeight.copyWith(
                      //     color: ColorsManager.primarytinyLight,
                      //     fontWeight: FontWeightHelper.medium,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
