import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/main.dart';

import 'package:paisa/core/common.dart';

class WelcomeNameWidget extends StatelessWidget {
  const WelcomeNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: getIt
          .get<Box<dynamic>>(instanceName: BoxType.settings.name)
          .listenable(
        keys: [userNameKey],
      ),
      builder: (context, value, _) {
        final name = value.get(userNameKey, defaultValue: 'Name');
            box.write("username", name);
        return ListTile(
          title: Text(
            // ignore: prefer_interpolation_to_compose_strings
            "Hi, "+name,
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: appTheme.userTitleColor,
            ),
          ),
          subtitle: Text(
            context.loc.welcomeMessage,
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 23,
              color: appTheme.secondColor,
            ),
          ),
        );
      },
    );
  }
}
