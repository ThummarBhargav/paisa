import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/features/settings/presentation/cubit/settings_cubit.dart';

import '../../../../core/constants/color_constant.dart';

class FixExpenseWidget extends StatelessWidget {
  const FixExpenseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return appTheme.SettingItem(
      "Fix transfer expenses",
      "Add one or more transfer category & \nclick this. Restart once completed",
      FixIcon,
      SizedBox(),
      (){
        BlocProvider.of<SettingCubit>(context).fixExpenses();
      },
    );

  }
}
