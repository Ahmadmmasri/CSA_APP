import 'package:carousel_slider/carousel_slider.dart';
import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/new.dart';
import 'package:flutter/material.dart';

class EventSlider extends StatelessWidget {
  final List<New> news;
  const EventSlider({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        initialPage: 1,
        viewportFraction: .92,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: false,
        autoPlay: false,
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        padEnds: true,
        onPageChanged: (index, reason) {
          // debugPrint(index);
        },
      ),
      itemCount: news.length,
      itemBuilder: (context, index, realIndex) {
        final eventNew = news[index];
        return InkWell(
          onTap: () =>
              context.pushNamed(Routes.eventDetailsScreen, arguments: eventNew),
          child: ImageSlider(
            image: eventNew.image!.isNotEmpty
                ? Image.memory(
                    eventNew.image!,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/icons/events-default.png',
                    fit: BoxFit.cover,
                  ),
          ),
        );
      },
    );
  }
}

class ImageSlider extends StatelessWidget {
  final Widget image;
  const ImageSlider({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2, //310.w
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: image,
      ),
    );
  }
}
