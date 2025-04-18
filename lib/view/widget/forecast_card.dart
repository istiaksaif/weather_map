import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_fonts.dart';
import 'day_type_widget.dart';

Widget forecastCard(
  String day,
  String value,
  String dayType, {
  Function? onTap,
  EdgeInsetsGeometry? padding,
  MainAxisAlignment? mainAxisAlignment,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(10.r),
    onTap: () {
      if (onTap != null) {
        onTap();
      }
    },
    child: Container(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceAround,
        children: [
          Text(day, style: dmMedium.copyWith(fontSize: 18.sp)),
          Text(value, style: workReg),
          if (dayType.isNotEmpty) dayTypeContainer(size: 24, type: dayType),
        ],
      ),
    ),
  );
}
