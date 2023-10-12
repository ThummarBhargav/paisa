import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/togSwitch.dart';
import 'package:paisa/features/settings/domain/use_case/setting_use_case.dart';
import 'package:paisa/main.dart';

import '../../../../core/constants/color_constant.dart';

class AccountsStyleWidget extends StatefulWidget {
  const AccountsStyleWidget({super.key});

  @override
  State<AccountsStyleWidget> createState() => _AccountsStyleWidgetState();
}

class _AccountsStyleWidgetState extends State<AccountsStyleWidget> {
  final SettingsUseCase settingsUseCase = getIt.get();
  late bool isSelected =
      settingsUseCase.get(userAccountsStyleKey, defaultValue: false);

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> overlayColor =
    MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {

        if (states.contains(MaterialState.selected)) {
          return Color(0xFF6B15F3);
        }
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade400;
        }

        return null;
      },
    );
    return appTheme.SettingItem(
        "Account Style",
        "select your preferred\naccount display style:\nvertical or horizontal",
        AcStyle,
        TogSwitch(
         switchButton: Switch(
           value: isSelected,
           overlayColor: overlayColor,
           trackColor: overlayColor,
           trackOutlineColor:MaterialStatePropertyAll<Color>(Colors.transparent) ,
           thumbColor:isSelected? const MaterialStatePropertyAll<Color>(Colors.white):MaterialStatePropertyAll<Color>(Colors.black),
           onChanged: (bool value) {
             setState(() {
               isSelected = value;
               settingsUseCase.put(userAccountsStyleKey, value);
             });
           },
         ),));
  }
}
