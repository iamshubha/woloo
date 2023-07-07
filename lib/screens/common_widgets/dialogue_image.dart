// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:janitor/screens/common_widgets/white_button_widget.dart';
// import 'package:janitor/utils/app_color.dart';
// import 'package:janitor/utils/app_constants.dart';
//
// class ImageDialogueWidget extends StatefulWidget {
//   final String text;
//   final Function onTapSubmit;
//   const ImageDialogueWidget({
//     Key? key,
//     required this.text,
//     required this.onTapSubmit,
//   }) : super(key: key);
//
//   @override
//   State<ImageDialogueWidget> createState() => _ImageDialogueWidgetState();
// }
//
// class _ImageDialogueWidgetState extends State<ImageDialogueWidget> {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(
//           10.r,
//         ),
//       ),
//       child: SizedBox(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 5.w,
//             vertical: 20.h,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 10.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 10.w,
//                 ),
//                 child: Container(
//                     height: 115.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: AppColors.commentBoxBorder, width: 1.w),
//                     ),
//                     child: Image.file()),
//               ),
//               SizedBox(
//                 height: 30.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 10.w,
//                 ),
//                 child: WhiteButtonWidget(
//                   text: MyTaskListConstants.SUBMIT_BTN,
//                   color: AppColors.buttonColor,
//                   onTap: () {
//                     widget.onTapSubmit();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
