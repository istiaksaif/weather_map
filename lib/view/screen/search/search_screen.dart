import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/weather_controller.dart';
import '../../../model/weather_model.dart';
import '../../../utils/_constant.dart';
import '../../../utils/app_fonts.dart';
import '../../../utils/app_text.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/forecast_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(searchServiceProvider.notifier).fetchSavedWeatherList();
    });
  }

  void onSearch() {
    ref
        .read(weatherServiceProvider.notifier)
        .fetchWeather(city: searchController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final forecast = ref.watch(searchServiceProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: AppText.searchScreen,
        isBackButtonExist: false,
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFormField(
                controller: searchController,
                onEditingComplete: () {
                  onSearch();
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search locations...',
                  filled: true,
                  fillColor: Colors.grey[100],
                  suffixIcon: Icon(Icons.search_rounded),
                  hintStyle: dmMedium.copyWith(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withValues(alpha: .1),
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withValues(alpha: .1),
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withValues(alpha: .1),
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 10.h),
                child: Text(
                  AppText.recentSearch,
                  style: dmSemiBold.copyWith(fontSize: 18.sp),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: forecast?.length ?? 0,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemBuilder: (context, index) {
                WeatherModel weatherModel = WeatherModel();
                if (forecast != null && forecast.isNotEmpty) {
                  weatherModel = forecast[index];
                }
                return Padding(
                  padding: EdgeInsets.only(top: index > 0 ? 10.h : 0),
                  child: forecastCard(
                    weatherModel.name ?? '',
                    Constant.kelvinToFahrenheit(weatherModel.main?.temp),
                    '',
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 10.h),
                child: Text(
                  AppText.popularCities,
                  style: dmSemiBold.copyWith(fontSize: 18.sp),
                ),
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: 2,
              ),
              itemCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(10.w, 25.h, 10.w, 10.h),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withValues(alpha: .05),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    spacing: 5.h,
                    children: [
                      Text(
                        'City Name',
                        style: dmSemiBold.copyWith(fontSize: 18.sp),
                      ),
                      Text('54 F', style: dmReg.copyWith(color: Colors.grey)),
                    ],
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
