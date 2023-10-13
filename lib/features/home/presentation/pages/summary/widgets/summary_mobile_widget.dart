import 'package:flutter/material.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/expense_history_widget.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/expense_total_widget.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/welcome_name_widget.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';

class SummaryMobileWidget extends StatelessWidget {
  const SummaryMobileWidget({
    super.key,
    required this.expenses,
  });

  final List<TransactionEntity> expenses;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: context.surface,
      body: ListView.builder(

        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        padding: const EdgeInsets.only(bottom: 124),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const WelcomeNameWidget();
          } else if (index == 1) {
            return ExpenseTotalWidget(expenses: expenses);
          } else if (index == 2) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              title:  Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Text(
                      'Transaction History',
                      style: appTheme.normalText(19,Colors.black),

                    ),

                  ],
                ),
              ),
            );
          } else if (index == 3) {
            return ExpenseHistoryWidget(expenses: expenses);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
