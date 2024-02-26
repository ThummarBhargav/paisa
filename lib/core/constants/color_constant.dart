import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'constants.dart';

class BaseTheme {
  Color get primaryTheme => fromHex('#a14f3');

  Color get buttonColor => fromHex('#FE9013');

  Color get secondColor => fromHex('#2D0173');

  Color get userTitleColor => fromHex('#201E1E');

  Color get textGrayColor => fromHex("#5E5E5E");

  List<BoxShadow> get getShadow {
    return [
      BoxShadow(
        offset: Offset(2, 2),
        color: Colors.black26,
        blurRadius: MySize.getHeight(2),
        spreadRadius: MySize.getHeight(2),
      ),
      BoxShadow(
        offset: Offset(-1, -1),
        color: Colors.white.withOpacity(0.8),
        blurRadius: MySize.getHeight(2),
        spreadRadius: MySize.getHeight(2),
      ),
    ];
  }

  List<BoxShadow> get getShadow3 {
    return [
      BoxShadow(
        offset: Offset(2, 2),
        color: Colors.black12,
        blurRadius: MySize.getHeight(0.5),
        spreadRadius: MySize.getHeight(0.5),
      ),
      BoxShadow(
        offset: Offset(-1, -1),
        color: Colors.white.withOpacity(0.8),
        blurRadius: MySize.getHeight(0.5),
        spreadRadius: MySize.getHeight(0.5),
      ),
    ];
  }

  List<BoxShadow> get getShadow2 {
    return [
      BoxShadow(
          offset: Offset(MySize.getWidth(2.5), MySize.getHeight(2.5)),
          color: Color(0xffAEAEC0).withOpacity(0.4),
          blurRadius: MySize.getHeight(5),
          spreadRadius: MySize.getHeight(0.2)),
      BoxShadow(
          offset: Offset(MySize.getWidth(-1.67), MySize.getHeight(-1.67)),
          color: Color(0xffFFFFFF),
          blurRadius: MySize.getHeight(5),
          spreadRadius: MySize.getHeight(0.2)),
    ];
  }

  LinearGradient g1() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFFB68B7), Color(0xFFA552FF)],
    );
  }

  LinearGradient g2() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFf35e82), Color(0xFFff6288)],
    );
  }

  LinearGradient g3() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF5a8ef3), Color(0xFF52b9f1)],
    );
  }

  RadialGradient g4() {
    return RadialGradient(
      center: Alignment(1.06, 0.46),
      radius: 5,
      colors: [Color(0xFFE3C0FF), Color(0xFFB7D5FF)],
    );
  }

  SettingItem(String title,String des,String icon,Widget widget,[VoidCallback? ontap]) {
    return InkWell(
      onTap: ontap??(){},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: MySize.getHeight(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Spacing.width(20),
                    Image.asset(icon,width: 50,height: 50,),
                    Spacing.width(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title, style: appTheme.normalText(16, Colors.black),),
                        Text(maxLines: 4, des, style: appTheme.normalText(12, Colors.grey,FontWeight.w400),),
                      ],
                    ),
                  ],
                ),
                widget,
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle shadowText(double fontSize,
      [FontWeight? fontWeight, Color? color]) {
    return GoogleFonts.mavenPro(
      textStyle: TextStyle(
          color: color ?? Colors.white,

          shadows: [
            Shadow(
              offset: Offset(1.0, 4.0),
              blurRadius: 20.0,
              color: Color.fromARGB(68, 0, 0, 0),
            ),
          ],
          fontSize: fontSize.dp,
          fontWeight: fontWeight ?? FontWeight.w500),
    );
  }

  TextStyle shadowNormalText(double fontSize, [FontWeight? fontWeight]) {
    return GoogleFonts.mavenPro(
      textStyle: TextStyle(
          color: Colors.white,

          shadows: [
            Shadow(
              offset: Offset(0.0, 1.5),
              blurRadius: 8.0,
              color: Color.fromARGB(119, 100, 100, 100),
            ),
          ],
          fontSize: fontSize.dp,
          fontWeight: fontWeight ?? FontWeight.w500),
    );
  }

  TextStyle normalText(double fontSize,
      [Color color = Colors.white, FontWeight? fontWeight]) {
    return GoogleFonts.mavenPro(
      textStyle: TextStyle(
          color: color,
          fontSize: fontSize.sp,
          fontWeight: fontWeight ?? FontWeight.w500),
    );
  }

  String countryCodeToEmoji(String countryCode) {
    // 0x41 is Letter A
    // 0x1F1E6 is Regional Indicator Symbol Letter A
    // Example :
    // firstLetter U => 20 + 0x1F1E6
    // secondLetter S => 18 + 0x1F1E6
    // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
    final int firstLetter =
        countryCode.toUpperCase().codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter =
        countryCode.toUpperCase().codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }
}

BaseTheme get appTheme => BaseTheme();

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

String calculateTimeDifferenceOnSameDate(TimeOfDay startTime, TimeOfDay endTime) {
  // Get the current date
  if (endTime.hour < startTime.hour) {
    return "0";
  }

  DateTime currentDate = DateTime.now();

  // Create DateTime objects with the same date and different times
  DateTime startDateTime = DateTime(
    currentDate.year,
    currentDate.month,
    currentDate.day,
    startTime.hour,
    startTime.minute,
  );

  DateTime endDateTime = DateTime(
    currentDate.year,
    currentDate.month,
    currentDate.day,
    endTime.hour,
    endTime.minute,
  );

  // Calculate the difference between the two times
  Duration difference = endDateTime.difference(startDateTime);

  // Extract the individual components from the duration
  int hours = difference.inHours;
  int minutes = difference.inMinutes % 60;

  // Construct the result string
  String result = '';
  int second_hours = 0;
  int minutes_hours = 0;
  if (hours > 0) second_hours = hours * 60 * 60;
  // result += '$hours hours ';

  if (minutes > 0)
    //  result += '$minutes minutes';
    minutes_hours = minutes * 60;
  result += '${minutes_hours + second_hours}';

  return result.trim();
}