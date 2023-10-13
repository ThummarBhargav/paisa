import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/category/data/model/category_model.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:paisa/features/home/presentation/controller/summary_controller.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';
import 'package:paisa/main.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({
    super.key,
    required this.summaryController,
  });

  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: ValueListenableBuilder<Box<CategoryModel>>(
        valueListenable: getIt.get<Box<CategoryModel>>().listenable(),
        builder: (_, value, child) {
          final categories = value.values.toBudgetEntities();
          if (categories.isEmpty) {
            return EmptyWidget(
              icon: MdiIcons.timetable,
              title: context.loc.emptyBudgetMessageTitle,
              description: context.loc.emptyBudgetMessageSubTitle,
            );
          }
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,

            itemBuilder: (context, index) {
              final CategoryEntity category = categories[index];
              final List<TransactionEntity> expenses =
                  BlocProvider.of<HomeBloc>(context)
                      .fetchExpensesFromCategoryId(category.superId!)
                      .thisMonthExpensesList;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: BudgetItem(category: category, expenses: expenses),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(),
          );
        },
      ),
    );
  }
}

class BudgetItem extends StatelessWidget {
  const BudgetItem({
    super.key,
    required this.category,
    required this.expenses,
  });

  final CategoryEntity category;
  final List<TransactionEntity> expenses;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    final double totalExpenses = expenses.totalExpense;
    final double totalBudget =
        (category.finalBudget == 0.0 ? 1 : category.finalBudget);
    double difference = category.finalBudget - totalExpenses;

    return Container(
      width: MySize.getWidth(345),
      height: MySize.getHeight(160),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x338A959E),
            blurRadius: 40,
            offset: Offset(0, 5),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Spacing.height(20),
                Container(
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
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(children: [
                Spacing.height(15),
                Row(
                  children: [
                    Text(category.name ?? '',style: appTheme.normalText(16,Colors.black,FontWeight.w400),),
                  ],
                ),
                Spacing.height(10),
                Row(
                  children: [

                    RichText(
                      text: TextSpan(
                        text: 'Limit: ',
                          style: appTheme.normalText(14,Colors.grey.shade400),
                        children: [
                          TextSpan(
                            text:
                            ' ${category.finalBudget.toFormateCurrency(context)}',
                            style: appTheme.normalText(16,Colors.grey.shade700,FontWeight.w600),
                          )
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Spacing.height(5),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Spent: ',
                        style: appTheme.normalText(14,Colors.grey.shade400),
                        children: [
                          TextSpan(
                            text: ' ${totalExpenses.toFormateCurrency(context)}',
                            style: appTheme.normalText(16,Colors.grey.shade700,FontWeight.w600),
                          )
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Spacing.height(5),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Remaining: ',
                        style: appTheme.normalText(14,Colors.grey.shade400),
                        children: [
                          TextSpan(
                            text:
                            ' ${(difference < 0 ? 0.0 : difference).toFormateCurrency(context)}',
                            style: appTheme.normalText(16,Colors.grey.shade700,FontWeight.w600),
                          )
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Spacing.height(15),
                Padding(
                  padding: const EdgeInsets.only(right: 15,bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: totalExpenses / totalBudget,
                      color: category.foregroundColor,
                      backgroundColor: category.backgroundColor,
                    ),
                  ),
                )
              ],))
        ],
      ),
    );



  }
}
