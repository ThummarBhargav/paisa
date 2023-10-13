import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/core/enum/debt_type.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/debit/data/models/debit_model.dart';
import 'package:paisa/features/debit/presentation/widgets/debt_list_widget.dart';
import 'package:paisa/main.dart';

class DebtsPage extends StatelessWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:  Size.fromHeight(MySize.getHeight(60)),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
                right: 8.0,
                bottom: 0,
              ),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF6B15F3).withOpacity(0.3),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  splashBorderRadius: BorderRadius.circular(10),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: appTheme.g1()),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: Color(0xFF6C16F4),
                  labelStyle: GoogleFonts.mavenPro(
                    textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: MySize.getHeight(17),fontWeight: FontWeight.w500),
                  ),
                  unselectedLabelStyle: GoogleFonts.mavenPro(
                    textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: MySize.getHeight(17),fontWeight: FontWeight.w500),
                  ),
                  tabs: [
                    Tab(text: context.loc.debt),
                    Tab(text: context.loc.credit),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: ValueListenableBuilder<Box<DebitModel>>(
          valueListenable: getIt.get<Box<DebitModel>>().listenable(),
          builder: (context, value, child) {
            final debts = value.values
                .where((element) => element.debtType == DebitType.debit)
                .toList();

            final credits = value.values
                .where((element) => element.debtType == DebitType.credit)
                .toList();

            return TabBarView(
              children: [
                Builder(
                  builder: (context) {
                    return debts.isNotEmpty
                        ? DebtsListWidget(debts: debts)
                        : EmptyWidget(
                            title: context.loc.emptyDebts,
                            icon: MdiIcons.cashMinus,
                            description: context.loc.emptyDebtsDesc,
                          );
                  },
                ),
                Builder(
                  builder: (context) {
                    return credits.isNotEmpty
                        ? DebtsListWidget(debts: credits)
                        : EmptyWidget(
                            title: context.loc.emptyCredit,
                            icon: MdiIcons.cashMinus,
                            description: context.loc.emptyCreditDesc,
                          );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
