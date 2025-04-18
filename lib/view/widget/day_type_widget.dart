import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget dayTypeContainer({double size = 50, String? type}) {
  IconData iconData;
  Color bgColor;

  switch (type?.toLowerCase()) {
    case 'sunny':
      iconData = Icons.wb_sunny;
      bgColor = Colors.orangeAccent;
      break;
    case 'rain':
      iconData = Icons.beach_access;
      bgColor = Colors.blueAccent;
      break;
    case 'storm':
      iconData = Icons.flash_on;
      bgColor = Colors.deepPurple;
      break;
    case 'clouds':
      iconData = Icons.cloud;
      bgColor = Colors.grey;
      break;
    case 'clear':
      iconData = Icons.wb_sunny;
      bgColor = Colors.grey;
      break;
    default:
      iconData = Icons.help_outline;
      bgColor = Colors.transparent;
  }

  return (type != null && type.isNotEmpty)
      ? Container(
        height: size.h,
        width: size.h,
        decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
        child: Center(
          child: Icon(iconData, color: Colors.white, size: size * 0.5),
        ),
      )
      : SizedBox.shrink();
}
