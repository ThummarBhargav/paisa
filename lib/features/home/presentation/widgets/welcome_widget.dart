import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserImageWidget extends StatelessWidget {
  const UserImageWidget({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return ValueListenableBuilder<Box>(
      valueListenable: getIt
          .get<Box<dynamic>>(instanceName: BoxType.settings.name)
          .listenable(keys: [userImageKey, userNameKey]),
      builder: (context, value, _) {
        String image = value.get(userImageKey, defaultValue: '');
        if (image == 'no-image') {
          image = '';
        }
        return ScreenTypeLayout.builder(
          mobile: (p0) => Builder(
            builder: (context) {
              if (image.isEmpty) {
                return ClipOval(
                  child: Container(
                    width: 43,
                    height: 43,
                    color: context.secondaryContainer,
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: context.onSecondaryContainer,
                    ),
                  ),
                );
              } else {
                return Container(
                  width: MySize.getWidth(40),
                  height: MySize.getHeight(40),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CircleAvatar(
                      foregroundImage: FileImage(File(image)),
                    ),
                  ),
                );
              }
            },
          ),
          tablet: (p0) => Builder(
            builder: (context) {
              if (image.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Container(
                      width: 42,
                      height: 42,
                      color: context.secondaryContainer,
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: context.onSecondaryContainer,
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: MySize.getWidth(38),
                    height: MySize.getHeight(38),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        foregroundImage: FileImage(
                          File(image),
                        ),
                      ),
                    ),
                  )

                );
              }
            },
          ),
        );
      },
    );
  }
}
