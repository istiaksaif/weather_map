import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool isBackButtonExist;
  final Function? onBackPressed;
  final Color? bgColor;
  final Color? leadingIconColor;
  final String? type;
  final String? leadingIcon;
  final bool? isNotSvg;
  final double? leadingIconSize;
  final double? leadingWidth;
  final TextStyle? textStyle;
  final Widget? action;
  final Widget? flexWidget;
  final double? preferredHeight;

  const CustomAppBar({
    super.key,
    this.title,
    this.isBackButtonExist = true,
    this.onBackPressed,
    this.bgColor,
    this.type,
    this.textStyle,
    this.leadingIconColor,
    this.leadingIcon,
    this.action,
    this.preferredHeight,
    this.flexWidget,
    this.leadingWidth,
    this.leadingIconSize,
    this.titleWidget,
    this.isNotSvg = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: bgColor ?? Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: bgColor ?? Colors.white,
      ),
      title:
          titleWidget ??
          Text(
            title ?? '',
            style: textStyle ?? dmBold.copyWith(fontSize: 24.sp),
          ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      toolbarHeight: preferredHeight ?? 60,
      backgroundColor: bgColor ?? Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading:
          isBackButtonExist
              ? IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                icon: Padding(
                  padding: EdgeInsets.only(left: leadingIcon != null ? 2 : 15),
                  child:
                      isNotSvg!
                          ? Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  offset: const Offset(0, 4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              leadingIcon!,
                              width: leadingIconSize,
                              // scale: 36,
                            ),
                          )
                          : SizedBox.shrink(),
                ),
                color: leadingIconColor,
                onPressed:
                    () =>
                        onBackPressed != null
                            ? onBackPressed!()
                            : Navigator.pop(context),
              )
              : const SizedBox(),
      leadingWidth: isBackButtonExist ? leadingWidth ?? 40 : 0,
      actions: [if (action != null) action!],
      flexibleSpace: flexWidget,
    );
  }

  @override
  Size get preferredSize => Size(1.sw, preferredHeight ?? 60.h);
}
