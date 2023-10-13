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
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 35,),
                  Row(
                    children: [
                      Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        "Hi, "+name,
                        style: appTheme.normalText(18,Colors.black,FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(
                    context.loc.welcomeMessage,
                    style: appTheme.normalText(23,appTheme.secondColor,FontWeight.w600),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
