import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';

class PaisaBigButton extends StatelessWidget {
  const PaisaBigButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
    this.width,
    this.iconBT,
  });

  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? width;
  final IconData? iconBT;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return InkWell(
      onTap: onPressed,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width:width?? double.infinity,
          height:height?? MySize.getHeight(58),

          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.83, -0.56),
              end: Alignment(-0.83, 0.56),
              colors: [Color(0xFF8539FF), Color(0xFF8539FF),Color(0xFF6A14F3)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Center(
            child: Row(
              children: [
                Text(
                  title,
                  style:appTheme.normalText(20,Colors.white,FontWeight.w600)
                ),
                Icon(iconBT??Icons.ac_unit_outlined),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaisaButton extends StatelessWidget {
  const PaisaButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: context.onPrimary,
        backgroundColor: context.primary,
      ),
      child: Text(title),
    );
  }
}

class PaisaIconButton extends StatelessWidget {
  const PaisaIconButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.iconData,
  });

  final IconData iconData;
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: context.onPrimary,
        backgroundColor: context.primary,
      ),
      label: Text(title),
      icon: Icon(iconData),
    );
  }
}

class PaisaTextButton extends StatelessWidget {
  const PaisaTextButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: context.primary,
      ),
      child: Text(title),
    );
  }
}

class PaisaOutlineButton extends StatelessWidget {
  const PaisaOutlineButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: context.primary,
      ),
      child: Text(title),
    );
  }
}

class PaisaOutlineIconButton extends StatelessWidget {
  const PaisaOutlineIconButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: context.primary,
      ),
      label: Text(title),
      icon: Icon(MdiIcons.sortVariant),
    );
  }
}
