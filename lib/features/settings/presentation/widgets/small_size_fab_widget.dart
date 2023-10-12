import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/main.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/togSwitch.dart';

class SmallSizeFabWidget extends StatefulWidget {
  const SmallSizeFabWidget({super.key});

  @override
  State<SmallSizeFabWidget> createState() => _SmallSizeFabWidgetState();
}

class _SmallSizeFabWidgetState extends State<SmallSizeFabWidget> {
  late bool isSelected = settings.get(smallSizeFabKey, defaultValue: false);
  final settings = getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);

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
        context.loc.smallSizeFab,
        "show small size action\nbutton on all screens",
        ScaleIcon,
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
                settings.put(smallSizeFabKey, value);
              });
            },
          ),));



      SwitchListTile(
      secondary: Icon(MdiIcons.resize),
      title: Text(
        context.loc.smallSizeFab,
      ),
      subtitle: Text(context.loc.smallSizeFabMessage),
      onChanged: (bool value) async {
        setState(() {
          isSelected = value;
        });
        settings.put(smallSizeFabKey, value);
      },
      value: isSelected,
    );
  }
}
