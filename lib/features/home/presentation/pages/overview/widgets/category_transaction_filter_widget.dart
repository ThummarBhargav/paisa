import 'package:flutter/material.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/features/home/presentation/controller/summary_controller.dart';

import '../../../../../../core/constants/color_constant.dart';

class CategoryTransactionFilterWidget extends StatelessWidget {
  const CategoryTransactionFilterWidget({
    super.key,
    required this.summaryController,
  });

  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ValueListenableBuilder<TransactionType>(
        valueListenable: summaryController.typeNotifier,
        builder: (context, type, child) {
          return CustomSegmentedButton(
            segments: [
              TransactionType.income,
              TransactionType.expense,
            ],
            selected: type,
            onSelectionChanged: (newSelection) {
              summaryController.typeNotifier.value = newSelection;
            },
          );
        },
      ),
    );
  }
}

class CustomSegmentedButton extends StatefulWidget {
  final List<TransactionType> segments;
  final TransactionType selected;
  final ValueChanged<TransactionType> onSelectionChanged;

  CustomSegmentedButton({
    required this.segments,
    required this.selected,
    required this.onSelectionChanged,
  });

  @override
  _CustomSegmentedButtonState createState() => _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widget.segments.map((type) {
        final isSelected = type == widget.selected;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              if (!isSelected) {
                widget.onSelectionChanged(type);
              }
            },
            child: Container(
              width: MySize.getWidth(150),
              height: MySize.getHeight(57),
              decoration: ShapeDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        begin: Alignment(0.82, -0.57),
                        end: Alignment(-0.82, 0.57),
                        colors: [Color(0xFF9F63FF), Color(0xFF6B15F3)],
                      )
                    : RadialGradient(
                        center: Alignment(1.06, 1),
                        radius: 2.3,
                        colors: [Color(0xFFE3C0FF), Color(0xFFB7D5FF)],
                      ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Center(
                child: Text(
                  type == TransactionType.income ? 'Income' : 'Expense',
                  style: isSelected
                      ? appTheme.normalText(24)
                      : appTheme.normalText(24, Color(0xFF6C16F4)),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
