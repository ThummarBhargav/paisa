import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa/core/common.dart';

import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/transaction/presentation/bloc/transaction_bloc.dart';

import 'package:responsive_builder/responsive_builder.dart';

class TransactionDeleteWidget extends StatelessWidget {

  final String? expenseId;
  TransactionDeleteWidget({required this.expenseId});

  void onPressed(BuildContext context) {
    PaisaAlertDialog(
      context,
      title: Text(context.loc.dialogDeleteTitle),
      child: RichText(
        text: TextSpan(
          text: context.loc.deleteExpense,
          style: context.bodyLarge,
        ),
      ),
      confirmationButton: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onPressed: () {
          BlocProvider.of<TransactionBloc>(context)
              .add(ClearExpenseEvent(expenseId!));
          Navigator.pop(context);
        },
        child: Text(context.loc.delete),
      ), cancelButton: TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(context.loc.cancel),
    ), titleTextStyle: context.titleLarge,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (expenseId == null) {
      return const SizedBox.shrink();
    } else {
      return ScreenTypeLayout.builder(
        mobile: (p0) => IconButton(
          onPressed: () => onPressed(context),
          icon: Icon(
            Icons.delete_rounded,
            color: Colors.white,
          ),
        ),
        tablet: (p0) => PaisaTextButton(
          onPressed: () => onPressed(context),
          title: context.loc.delete,
        ),
      );
    }
  }
}
