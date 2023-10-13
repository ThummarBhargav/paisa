import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';

import '../../../../../../core/constants/color_constant.dart';

class ExpenseItemWidget extends StatelessWidget {
  const ExpenseItemWidget({
    Key? key,
    required this.expense,
    required this.account,
    required this.category,
  }) : super(key: key);

  final AccountEntity account;
  final CategoryEntity category;
  final TransactionEntity expense;

  String getSubtitle(BuildContext context) {
    if (expense.type == TransactionType.transfer) {
      return expense.time!.shortDayString;
    } else {
      return context.loc.transactionSubTittleText(
        account.bankName ?? '',
        expense.time!.shortDayString,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return InkWell(
      onTap: () {
        context.goNamed(
          editTransactionsName,
          pathParameters: <String, String>{'eid': expense.superId.toString()},
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MySize.getWidth(345),
          height: MySize.getWidth(70),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 25,
                offset: Offset(0, 0),
                spreadRadius: 1,
              )
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  width: MySize.getWidth(48.14),
                  height: MySize.getWidth(48),
                  decoration: ShapeDecoration(
                    color: Color(category.color ?? context.surface.value)
                        .withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(category.color ?? context.surface.value)
                            .withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Icon(
                    IconData(
                      category.icon ?? 0,
                      fontFamily: fontFamilyName,
                      fontPackage: fontFamilyPackageName,
                    ),
                    color: Color(category.color ?? context.surface.value),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        expense.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                  Text(
                              getSubtitle(context),
                              style: TextStyle(
                                color: Color(0xFF8A959E),
                                fontSize: 13,
                                fontFamily: 'Maven Pro',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.31,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: AutoSizeText(
                                expense.currency!.toFormateCurrency(context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: appTheme.normalText(17, Color(0xFF07B103)),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpenseTransferItemWidget extends StatelessWidget {
  const ExpenseTransferItemWidget({
    Key? key,
    required this.expense,
    required this.fromAccount,
    required this.toAccount,
  }) : super(key: key);

  final TransactionEntity expense;
  final AccountEntity fromAccount, toAccount;

  String get title {
    return 'Transfer from ${fromAccount.bankName} to ${toAccount.bankName}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => context.goNamed(
          editTransactionsName,
          pathParameters: <String, String>{'eid': expense.superId.toString()},
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(expense.time!.shortDayString),
          leading: CircleAvatar(
            backgroundColor: context.primary.withOpacity(0.2),
            child: Icon(
              MdiIcons.bankTransfer,
              color: context.primary,
            ),
          ),
          trailing: Text(
            '${expense.type?.sign}${expense.currency!.toFormateCurrency(context)}',
            style: context.bodyLarge?.copyWith(
              color: expense.type?.color(context),
            ),
          ),
        ),
      ),
    );
  }
}
