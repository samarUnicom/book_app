import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

class ThemeText {
  ThemeText._();

  static const String appFontFamily = "Medium";
  static TextStyle customSubtitle1 = TextStyle(
      color: ThemeColor.derkgreycolor,
      fontSize: 16.sp,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.bold);
  static TextStyle customSubtitle2 = TextStyle(
      color: ThemeColor.derkgreycolor,
      fontSize: 16.sp,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.bold);
  static TextStyle customBodyText1 = const TextStyle(
    fontFamily: appFontFamily,
    color: ThemeColor.derkgreycolor,
  );
  static TextStyle customBodyText2 = const TextStyle(
    fontFamily: appFontFamily,
    color: ThemeColor.derkgreycolor,
  );
  static TextStyle customHeadline6 = TextStyle(
      color: ThemeColor.buttonTextColor,
      fontSize: 14.sp,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.bold);
  static TextStyle customHeadline5 = TextStyle(
      color: ThemeColor.derkgreycolor,
      fontSize: 16.sp,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.bold);
  static TextStyle customHeadline4 = TextStyle(
      color: ThemeColor.blackColor.withOpacity(0.7),
      fontSize: 14.sp,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.bold);
  static TextStyle customHeadline3 = TextStyle(
      color: ThemeColor.derkgreycolor,
      fontSize: 12.sp,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.bold);
  static TextStyle customHeadline2 = TextStyle(
      color: ThemeColor.hintColor,
      fontFamily: appFontFamily,
      fontSize: 12.sp,
      fontWeight: FontWeight.bold);
  static TextStyle customHeadline1 = TextStyle(
      color: ThemeColor.errorColor,
      fontSize: 10.sp,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.bold);
}
