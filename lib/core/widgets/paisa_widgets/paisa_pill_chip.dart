import 'package:flutter/material.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';

class PaisaPillChip extends StatelessWidget {
  const PaisaPillChip({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isSelected,
  });

  final bool isSelected;
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    final bgColor = context.primaryContainer;
    final textColor = context.primary;
    final borderColor = isSelected ? context.primary : null;

    return Row(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            width: MySize.getWidth(90),
            height: MySize.getHeight(40),
            decoration: ShapeDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment(0.82, -0.57),
                      end: Alignment(-0.82, 0.57),
                      colors: [ Color(0xFF9F63FF),Color(0xFF6B15F3)],
                    )
                  : RadialGradient(
                      center: Alignment(1.06, 1),
                      radius: 2.3,
                      colors: [Color(0xFFE3C0FF), Color(0xFFB7D5FF)],
                    ),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
            child: Center(
              child: Text(
                title,
                style:isSelected? appTheme.normalText(18):appTheme.normalText(18,Color(0xFF6C16F4)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8)
      ],
    );
  }
}
class PaisaFiltetextends extends StatelessWidget {
  const PaisaFiltetextends({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isSelected,
  });

  final bool isSelected;
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    final bgColor = context.primaryContainer;
    final textColor = context.primary;
    final borderColor = isSelected ? context.primary : null;

    return Row(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            width: MySize.getWidth(169),
            height: MySize.getHeight(40),
            decoration: ShapeDecoration(

              gradient:
                   RadialGradient(
                      center: Alignment(1.06, 1),
                      radius: 2.3,
                      colors: [Color(0xFFE3C0FF), Color(0xFFB7D5FF)],
                   ),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
            child: Center(
              child: Text(
                title,
                style:appTheme.normalText(18,Color(0xFF6C16F4))),
              ),
            ),
          ),

        const SizedBox(width: 8)
      ],
    );
  }
}
