import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key, required this.item});
  final New item;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        haveIcon: false,
        haveLogo: false,
        title: widget.item.title,
        hideBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              transitionOnUserGestures: true,
              tag: "${widget.item.image.toString()}${widget.item.id}",
              child: widget.item.image!.isNotEmpty
                  ? Image.memory(
                      widget.item.image!,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 210.h,
                    )
                  : Image.asset(
                      'assets/icons/events-default.png',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 210.h,
                    ),
            ),
            verticalSpace(5),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: widget.item.desscription != null
                    ? Text(widget.item.desscription.toString(),
                        style: TextStyles.font12MediumWeight.copyWith(
                          color: ColorsManager.black,
                          letterSpacing: 1.1,
                          height: 2,
                        ))
                    : const Text(""))
          ],
        ),
      ),
    );
  }
}
