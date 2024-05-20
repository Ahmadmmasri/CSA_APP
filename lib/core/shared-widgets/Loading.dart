import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Lottie.asset('assets/animated/loading.json'),
      ],
    );
  }
}


// Center(
//       child: Opacity(
//         opacity: 0.7,
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           color: Colors.grey,
//           alignment: Alignment.center,
//           child: Lottie.asset(
//             'assets/animated/loading.json',
//             width: 235,
//             height: 235,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
