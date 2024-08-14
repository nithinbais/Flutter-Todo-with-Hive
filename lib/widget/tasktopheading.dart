// import 'package:flutter/material.dart';

// class tasktopheading extends StatelessWidget {
//   const tasktopheading({
//     super.key,
//     required this.textTheme,
//   });

//   final TextTheme textTheme;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 100,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(
//             width: 50,
//             child: Divider(
//               thickness: 2,
//             ),
//           ),
//           RichText(
//             text: TextSpan(
//               text: 'Add New ',
//               style: textTheme.titleLarge,
//               children: [
//                 TextSpan(
//                   text: 'Task',
//                   style: TextStyle(fontWeight: FontWeight.w400),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             width: 50,
//             child: Divider(
//               thickness: 2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
