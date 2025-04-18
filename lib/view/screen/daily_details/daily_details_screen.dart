import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/weather_controller.dart';
import '../../../model/weather_model.dart';
import '../../../utils/_constant.dart';
import '../../../utils/app_fonts.dart';
import '../../../utils/app_text.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/day_type_widget.dart';
import '../../widget/forecast_card.dart';

class DailyDetailsScreen extends StatelessWidget {
  final WeatherModel weatherModel;

  const DailyDetailsScreen({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: AppText.dailyDetailsScreen,
        isBackButtonExist: false,
      ),
      body: Column(
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
                Constant.formatToDayDate(weatherModel.dtTxt),
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
                Text(
                  '${Constant.kelvinToFahrenheit(weatherModel.main?.tempMax)} / ${Constant.kelvinToFahrenheit(weatherModel.main?.tempMax)}',
                  style: workBlack.copyWith(height: 1.h),
                ),
                Text(
                  '${weatherModel.weather?.first.main}',
                  style: dmMedium.copyWith(fontSize: 16.sp),
                ),
                dayTypeContainer(
                  size: 40,
                  type: '${weatherModel.weather?.first.main}',
                ),
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
          Consumer(
            builder: (context, ref, _) {
              final forecast = ref.watch(forecastServiceProvider);
              final uniqueForecast =
                  (forecast != null && forecast.isNotEmpty)
                      ? Constant.getSameDayForecasts(
                        forecast,
                        Constant.getShortDayName(weatherModel.dtTxt),
                      )
                      : [];
              return ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: uniqueForecast.length,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemBuilder: (context, index) {
                  WeatherModel weatherModel = WeatherModel();
                  if (forecast != null && uniqueForecast.isNotEmpty) {
                    weatherModel = uniqueForecast[index];
                  }
                  return Padding(
                    padding: EdgeInsets.only(
                      top: index < uniqueForecast.length ? 10.h : 0,
                    ),
                    child: forecastCard(
                      Constant.formatTo12HourTime(weatherModel.dtTxt),
                      '${Constant.kelvinToFahrenheit(weatherModel.main?.tempMax)} / ${Constant.kelvinToFahrenheit(weatherModel.main?.tempMax)}',
                      '${weatherModel.weather?.first.main}',
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
