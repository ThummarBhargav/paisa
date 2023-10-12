import 'package:flutter/material.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/sizeConstant.dart';

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({
    Key? key,
    required this.title,
    required this.options,
  }) : super(key: key);

  final List<Widget> options;
  final String title;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30,right: 13 ,left: 13),
      child: Container(
        width: MySize.getWidth(345),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: ListView(

          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                title,
                style: context.titleMedium?.copyWith(
                  color: context.primary,
                ),
              ),
            ),
            ...options
          ],
        ),
      ),
    );
  }
}
