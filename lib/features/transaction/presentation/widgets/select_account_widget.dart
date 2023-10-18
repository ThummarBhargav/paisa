import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/features/account/data/model/account_model.dart';
import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:paisa/features/transaction/presentation/widgets/selectable_item_widget.dart';
import 'package:paisa/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../core/constants/color_constant.dart';

class SelectedAccount extends StatelessWidget {
  const SelectedAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<AccountModel>>(
      valueListenable: getIt.get<Box<AccountModel>>().listenable(),
      builder: (context, value, child) {
        final accounts = value.values.toEntities();
        if (accounts.isEmpty) {
          return ListTile(
            onTap: () => context.pushNamed(addAccountPath),
            title: Text(context.loc.addAccountEmptyTitle),
            subtitle: Text(context.loc.addAccountEmptySubTitle),
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        }

        return ScreenTypeLayout.builder(
          tablet: (p0) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.loc.selectAccount,
                  style: context.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AccountSelectedItem(
                accounts: accounts,
                onSelected: (selectedId) {
                  BlocProvider.of<TransactionBloc>(context).selectedAccountId =
                      selectedId;
                },
              )
            ],
          ),
          mobile: (p0) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.loc.selectAccount,
                  style: appTheme.normalText(18, Colors.black),
                ),
              ),
              AccountSelectedItem(
                accounts: accounts,
                onSelected: (selectedId) {
                  BlocProvider.of<TransactionBloc>(context).selectedAccountId =
                      selectedId;
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class AccountSelectedItem extends StatefulWidget {
  const AccountSelectedItem({
    Key? key,
    required this.accounts,
    required this.onSelected,
  }) : super(key: key);

  final List<AccountEntity> accounts;
  final Function(int selectedId) onSelected;

  @override
  State<AccountSelectedItem> createState() => _AccountSelectedItemState();
}

class _AccountSelectedItemState extends State<AccountSelectedItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      buildWhen: (previous, current) => current is ChangeAccountState,
      builder: (context, state) {
        return SizedBox(
          height: 160,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            scrollDirection: Axis.horizontal,
            shrinkWrap: false,
            itemCount: widget.accounts.length + 1,
            itemBuilder: (_, index) {
              if (index == 0) {
                return ItemWidget(
                  color: Color(0xFF6C16F4),
                  selected: false,
                  title: context.loc.addNew,
                  icon: MdiIcons.plus.codePoint,
                  onPressed: () => context.pushNamed(addAccountPath),
                );
              } else {
                final AccountEntity account = widget.accounts[index - 1];
                int selectedId = BlocProvider.of<TransactionBloc>(context)
                    .selectedAccountId!;
                return ItemWidget(
                  color: Color(0xFF6C16F4).withOpacity(0.8),
                  selected: account.superId == selectedId,
                  title: account.name ?? '',
                  icon: account.cardType!.icon.codePoint,
                  onPressed: () {
                    BlocProvider.of<TransactionBloc>(context)
                        .add(ChangeAccountEvent(account));
                    setState(() {
                      selectedId = account.superId!;
                      widget.onSelected(selectedId);
                    });
                  },
                  subtitle: account.bankName,
                );
              }
            },
          ),
        );
      },
    );
  }
}
