import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/sizeConstant.dart';

import '../../../../../../core/constants/color_constant.dart';

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
    return Padding(
      padding:  EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            "Your Available",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22.dp),
          ),
          Text(
            "Current Balance",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 26.dp,
            ),
          ),
          SizedBox(height: 20.dp),
          AutoSizeText(amount.toFormateCurrency(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: appTheme.shadowText(35, FontWeight.w600))
        ],
      ),
    );
  }
}
