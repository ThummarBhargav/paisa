import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/features/recurring/data/model/recurring.dart';
import 'package:paisa/main.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';

class RecurringPage extends StatelessWidget {
  const RecurringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: Scaffold(

        body: ValueListenableBuilder<Box<RecurringModel>>(
          valueListenable: getIt.get<Box<RecurringModel>>().listenable(),
          builder: (_, value, child) {
            final List<RecurringModel> recurringModels = value.values.toList();
            if (recurringModels.isEmpty) {
              return EmptyWidget(
                title: context.loc.recurringEmptyMessageTitle,
                description: context.loc.recurringEmptyMessageSubTitle,
                icon: MdiIcons.cashSync,
                actionTitle: context.loc.recurringAction,
                onActionPressed: () {
                  GoRouter.of(context).pushNamed(recurringName);
                },
              );
            }
            return RecurringListWidget(recurringModels: recurringModels);
          },
        ),
      ),
    );
  }
}

class RecurringListWidget extends StatelessWidget {
  const RecurringListWidget({super.key, required this.recurringModels});

  final List<RecurringModel> recurringModels;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return SafeArea(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: recurringModels.length,
        itemBuilder: (context, index) {
          final RecurringModel expense = recurringModels[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MySize.getWidth(345),
              height: MySize.getHeight(70),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
              child: ListTile(
                title: Text(expense.name,style: appTheme.normalText(16,Colors.black),),
                subtitle: Text(
                    '${expense.recurringType.name(context)} - ${expense.recurringDate.shortDayString}',style: appTheme.normalText(14,Colors.black87,FontWeight.w400),),
                trailing: InkWell(
                  onTap: () async {
                    await expense.delete();
                  },
                  child: Image.asset("assets/images/delete.png",width: 40,height: 40,),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
