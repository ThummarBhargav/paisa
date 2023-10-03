import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/account/presentation/bloc/accounts_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'accounts_mobile_page.dart';
import 'accounts_tablet_page.dart';

class AccountMobileHorizontalPage extends StatelessWidget {
  const AccountMobileHorizontalPage({
    super.key,
    required this.accounts,
  });

  final List<AccountEntity> accounts;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AccountBloc>(context)
        .add(AccountSelectedEvent(accounts.first));
    return ScreenTypeLayout.builder(
      mobile: (p0) => AccountsHorizontalMobilePage(accounts: accounts),
      tablet: (p0) => AccountsHorizontalTabletPage(accounts: accounts),
    );
  }
}
