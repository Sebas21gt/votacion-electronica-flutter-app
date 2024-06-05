// import 'package:app_vote/ui/main/styles.dart';
// import 'package:flutter/material.dart';

// class CardButton extends StatefulWidget {
//   const CardButton({
//     required this.text,
//     required this.image,
//     super.key,
//     this.width = 150,
//     this.height = 120,
//     this.onTap,
//   });

//   final String text;
//   final String image;
//   final double width;
//   final double height;
//   final VoidCallback? onTap;

//   @override
//   State<CardButton> createState() => _CardButtonState();
// }

// class _CardButtonState extends State<CardButton> {
//   bool isSelect = false;
  
//   String? get icon => null;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: secondary,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: const BorderSide(
//           color: primary,
//           width: 2,
//         ),
//       ),
//       child: InkWell(
//         onTap: () {
//           setState(() {
//             isSelect = !isSelect;
//           });
//         },
//         borderRadius: BorderRadius.circular(10),
//         splashColor: primary.withOpacity(0.2),
//         child: Container(
//           width: widget.width,
//           height: widget.height,
//           padding: const EdgeInsets.all(10),
//           child: Row(
//             children: [
//               Image.asset(
//                 image,
//                 width: 50,
//                 height: 50,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 widget.text,
//                 style: const TextStyle(
//                   color: primary,
//                   fontSize: 18,
//                   fontFamily: 'Poppins',
//                 ),
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
