import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_fonts.dart';
import '../../../utils/app_text.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/day_type_widget.dart';
import '../../widget/forecast_card.dart';

class DailyDetailsScreen extends StatelessWidget {
  const DailyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: AppText.dailyDetailsScreen,
        isBackButtonExist: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50.h,
              margin: EdgeInsets.fromLTRB(10.w, 0.h, 0, 20.h),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            Row(
              children: [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Monday, 18 March',
                  style: dmSemiBold.copyWith(fontSize: 22.sp),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withValues(alpha: .15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                spacing: 5.h,
                children: [
                  Text('72 F', style: workBlack.copyWith(height: 1.h)),
                  Text('Sunny', style: dmMedium.copyWith(fontSize: 16.sp)),
                  dayTypeContainer(size: 40),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  AppText.hourlyForecast,
                  style: dmSemiBold.copyWith(fontSize: 18.sp),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: index < 5 ? 10.h : 0),
                  child: forecastCard(
                    '12pm',
                    '74 / 65',
                    'Sun',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          allowSnapshotting: false,
                          builder: (context) => DailyDetailsScreen(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
