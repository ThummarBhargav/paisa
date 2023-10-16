import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/config/routes.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/core/enum/card_type.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/account/data/data_sources/default_account.dart';
import 'package:paisa/features/account/data/data_sources/local/account_data_manager.dart';
import 'package:paisa/features/account/data/model/account_model.dart';
import 'package:paisa/main.dart';

import 'package:responsive_builder/responsive_builder.dart';

class AccountSelectorPage extends StatefulWidget {
  const AccountSelectorPage({super.key});

  @override
  State<AccountSelectorPage> createState() => _AccountSelectorPageState();
}

class _AccountSelectorPageState extends State<AccountSelectorPage> {
  final LocalAccountManager dataSource = getIt.get();
  final List<AccountModel> defaultModels = defaultAccountsData();

  Future<void> saveAndNavigate() async {
    await settings.put(userAccountSelectorKey, false);
    if (mounted) {
      context.go(countrySelectorPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: Scaffold(
        appBar: context.materialYouAppBar(
          context.loc.accounts,
          actions: [
            InkWell(
                onTap: saveAndNavigate,
                child: Center(
                    child: Text(
                      "Next",
                      style: appTheme.normalText(20),
                    ))),

            const SizedBox(width: 16)
          ],
        ),
        body: ValueListenableBuilder<Box<AccountModel>>(
          valueListenable: getIt.get<Box<AccountModel>>().listenable(),
          builder: (context, value, child) {
            final List<AccountModel> categoryModels = value.values.toList();
            return ListView(
              children: [
                Visibility(
                  visible: categoryModels.length>0,
                  child: ListTile(
                    title: Text(
                      context.loc.addedAccounts,
                      style: context.titleMedium,
                    ),
                  ),
                ),
                // ScreenTypeLayout.builder(
                //   mobile: (p0) => ListView.separated(
                //     separatorBuilder: (context, index) => const SizedBox(),
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: categoryModels.length,
                //     shrinkWrap: true,
                //     itemBuilder: (context, index) {
                //       final AccountModel model = categoryModels[index];
                //       return AccountItemWidget(
                //         model: model,
                //         onPress: () async {
                //           await model.delete();
                //           defaultModels.add(model);
                //         },
                //       );
                //     },
                //   ),
                //   tablet: (p0) => GridView.builder(
                //     padding: const EdgeInsets.symmetric(horizontal: 8),
                //     gridDelegate:
                //         const SliverGridDelegateWithMaxCrossAxisExtent(
                //       maxCrossAxisExtent: 200,
                //       childAspectRatio: 2,
                //     ),
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: categoryModels.length,
                //     shrinkWrap: true,
                //     itemBuilder: (context, index) {
                //       final AccountModel model = categoryModels[index];
                //       return AccountItemWidget(
                //         model: model,
                //         onPress: () async {
                //           await model.delete();
                //           defaultModels.add(model);
                //         },
                //       );
                //     },
                //   ),
                // ),
                ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categoryModels.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final AccountModel model = categoryModels[index];
                    return AccountItemWidget(
                      model: model,
                      onPress: () async {
                        await model.delete();
                        defaultModels.add(model);
                      },
                    );
                  },
                ),
                Visibility(
                  visible: defaultModels.isNotEmpty,
                  child: ListTile(
                    title: Text(
                      context.loc.defaultAccounts,
                      style: context.titleMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: defaultModels
                        .map((model) => FilterChip(
                      backgroundColor: Color(model.color?? context.primary.value).withOpacity(0.3),
                              onSelected: (value) {
                                dataSource.add(model
                                  ..name = settings.get(
                                    userNameKey,
                                    defaultValue: model.name,
                                  ));
                                setState(() {
                                  defaultModels.remove(model);
                                });
                              },

                              shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(28),
                                side: BorderSide(
                                  width: 1,
                                  color:Color(model.color?? context.primary.value),
                                ),
                              ),
                              showCheckmark: false,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              label: Text(model.bankName ?? '',style: appTheme.normalText(15,Colors.black),),
                              labelStyle: context.titleMedium,
                              padding: const EdgeInsets.all(12),
                              avatar: Icon(
                                model.cardType!.icon,
                                color: Color(model.color?? context.primary.value)
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class AccountItemWidget extends StatelessWidget {
  const AccountItemWidget({
    super.key,
    required this.model,
    required this.onPress,
  });

  final AccountModel model;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MySize.getWidth(345),
        height: MySize.getHeight(60),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 25,
              offset: Offset(0, 0),
              spreadRadius: 1,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    width: MySize.getWidth(35.14),
                    height: MySize.getWidth(35),
                    decoration: ShapeDecoration(
                      color: Color(model.color ?? Colors.brown.shade200.value)
                          .withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 3,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color:
                          Color(model.color ?? Colors.brown.shade200.value)
                              .withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Icon(
                      model.cardType!.icon,
                      color: Color(model.color ?? Colors.brown.shade200.value),
                    ),
                  ),
                ),
                Spacing.width(15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.name ?? '',
                      style: appTheme.normalText(15, Colors.black),
                    ),
                    Text(
                      model.bankName ?? '',
                      style: appTheme.normalText(13, Colors.grey),
                    ),
                  ],
                ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(onTap: onPress, child: Icon(Icons.delete)),
            ),
          ],
        ),
      ),
    );
  }
}
