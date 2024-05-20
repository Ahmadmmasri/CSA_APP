import 'package:csa_app/core/helpers/color-converter.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/program.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgramCard extends StatelessWidget {
  final Program program;
  const ProgramCard({Key? key, required this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String wordsDesc = '';
    if (program.description != null) {
      List<String> words = program.description!.split(' ');
      if (words.length > 10) {
        wordsDesc =
            "${program.description!.split(' ').sublist(0, 10).join(' ')} ...";
      } else {
        wordsDesc = program.description!;
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.programDetailsScreen,
            arguments: program,
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side:
                const BorderSide(color: ColorsManager.bluishWhite, width: 1.5),
          ),
          elevation: 0,
          color: ColorsManager.white,
          shadowColor: Colors.black12.withOpacity(0.6),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 130.w,
                  height: 150.h,
                  decoration: const BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                    ),
                  ),
                  child: program.img != null && program.img!.isNotEmpty
                      ? Image.memory(
                          program.img!,
                          width: 120.w,
                          height: 70.h,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/icons/logo.png',
                          width: 120.w,
                          height: 70.h,
                          fit: BoxFit.contain,
                        ),
                ),
                const SizedBox(
                    width: 10), // Adjust spacing between image and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: program.bannerColor != null &&
                                  program.bannerColor!.isNotEmpty
                              ? ColorConverter.hexToColor(program.bannerColor!)
                              : ColorsManager.primary,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          program.bannerName != null &&
                                  program.bannerName!.isNotEmpty
                              ? program.bannerName!
                              : S.of(context).noLevelDetails,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                          height:
                              3), // Adjust spacing between title and description
                      Text(
                        program.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.primary,
                        ),
                      ),
                      const SizedBox(
                          height:
                              8), // Adjust spacing between description and other text
                      Container(
                        constraints: BoxConstraints(maxWidth: 190.w),
                        child: wordsDesc.isNotEmpty
                            ? Text(
                                wordsDesc,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// class ProgramCard extends StatelessWidget {
//   final Program program;
//   const ProgramCard({super.key, required this.program});

//   @override
//   Widget build(BuildContext context) {
//     String wordsDesc = '';
//     if (program.description != null) {
//       List words = program.description!.split(' ');
//       if (words.length > 10) {
//         wordsDesc =
//             "${program.description!.split(' ').sublist(0, 10).join(' ')} ...";
//       } else {
//         wordsDesc = program.description!;
//       }
//     }
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
//       child: InkWell(
//         onTap: () {
//           Navigator.pushNamed(
//             context,
//             Routes.programDetailsScreen,
//             arguments: program,
//           );
//         },
//         child: Container(
//           height: 185.h,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(
//               color: ColorsManager.lightGrey,
//               width: 1.2,
//             ),
//           ),
//           child: Row(
//             children: [
//               Flexible(
//                 child: Container(
//                   width: 130.w,
//                   height: 150.h,
//                   decoration: const BoxDecoration(
//                     color: ColorsManager.purble,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(7),
//                       bottomLeft: Radius.circular(7),
//                     ),
//                   ),
//                   child: program.img!.isNotEmpty
//                       ? Image.memory(
//                           program.img!,
//                           width: 120.w,
//                           height: 70.h,
//                           fit: BoxFit.cover,
//                         )
//                       : Image.asset(
//                           'assets/icons/logo.png',
//                           width: 120.w,
//                           height: 70.h,
//                           fit: BoxFit.contain,
//                         ),
//                 ),
//               ),
//               Flexible(
//                 child: Container(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: 150.w,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: program.bannerColor!.isNotEmpty
//                               ? ColorConverter.hexToColor(program.bannerColor!)
//                               : ColorsManager.primary,
//                           borderRadius: const BorderRadius.only(
//                             bottomRight: Radius.circular(10),
//                             topLeft: Radius.circular(10),
//                           ),
//                         ),
//                         child: Text(
//                           program.bannerName!.isNotEmpty
//                               ? program.bannerName!
//                               : S.of(context).noLevelDetails,
//                           style: TextStyles.font12MediumWeight.copyWith(
//                             color: ColorsManager.white,
//                           ),
//                         ),
//                       ),
//                       verticalSpace(3),
//                       Text(
//                         program.name,
//                         style: TextStyles.font16BoldWeight.copyWith(
//                           color: ColorsManager.primary,
//                         ),
//                       ),
//                       verticalSpace(8),
//                       Container(
//                           constraints: BoxConstraints(maxWidth: 190.w),
//                           child: wordsDesc.isNotEmpty
//                               ? Text(
//                                   wordsDesc,
//                                   style:
//                                       TextStyles.font14RegularWeight.copyWith(
//                                     color: ColorsManager.black,
//                                   ),
//                                 )
//                               : const Text('')),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
