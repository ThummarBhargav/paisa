import 'package:flutter/material.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/sizeConstant.dart';

import '../../../../core/constants/color_constant.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.selected,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.subtitle,
    required this.color,
  });

  final int icon;
  final bool selected;
  final VoidCallback onPressed;
  final String? subtitle;
  final String title;
  final Color color;

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
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(
                  backgroundColor: color,
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
              const Spacer(),
              ListTile(
                title: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                    style: appTheme.normalText(15,Colors.black)
                ),
                subtitle: subtitle != null
                    ? Text(
                        subtitle!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
              style: appTheme.normalText(13,Colors.black54),
                      )
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
