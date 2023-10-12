import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:paisa/core/common.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/color_constant.dart';

class CountryChangeWidget extends StatelessWidget {
  const CountryChangeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String currentSymbol = Provider.of<Box<dynamic>>(context)
        .get(userLanguageKey, defaultValue: 'INR');
    return  appTheme.SettingItem(
      "Currency Sign",
      "INR",
      CurrencyIcon,
      SizedBox(),
          () {
            context.pushNamed(
              countrySelectorName,
              queryParameters: {'force_country_selector': 'true'},
            );
      },
    );
  }
}
