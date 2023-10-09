import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/core/enum/card_type.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';

class AccountCardV2 extends StatelessWidget {
  const AccountCardV2({
    super.key,
    required this.account,
    required this.expenses,
  });

  final AccountEntity account;
  final List<TransactionEntity> expenses;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    final ColorScheme colorScheme =
        ColorScheme.fromSeed(seedColor: Color(account.color!));
    final color = colorScheme.primaryContainer;
    final onPrimary = colorScheme.onPrimaryContainer;
    final String expense = expenses.totalExpense.toFormateCurrency(context);
    final String income = expenses.totalIncome.toFormateCurrency(context);
    final String totalBalance =
        (account.initialAmount + expenses.fullTotal).toFormateCurrency(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MySize.getHeight(240),
        child: PaisaFilledCard(
          color: color,
          child: InkWell(
            onTap: () => GoRouter.of(context).pushNamed(
              accountTransactionName,
              pathParameters: <String, String>{
                'aid': account.superId.toString()
              },
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space.height(5),
                ListTile(
                  horizontalTitleGap: 0,
                  trailing: Icon(
                    account.cardType == null
                        ? CardType.bank.icon
                        : account.cardType!.icon,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: Text(
                    account.name ?? '',
                    style: appTheme.shadowText(24),
                  ),
                  subtitle:
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Text(
                      account.bankName ?? '',
                     style: appTheme.normalText(16),
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    totalBalance,
                    style:appTheme.shadowText(38)
                  )
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child:
                  Text(
                    context.loc.thisMonth,
                      style:appTheme.shadowText(20)
                  )
                ),
                Space.height(10),
                Row(
                  children: [
                    Expanded(
                      child: ThisMonthTransactionWidget(
                        title: context.loc.income,
                        content: income,
                        color: onPrimary,
                        icon: "assets/images/Arrow1.png",
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ThisMonthTransactionWidget(
                        title: context.loc.expense,
                        color: onPrimary,
                        content: expense,
                        icon: "assets/images/Arrow2.png",
                      ),
                    ),
                  ],
                ),
               Space.height(20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThisMonthTransactionWidget extends StatelessWidget {
  const ThisMonthTransactionWidget({
    super.key,
    required this.title,
    required this.content,
    required this.color,
    required this.icon,
  });

  final Color color;
  final String content;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ Image.asset(
                  icon,
                  height: 40,
                  color: Colors.white,
                  width: 40,
                ),],)),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                 SizedBox(height: 6),
                Text(
                  content,
                 style:appTheme.shadowText(20),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
