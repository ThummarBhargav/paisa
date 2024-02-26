import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paisa/core/AdsManager/ad_services.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/features/debit/presentation/cubit/debts_bloc.dart';
import '../../../../core/common.dart';
import '../../../../core/enum/transaction_type.dart';
import '../../../../core/widgets/paisa_widget.dart';
import '../../../../main.dart';
import '../bloc/transaction_bloc.dart';
import '../widgets/expense_and_income_widget.dart';
import '../widgets/transaction_delete_widget.dart';
import '../widgets/transaction_toggle_buttons_widget.dart';
import '../widgets/transfer_widget.dart';

class TransactionPage extends StatefulWidget {
  String? accountId;
  String? categoryId;
  String? expenseId;
  TransactionType? transactionType;
  TransactionPage({this.expenseId, this.transactionType, this.accountId, this.categoryId});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TransactionBloc transactionBloc = getIt.get();
  late final bool isAddExpense = widget.expenseId == null;
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    transactionBloc..add(ChangeTransactionTypeEvent(widget.transactionType ?? TransactionType.expense))..add(FindTransactionFromIdEvent(widget.expenseId));
  }

  @override
  Widget build(BuildContext context) {
    return PaisaAnnotatedRegionWidget(
      color: Colors.transparent,
      child: BlocProvider(
        create: (context) => transactionBloc,
        child: BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionDeletedState) {
              context.showMaterialSnackBar(
                context.loc.deletedTransaction,
                backgroundColor: context.error,
                color: context.onError,
              );
              context.pop();
            } else if (state is TransactionAdded) {
              final content = state.isAddOrUpdate
                  ? context.loc.addedTransaction
                  : context.loc.updatedTransaction;
              context.showMaterialSnackBar(
                content,
                backgroundColor: context.primaryContainer,
                color: context.onPrimaryContainer,
              );
              context.pop();
            } else if (state is TransactionErrorState) {
              context.showMaterialSnackBar(
                state.errorString,
                backgroundColor: context.errorContainer,
                color: context.onErrorContainer,
              );
            } else if (state is TransactionFoundState) {
              nameController.text = state.transaction.name ?? '';
              nameController.selection = TextSelection.collapsed(
                offset: state.transaction.name?.length ?? 0,
              );
              amountController.text = state.transaction.currency.toString();
              amountController.selection = TextSelection.collapsed(
                offset: state.transaction.currency.toString().length,
              );
              descriptionController.text = state.transaction.description ?? '';
              descriptionController.selection = TextSelection.collapsed(
                offset: state.transaction.description?.length ?? 0,
              );
            }
          },
          builder: (context, state) {
            if (widget.accountId != null) {
              BlocProvider.of<TransactionBloc>(context).selectedAccountId = int.tryParse(widget.accountId!);
            }
            if (widget.categoryId != null) {
              BlocProvider.of<TransactionBloc>(context).selectedCategoryId = int.tryParse(widget.categoryId!);
            }
            return WillPopScope(
              onWillPop: () async {
                getIt<AdService>().getDifferenceTime();
                return await true;
              },
              child: Scaffold(
                extendBody: true,
                appBar: AppBar(
                  backgroundColor: context.primary,
                  toolbarHeight: 100,
                  leading: GestureDetector(
                    onTap: () {
                      getIt<AdService>().getDifferenceTime();
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: Text(
                      isAddExpense
                          ? context.loc.addTransaction
                          : context.loc.updateTransaction,
                      style: appTheme.normalText(24, Colors.white)),
                  actions: [
                    TransactionDeleteWidget(expenseId: widget.expenseId),
                  ],
                ),
                body: Column(
                  children: [
                    Row(
                      children: [
                        TransactionToggleButtons(),
                      ],
                    ),
                    Expanded(
                      child: BlocConsumer<TransactionBloc, TransactionState>(
                        buildWhen: (previous, current) =>
                            current is ChangeTransactionTypeState,
                        builder: (context, state) {
                          if (state is ChangeTransactionTypeState) {
                            if (state.transactionType ==
                                TransactionType.transfer) {
                              return TransferWidget(
                                  controller: amountController);
                            } else {
                              return ExpenseIncomeWidget(
                                amountController: amountController,
                                descriptionController: descriptionController,
                                nameController: nameController,
                              );
                            }
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                        listener: (BuildContext context, TransactionState state) {
                          if (state is TransactionAddedState) {}
                        },
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: PaisaBigButton(
                      onPressed: () {
                        BlocProvider.of<TransactionBloc>(context).add(AddOrUpdateExpenseEvent(isAddExpense));
                      },
                      title: isAddExpense ? context.loc.add : context.loc.update,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}