import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/core/enum/calendar_formats.dart';
import 'package:paisa/core/widgets/choose_calendar_format_widget.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/settings/data/authenticate.dart';
import 'package:paisa/features/settings/presentation/widgets/accounts_style_widget.dart';
import 'package:paisa/features/settings/presentation/widgets/app_font_changer.dart';
import 'package:paisa/features/settings/presentation/widgets/app_language_changer.dart';
import 'package:paisa/features/settings/presentation/widgets/biometrics_auth_widget.dart';
import 'package:paisa/features/settings/presentation/widgets/country_change_widget.dart';
import 'package:paisa/features/settings/presentation/widgets/expense_fix_widget.dart';
import 'package:paisa/features/settings/presentation/widgets/setting_option.dart';
import 'package:paisa/features/settings/presentation/widgets/settings_group_card.dart';
import 'package:paisa/features/settings/presentation/widgets/small_size_fab_widget.dart';
import 'package:paisa/features/settings/presentation/widgets/version_widget.dart';
import 'package:paisa/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/color_constant.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    final currentTheme = ThemeMode.values[getIt
        .get<Box<dynamic>>(instanceName: BoxType.settings.name)
        .get(themeModeKey, defaultValue: 0)];
    final currentFormat = CalendarFormats.values[getIt
        .get<Box<dynamic>>(instanceName: BoxType.settings.name)
        .get(calendarFormatKey, defaultValue: 2)];
    return PaisaAnnotatedRegionWidget(
      color: Colors.transparent,
      child: Scaffold(
        appBar: context.materialYouAppBar(
          context.loc.settings,
        ),
        body: ListView(
          padding: EdgeInsets.only(bottom:MediaQuery.of(context).padding.bottom),
          shrinkWrap: true,
          children: [
            SettingsGroup(
              title: context.loc.colorsUI,
              options: [
                //  const SettingsColorPickerWidget(),
                // const Divider(),
                //  SettingsOption(
                //    icon: MdiIcons.brightness4,
                //    title: context.loc.chooseTheme,
                //    subtitle: currentTheme.themeName,
                //    onTap: () {
                //      showModalBottomSheet(
                //        constraints: BoxConstraints(
                //          maxWidth: MediaQuery.of(context).size.width >= 700
                //              ? 700
                //              : double.infinity,
                //        ),
                //        shape: const RoundedRectangleBorder(
                //          borderRadius: BorderRadius.only(
                //            topLeft: Radius.circular(16),
                //            topRight: Radius.circular(16),
                //          ),
                //        ),
                //        context: context,
                //        builder: (_) => ChooseThemeModeWidget(
                //          currentTheme: currentTheme,
                //        ),
                //      );
                //    },
                //  ),
                //  const Divider(),
                const AccountsStyleWidget(),

                const SmallSizeFabWidget(),
              ],
            ),
            SettingsGroup(
              title: context.loc.others,
              options: [
                BiometricAuthWidget(
                  authenticate: getIt.get<Authenticate>(),
                ),
                const AppLanguageChanger(),
                const CountryChangeWidget(),
                appTheme.SettingItem(
                  context.loc.calendarFormat,
                  currentFormat.exampleValue ?? "",
                  CalIcon,
                  SizedBox(),
                  () {
                    showModalBottomSheet(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width >= 700
                            ? 700
                            : double.infinity,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      context: context,
                      builder: (_) => ChooseCalendarFormatWidget(
                        currentFormat: currentFormat,
                      ),
                    );
                  },
                ),
                // const Divider(),
                // const AppFontChanger(),
                // const Divider(),
                const FixExpenseWidget(),
                appTheme.SettingItem(
                  context.loc.backupAndRestoreTitle,
                    "backup and restore your expenses\naccounts & categories",
                  BackupIcon,
                  SizedBox(),
                      () {
                        context.goNamed(exportAndImportName);
                  },
                ),
              ],
            ),
            SettingsGroup(
              title: context.loc.socialLinks,
              options: [
                appTheme.SettingItem(
                  context.loc.appRate,
                  "love this app? let us know how we \ncan make it better on the \ngoogle play store",
                  RateIcon,
                  SizedBox(),
                      () {
                        launchUrl(
                                Uri.parse(playStoreUrl),
                                mode: LaunchMode.externalApplication,
                              );
                  },
                ),
                appTheme.SettingItem(
                  context.loc.privacyPolicy,
                  "",
                  PrivIcon,
                  SizedBox(),
                      () {
                        launchUrl(
                          Uri.parse(termsAndConditionsUrl),
                          mode: LaunchMode.externalApplication,
                        );
                  },
                ),
                // SettingsOption(
                //   icon: MdiIcons.glassMugVariant,
                //   title: context.loc.supportMe,
                //   subtitle: "love this app? let us know how we \ncan make it better on the google play store",
                //   onTap: () => launchUrl(
                //     Uri.parse(buyMeCoffeeUrl),
                //     mode: LaunchMode.externalApplication,
                //   ),
                // ),
                // const Divider(),
                // SettingsOption(
                //   icon: MdiIcons.star,
                //   title: context.loc.appRate,
                //   subtitle: context.loc.appRateDesc,
                //   onTap: () => launchUrl(
                //     Uri.parse(playStoreUrl),
                //     mode: LaunchMode.externalApplication,
                //   ),
                // ),
                // const Divider(),
                // SettingsOption(
                //   icon: MdiIcons.github,
                //   title: context.loc.github,
                //   subtitle: context.loc.githubText,
                //   onTap: () => launchUrl(
                //     Uri.parse(gitHubUrl),
                //     mode: LaunchMode.externalApplication,
                //   ),
                // ),
                // const Divider(),
                // SettingsOption(
                //   icon: MdiIcons.send,
                //   title: context.loc.telegram,
                //   subtitle: context.loc.telegramGroup,
                //   onTap: () => launchUrl(
                //     Uri.parse(telegramGroupUrl),
                //     mode: LaunchMode.externalApplication,
                //   ),
                // ),
                // const Divider(),
                // SettingsOption(
                //   icon: MdiIcons.note,
                //   title: context.loc.privacyPolicy,
                //   onTap: () => launchUrl(
                //     Uri.parse(termsAndConditionsUrl),
                //     mode: LaunchMode.externalApplication,
                //   ),
                // ),
                // const Divider(),
                const VersionWidget(),
              ],
            ),
            // SafeArea(
            //   top: false,
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Text(
            //       context.loc.madeWithLoveInIndia,
            //     ),
            //   ),
            // ),
Spacing.height(15)
          ],
        ),
      ),
    );
  }
}
