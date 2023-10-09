import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/core/theme/custom_color.dart';
import 'package:paisa/features/account/presentation/widgets/summary_month_card_widget.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';

class AccountSummaryWidget extends StatelessWidget {
  const AccountSummaryWidget({
    super.key,
    required this.expenses,
    this.useAccountsList = false,
  });

  final List<TransactionEntity> expenses;
  final bool useAccountsList;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            title: Text(
              'This month',
              style: TextStyle(
                color: Colors.black,
                fontSize: MySize.getHeight(20),
                fontFamily: 'Maven Pro',
                fontWeight: FontWeight.w500,
                height: 0,
                letterSpacing: -0.20,
              ),
            
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SummaryCardWidget1(
                  title: context.loc.income,
                  total: expenses.thisMonthIncome.toFormateCurrency(context),
                  data: expenses.incomeDoubleList,
                  graphLineColor:
                      Theme.of(context).extension<CustomColors>()!.green ??
                          context.secondary,
                  icon: "assets/images/Arrow1.png",
                ),
              ),
              SizedBox(width: MySize.getWidth(15),),
              Expanded(
                child: SummaryWidget2(
                  title: context.loc.expense,
                  total: expenses.thisMonthExpense.toFormateCurrency(context),
                  data: expenses.expenseDoubleList,
                  graphLineColor:
                      Theme.of(context).extension<CustomColors>()!.red ??
                          context.secondary,
                  icon: "assets/images/Arrow2.png",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
