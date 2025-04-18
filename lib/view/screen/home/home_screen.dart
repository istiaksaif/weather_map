import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/weather_controller.dart';
import '../../../utils/app_fonts.dart';
import '../../../utils/app_text.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/day_type_widget.dart';
import '../../widget/forecast_card.dart';
import '../daily_details/daily_details_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(weatherServiceProvider).fetchWeather());
  }

  @override
  Widget build(BuildContext context) {
    final weather = ref.watch(weatherServiceProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: AppText.homeScreen, isBackButtonExist: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50.h,
              margin: EdgeInsets.fromLTRB(10.w, 0.h, 0, 20.h),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      allowSnapshotting: false,
                      builder: (context) => SearchScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'San Francisco',
                        style: dmSemiBold.copyWith(fontSize: 20.sp),
                      ),
                      Icon(
                        Icons.arrow_circle_right_rounded,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
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
                  dayTypeContainer(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  AppText.fiveDayForecast,
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
                    'Mon',
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
