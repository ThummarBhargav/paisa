import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';

class SummaryCardWidget1 extends StatelessWidget {
  const SummaryCardWidget1(
      {super.key,
      required this.total,
      required this.title,
      required this.graphLineColor,
      required this.icon,
      required this.data,
      this.shapeDecoration});

  final List<double> data;
  final Color graphLineColor;
  final String icon;
  final String title;
  final String total;
  final ShapeDecoration? shapeDecoration;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      width: MySize.getHeight(165),
      height: MySize.getHeight(70),
      decoration: shapeDecoration ??
          ShapeDecoration(
            gradient: RadialGradient(
              center: Alignment(1.06, 1.8),
              radius: 2.5,
              colors: [Color(0xFFFB68B7), Color(0xFFA552FF)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 8,
                offset: Offset(2, 2),
                spreadRadius: 0,
              )
            ],
          ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icon,
                    height: 40,
                    color: Colors.white,
                    width: 40,
                  ),
                ],
              )),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.mavenPro(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: MySize.getHeight(16),
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Text(
                    '${total}',
                    style: appTheme.shadowNormalText(24,FontWeight.w600),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SummaryWidget2 extends StatelessWidget {
  const SummaryWidget2({
    super.key,
    required this.total,
    required this.title,
    required this.graphLineColor,
    required this.icon,
    required this.data,
  });

  final List<double> data;
  final Color graphLineColor;
  final String icon;
  final String title;
  final String total;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      width: MySize.getHeight(165),
      height: MySize.getHeight(70),
      decoration: ShapeDecoration(
        gradient: RadialGradient(
          center: Alignment(1.06, 0.46),
          radius: 2.5,
          colors: [Color(0xFFFB9E68), Color(0xFFFF5D90)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 8,
            offset: Offset(2, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icon,
                    height: 40,
                    color: Colors.white,
                    width: 40,
                  ),
                ],
              )),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.mavenPro(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: MySize.getHeight(16),
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Text(
                    '${total}',
                    style:appTheme.shadowNormalText(24,FontWeight.w600),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
