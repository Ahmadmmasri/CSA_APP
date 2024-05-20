import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:flutter/material.dart';

class StudentState extends StatefulWidget {
  final String title;

  const StudentState({super.key, required this.title});

  @override
  State<StudentState> createState() => _StudentStateState();
}

class _StudentStateState extends State<StudentState> {
  @override
  Widget build(BuildContext context) {
    late String title;
    late List<Color> colors;
    String chosenState = widget.title.toLowerCase();
    switch (chosenState) {
      case 'new':
        title = chosenState;
        colors = [
          const Color(0xFFF1318B),
          const Color(0xFFCE1E70),
        ];
        break;
      case 'absent':
        title = chosenState;
        colors = [
          const Color(0xFFB8BCE9),
          const Color(0xFF9498C5),
        ];
        break;
      case 'pending':
        title = chosenState;
        colors = [
          const Color(0xFFF88B31),
          const Color(0xffF57F20),
        ];
        break;
      case 'skip':
        title = chosenState;
        colors = [
          const Color(0xFFE61646),
          const Color(0xffC10230),
        ];
        break;
      case 'attend':
        title = chosenState;
        colors = [
          const Color(0xFF00A3BF),
          const Color(0xFF028096),
        ];
        break;
      case 'pass':
        title = chosenState;
        colors = [
          const Color(0xFF11FF74),
          const Color(0xFF09DD61),
        ];
        break;
      default:
        break;
    }

    return Container(
      height: 32,
      width: 58,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [...colors],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Text(
        title,
        style: TextStyles.font12MediumWeight.copyWith(
          color: ColorsManager.bluishWhite,
        ),
      ),
    );
  }
}
