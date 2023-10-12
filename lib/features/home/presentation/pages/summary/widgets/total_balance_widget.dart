import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/sizeConstant.dart';

import '../../../../../../core/constants/color_constant.dart';
import '../../../../../../main.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
class TotalBalanceWidget extends StatelessWidget {
  const TotalBalanceWidget({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  final double amount;
  final String title;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         SizedBox(height: 10),
        Text(
          "Your Available",
          style:TextStyle(  color: Colors.white,
            fontWeight: FontWeight.w700,fontSize:22.dp),
        ),
        Text(
          "Current Balance",
          style:TextStyle(  color: Colors.white,
            fontWeight: FontWeight.w700,fontSize:26.dp,),
        ),

         SizedBox(height: 20.dp),
        Text(
          amount.toFormateCurrency(context),
            style:appTheme.shadowText(35,FontWeight.w600)
        ),
      ],
    );
  }
}