import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';

class PaisaCard extends StatelessWidget {
  const PaisaCard({
    super.key,
    required this.child,
    this.elevation,
    this.color,
    this.shape,
  });

  final Widget child;
  final Color? color;
  final double? elevation;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    // return Card(
    //   shape: shape ??
    //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    //   color: color ?? context.surfaceVariant,
    //   clipBehavior: Clip.antiAlias,
    //   elevation: elevation ?? 2.0,
    //   shadowColor: color ?? context.shadow,
    //   child: child,
    // );

    return Container(
      width: MySize.getWidth(345),
      height: MySize.getHeight(190),
      decoration: ShapeDecoration(
        gradient: const RadialGradient(
          center: Alignment(0.11, 0.001),
          focal: Alignment(0.7, -1),
          radius: 2,
          colors: [Color(0xFFd935fe), Color(0xFF2B47FC)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F5988F8),
            blurRadius: 49,
            offset: Offset(0, 9),
            spreadRadius: 0,
          )
        ],
      ),
      child: child,
    );
  }
}

class PaisaOutlineCard extends StatelessWidget {
  const PaisaOutlineCard({
    super.key,
    required this.child,
    this.shape,
  });

  final Widget child;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              width: 1,
              color: context.outline,
            ),
          ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: context.surface,
      shadowColor: context.shadow,
      child: child,
    );
  }
}

class PaisaFilledCard extends StatelessWidget {
  const PaisaFilledCard({
    super.key,
    required this.child,
    this.shape,
    this.color,
  });

  final Widget child;
  final Color? color;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    Random random = new Random();
    int randomNumber = random.nextInt(3);
    return Container(
      width: MySize.getWidth(345),
      height: MySize.getHeight(240),
      decoration: ShapeDecoration(
        gradient:randomNumber==0?appTheme.g1():randomNumber==1?appTheme.g2():appTheme.g3(),
        image: DecorationImage(
          image: AssetImage('assets/images/CardMask.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(29.14),
        ),
      ),
      child: child,
    );
  }
}
