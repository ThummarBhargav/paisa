import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paisa/core/AdsManager/ad_services.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/enum/card_type.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/account/presentation/bloc/accounts_bloc.dart';
import 'package:paisa/features/account/presentation/widgets/card_type_drop_down.dart';
import 'package:paisa/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:paisa/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

final GlobalKey<FormState> _form = GlobalKey<FormState>();

class AddAccountPage extends StatefulWidget {
  String? accountId;
  AddAccountPage({this.accountId,});

  @override
  AddAccountPageState createState() => AddAccountPageState();
}

class AddAccountPageState extends State<AddAccountPage> {
  final accountHolderController = TextEditingController();
  final accountInitialAmountController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final AccountBloc accountsBloc = getIt.get();
  late final bool isAccountAddOrUpdate = widget.accountId == null;

  @override
  void dispose() {
    accountHolderController.dispose();
    accountInitialAmountController.dispose();
    accountNumberController.dispose();
    accountNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    accountsBloc.add(FetchAccountFromIdEvent(widget.accountId));
  }

  void _showInfo() => showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (context) {
          return SafeArea(
            maintainBottomViewPadding: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.info_rounded),
                  title: Text(
                    context.loc.accountInformationTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(context.loc.accountInformationSubTitle),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      child: Text(context.loc.ok),
                    ),
                  ),
                ),
                SizedBox(height: 10)
              ],
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: BlocProvider(
        create: (context) => accountsBloc,
        child: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountAddedState) {
              context.showMaterialSnackBar(
                isAccountAddOrUpdate
                    ? context.loc.addedAccount
                    : context.loc.updateAccount,
                backgroundColor: context.primaryContainer,
                color: context.onPrimaryContainer,
              );
              context.pop();
            }
            if (state is AccountDeletedState) {
              context.showMaterialSnackBar(
                context.loc.deleteAccount,
                backgroundColor: context.error,
                color: context.onError,
              );
              context.pop();
            } else if (state is AccountErrorState) {
              context.showMaterialSnackBar(
                state.errorString,
                backgroundColor: context.errorContainer,
                color: context.onErrorContainer,
              );
            } else if (state is AccountSuccessState) {
              accountNameController.text = state.account.bankName ?? '';
              accountNameController.selection = TextSelection.collapsed(offset: state.account.bankName?.length ?? 0);
              accountNumberController.text = state.account.number ?? '';
              accountNumberController.selection = TextSelection.collapsed(offset: state.account.number?.length ?? 0);
              accountHolderController.text = state.account.name ?? '';
              accountHolderController.selection = TextSelection.collapsed(offset: state.account.name?.length ?? 0);
              accountInitialAmountController.text = state.account.amount.toString();
              accountInitialAmountController.selection = TextSelection.collapsed(offset: state.account.amount.toString().length);
            }
          },
          builder: (context, state) {
            return ScreenTypeLayout.builder(
              mobile: (p0) => WillPopScope(
                onWillPop: () async {
                  getIt<AdService>().getDifferenceTime();
                  return true;
                },
                child: Scaffold(
                  appBar: context.materialYouAppBar(
                    isAccountAddOrUpdate ? context.loc.addAccount : context.loc.updateAccount,
                    leadingWidget: GestureDetector(
                      onTap: () {
                        getIt<AdService>().getDifferenceTime();
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    actions: [
                      DeleteAccountWidget(accountId: widget.accountId),
                      IconButton(
                        onPressed: _showInfo,
                        icon: Icon(Icons.info_rounded),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: CardTypeButtons(),
                        ),
                        Form(
                          key: _form,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 16),
                                AccountCardHolderNameWidget(
                                  controller: accountHolderController,
                                ),
                                SizedBox(height: 16),
                                AccountNameWidget(
                                  controller: accountNameController,
                                ),
                                SizedBox(height: 16),
                                AccountInitialAmountWidget(
                                  controller: accountInitialAmountController,
                                ),
                                SizedBox(height: 16),
                                Builder(
                                  builder: (context) {
                                    if (state is UpdateCardTypeState && state.cardType == CardType.bank) {
                                      return AccountNumberWidget(
                                        controller: accountNumberController,
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                ),
                                SizedBox(height: 16),
                                AccountDefaultSwitchWidget(
                                  accountId: int.tryParse(widget.accountId ?? '') ?? -1,
                                ),
                                AccountColorPickerWidget()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: PaisaBigButton(
                        onPressed: () {
                          final isValid = _form.currentState!.validate();
                          if (!isValid) {
                            return;
                          }
                          BlocProvider.of<AccountBloc>(context).add(
                              AddOrUpdateAccountEvent(isAccountAddOrUpdate));
                        },
                        title: isAccountAddOrUpdate
                            ? context.loc.add
                            : context.loc.update,
                      ),
                    ),
                  ),
                ),
              ),
              tablet: (p0) => Scaffold(
                appBar: context.materialYouAppBar(
                  isAccountAddOrUpdate
                      ? context.loc.addAccount
                      : context.loc.updateAccount,
                  actions: [
                    IconButton(
                      onPressed: _showInfo,
                      icon: Icon(Icons.info_rounded,color: Colors.white,),
                    ),
                    DeleteAccountWidget(accountId: widget.accountId),
                    PaisaButton(
                      onPressed: () {
                        final isValid = _form.currentState!.validate();
                        if (!isValid) {
                          return;
                        }
                        BlocProvider.of<AccountBloc>(context)
                            .add(AddOrUpdateAccountEvent(isAccountAddOrUpdate));
                      },
                      title: isAccountAddOrUpdate
                          ? context.loc.add
                          : context.loc.update,
                    ),
                    SizedBox(width: 16),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Form(
                          key: _form,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CardTypeButtons(),
                                SizedBox(height: 16),
                                AccountCardHolderNameWidget(
                                  controller: accountHolderController,
                                ),
                                SizedBox(height: 16),
                                AccountNameWidget(
                                  controller: accountNameController,
                                ),
                                SizedBox(height: 16),
                                AccountInitialAmountWidget(
                                  controller: accountInitialAmountController,
                                ),
                                SizedBox(height: 16),
                                Builder(
                                  builder: (context) {
                                    if (state is UpdateCardTypeState &&
                                        state.cardType == CardType.bank) {
                                      return AccountNumberWidget(
                                        controller: accountNumberController,
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                ),
                                SizedBox(height: 16),
                                AccountDefaultSwitchWidget(
                                  accountId:
                                      int.tryParse(widget.accountId ?? '') ??
                                          -1,
                                ),
                                AccountColorPickerWidget()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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

class AccountColorPickerWidget extends StatelessWidget {
  AccountColorPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onTap: () async {
            final color = await paisaColorPicker(
              context,
              defaultColor:
                  BlocProvider.of<AccountBloc>(context).selectedColor ??
                      Colors.red.value,
            );
            if (context.mounted) {
              BlocProvider.of<AccountBloc>(context)
                  .add(AccountColorSelectedEvent(color));
            }
          },
          leading: Icon(
            Icons.color_lens,
            color: context.primary,
          ),
          title: Text(context.loc.pickColor),
          subtitle: Text(context.loc.pickColorDesc),
          trailing: Container(
            margin: EdgeInsets.only(right: 12),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(
                  BlocProvider.of<AccountBloc>(context).selectedColor ??
                      Colors.red.value),
            ),
          ),
        );
      },
    );
  }
}

class DeleteAccountWidget extends StatelessWidget {
  final String? accountId;

  DeleteAccountWidget({super.key, this.accountId});
  void onPressed(BuildContext context) {
    PaisaAlertDialog(
      context,
      title: Text(context.loc.dialogDeleteTitle),
      child: RichText(
        text: TextSpan(
          text: context.loc.deleteAccount,
          style: context.bodyMedium,
          children: [
            TextSpan(
              text: BlocProvider.of<AccountBloc>(context).accountName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      confirmationButton: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        onPressed: () {
          BlocProvider.of<AccountBloc>(context)
              .add(DeleteAccountEvent(accountId!));

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
    if (accountId == null) {
      return SizedBox.shrink();
    }
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

class AccountCardHolderNameWidget extends StatelessWidget {
  AccountCardHolderNameWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return PaisaTextFormField(
          controller: controller,
          hintText: context.loc.enterCardHolderName,
          keyboardType: TextInputType.name,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          onChanged: (value) =>
              BlocProvider.of<AccountBloc>(context).accountHolderName = value,
        );
      },
    );
  }
}

class AccountNameWidget extends StatelessWidget {
  AccountNameWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return PaisaTextFormField(
          controller: controller,
          hintText: context.loc.enterAccountName,
          keyboardType: TextInputType.name,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          onChanged: (value) =>
              BlocProvider.of<AccountBloc>(context).accountName = value,
        );
      },
    );
  }
}

class AccountNumberWidget extends StatelessWidget {
  AccountNumberWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PaisaTextFormField(
      maxLength: 4,
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      hintText: context.loc.enterNumberOptional,
      keyboardType: TextInputType.number,
      onChanged: (value) =>
          BlocProvider.of<AccountBloc>(context).accountNumber = value,
    );
  }
}

class AccountInitialAmountWidget extends StatelessWidget {
  AccountInitialAmountWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PaisaTextFormField(
      controller: controller,
      hintText: context.loc.enterAmount,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
        TextInputFormatter.withFunction((oldValue, newValue) {
          try {
            final text = newValue.text;
            if (text.isNotEmpty) double.parse(text);
            return newValue;
          } catch (_) {}
          return oldValue;
        }),
      ],
      onChanged: (value) {
        double? amount = double.tryParse(value);
        BlocProvider.of<AccountBloc>(context).initialAmount = amount;
      },
    );
  }
}

class AccountDefaultSwitchWidget extends StatefulWidget {
  AccountDefaultSwitchWidget({
    super.key,
    required this.accountId,
  });

  final int accountId;

  @override
  State<AccountDefaultSwitchWidget> createState() =>
      _AccountDefaultSwitchWidgetState();
}

class _AccountDefaultSwitchWidgetState extends State<AccountDefaultSwitchWidget> {
  late final SettingCubit settingCubit = BlocProvider.of<SettingCubit>(context);

  late bool isAccountDefault =
      settingCubit.defaultAccountId == widget.accountId;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      title: Text(context.loc.defaultAccount),
      value: isAccountDefault,
      onChanged: (value) {
        if (value) {
          settingCubit.setDefaultAccountId(widget.accountId);
        } else {
          settingCubit.setDefaultAccountId(-1);
        }
        setState(() {
          isAccountDefault = value;
        });
      },
    );
  }
}