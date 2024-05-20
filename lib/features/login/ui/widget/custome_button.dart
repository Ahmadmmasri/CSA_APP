import 'package:csa_app/core/theming/styles.dart';
import 'package:flutter/material.dart';

class CustomeButton extends StatefulWidget {
  final String buttonTitle;
  final Color background;
  final Color borderColor;
  final Color fontColor;
  final VoidCallback onPress;
  const CustomeButton({
    super.key,
    required this.buttonTitle,
    required this.onPress,
    required this.background,
    required this.borderColor,
    required this.fontColor,
  });

  @override
  State<CustomeButton> createState() => _CustomeButtonState();
}

class _CustomeButtonState extends State<CustomeButton> {
  @override
  Widget build(BuildContext context) {
    // get screen width
    final double screenHeight = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: () {
        widget.onPress();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(widget.background),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: MaterialStateProperty.all(
          // (button width 90% of screen, button height)
          Size(screenHeight * 0.90, 45),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: widget.borderColor.withOpacity(0.2)),
          ),
        ),
      ),
      child: Text(
        widget.buttonTitle,
        style: TextStyles.font14WhiteBoldWeight.copyWith(
          color: widget.fontColor,
        ),
      ),
    );
  }
}
