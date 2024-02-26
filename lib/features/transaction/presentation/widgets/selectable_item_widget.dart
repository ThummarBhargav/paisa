import 'package:flutter/material.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import '../../../../core/constants/color_constant.dart';

class ItemWidget extends StatelessWidget {
  final int icon;
  final bool selected;
  final VoidCallback onPressed;
  final String? subtitle;
  final String title;
  final Color color;
  ItemWidget({required this.selected, required this.title, required this.icon, required this.onPressed, this.subtitle, required this.color,});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    final shape = selected
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: color,
              width: 2,
            ),
          )
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          );
    return SizedBox(
      width: MySize.getWidth(150),
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: shape,
        shadowColor: color,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  width: MySize.getWidth(42),
                  height: MySize.getHeight(42),
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.03, -1.00),
                      end: Alignment(-0.03, 1),
                      colors: [Color(0xFF751EFF), Color(0xFFBC92FF)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 4,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Icon(
                    IconData(
                      icon,
                      fontFamily: fontFamilyName,
                      fontPackage: fontFamilyPackageName,
                    ),
                    color: context.onPrimary,
                  ),
                ),
              ),
              Spacer(),
              ListTile(
                title: Text(title, overflow: TextOverflow.ellipsis, maxLines: 2, style: appTheme.normalText(15,Colors.black)),
                subtitle: subtitle != null
                    ? Text(subtitle!, overflow: TextOverflow.ellipsis, maxLines: 1, style: appTheme.normalText(13,Colors.black54),)
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}