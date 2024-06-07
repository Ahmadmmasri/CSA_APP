import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class DownSheet<T> extends StatefulWidget {
  final List<T> items;
  final String? level;
  const DownSheet({super.key, required this.items, this.level});

  @override
  State<DownSheet> createState() => _DownSheetState();
}

class _DownSheetState extends State<DownSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _bottomSheetController;

  @override
  void initState() {
    super.initState();
    _bottomSheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Adjust duration as needed
    );
  }

  @override
  void dispose() {
    _bottomSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      animationController: _bottomSheetController,
      onClosing: () => context.pop(),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      builder: (builder) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).evaluationSystemHeader + widget.level!,
                        style: TextStyles.font16BoldWeight.copyWith(
                          color: ColorsManager.primary,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close_sharp,
                          color: ColorsManager.primary,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
              // Container(
              //   alignment: Alignment.topCenter,
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: const Text(
              //     ' 1.Walking in the water in all directions \n 2.Wash the face and head \n 3.Submerging the head under water surface \n 4.Floating with the help of the pool side/coach \n 5.Jump in from poolside safely to a minimum \n 6.Use buoyancy aids (Optional) \n 1.Walking in the water in all directions \n 2.Wash the face and head \n 3.Submerging the head under water surface \n 4.Floating with the help of the pool side/coach \n 5.Jump in from poolside safely to a minimum \n 6.Use buoyancy aids (Optional) \n ',
              // style: TextStyle(
              //   fontSize: 16,
              // ),
              //   ),
              // ),
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: widget.items.map((item) {
                    final index = widget.items.indexOf(item);
                    return Container(
                      width: double.infinity,
                      alignment: context.isArabic
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 5.0,
                      ),
                      child: Text(
                        '${index + 1}-${item.name}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
