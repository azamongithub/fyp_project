// import 'package:flutter/material.dart';
//
// import '../../theme/color_util.dart';
//
// class CustomAppBar extends StatelessWidget {
//   const CustomAppBar(
//       {Key? key,
//         required this.iconData,
//         required this.text,
//         this.style,
//         this.iconColor,
//         required this.onPressed,
//         this.size,
//         this.child
//       })
//       : super(key: key);
//
//   final IconData iconData;
//   final Color? iconColor;
//   final Function() onPressed;
//   final String text;
//   final TextStyle? style;
//   final double? size;
//   final Widget? child;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: ColorUtil.themeColor,
//       leading: InkWell(
//         onTap: onPressed,
//         child: Icon(
//           iconData,
//           color: iconColor,
//           size: size,
//         ),
//       ),
//       title: Text(text),
//       // title: CustomText(
//       //   text: text,
//       //   styleElement: style,
//       // ),
//       bottom: child != null
//           ? PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: child ?? const SizedBox(),
//       )
//           : null,
//     );
//   }
// }
