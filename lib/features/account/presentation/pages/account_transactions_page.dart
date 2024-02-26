import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paisa/core/AdsManager/ad_services.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/account/presentation/bloc/accounts_bloc.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/expense_item_widget.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';
import 'package:paisa/features/home/presentation/controller/summary_controller.dart';
import 'package:paisa/main.dart';

class AccountTransactionsPage extends StatelessWidget {
  String accountId;
  SummaryController summaryController;
  AccountTransactionsPage({required this.accountId, required this.summaryController,});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    BlocProvider.of<AccountBloc>(context).add(FetchAccountAndExpenseFromIdEvent(accountId));
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: WillPopScope(
        onWillPop: () async {
          getIt<AdService>().getDifferenceTime();
          return true;
        },
        child: Scaffold(
          appBar: context.materialYouAppBar(
            context.loc.transactionHistory,
            leadingWidget: GestureDetector(
              onTap: () {
                getIt<AdService>().getDifferenceTime();
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton(
                tooltip: context.loc.edit,
                onPressed: () {
                  GoRouter.of(context).pushNamed(
                    editAccountWithIdName,
                    pathParameters: {'aid': accountId},
                  );
                },
                icon: Icon(Icons.edit_rounded,color:Colors.white),
              ),
              IconButton(
                tooltip: context.loc.delete,
                color: Colors.white,
                onPressed: () {
                  PaisaAlertDialog(
                    context,
                    title: Text(
                      context.loc.dialogDeleteTitle,
                    ),
                    child: BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        if (state is AccountAndExpensesState) {
                          return RichText(
                            text: TextSpan(
                              text: context.loc.deleteAccount,
                              style: context.bodyMedium,
                              children: [
                                TextSpan(
                                  text: state.account.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                    confirmationButton: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onPressed: () {
                        BlocProvider.of<AccountBloc>(context)
                            .add(DeleteAccountEvent(accountId));
                        Navigator.pop(context);
                      },
                      child: Text(
                        context.loc.delete,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.delete_rounded,color: Colors.white,),
              )
            ],
          ),
          body: BlocConsumer<AccountBloc, AccountState>(
            listener: (context, state) {
              if (state is AccountDeletedState) {
                context.pop();
              }
            },
            builder: (context, state) {
              if (state is AccountAndExpensesState) {
                if (state.expenses.isEmpty) {
                  return EmptyWidget(
                    icon: Icons.credit_card,
                    title: context.loc.noTransaction,
                    description: context.loc.emptyAccountMessageSubTitle,
                  );
                } else {
                  return Scrollbar(
                    controller: scrollController,
                    child: ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: state.expenses.length,
                      itemBuilder: (context, index) {
                        final TransactionEntity expense = state.expenses[index];
                        final CategoryEntity? category = BlocProvider.of<HomeBloc>(context).fetchCategoryFromId(expense.categoryId!);
                        if (category == null) {
                          return SizedBox.shrink();
                        } else {
                          return ExpenseItemWidget(
                            expense: expense,
                            account: state.account,
                            category: category,
                          );
                        }
                      },
                    ),
                  );
                }
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PaisaIconButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed(
                        addTransactionsName,
                        queryParameters: {'aid': accountId, 'type': '1'},
                      );
                    },
                    title: context.loc.income,
                    iconData: Icons.add_rounded,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  PaisaIconButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed(
                        addTransactionsName,
                        queryParameters: {'aid': accountId, 'type': '0'},
                      );
                    },
                    title: context.loc.expense,
                    iconData: Icons.add_rounded,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}