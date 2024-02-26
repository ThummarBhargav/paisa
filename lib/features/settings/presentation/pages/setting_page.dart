import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/core/AdsManager/ad_services.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/core/enum/calendar_formats.dart';
import 'package:paisa/core/widgets/choose_calendar_format_widget.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:paisa/features/settings/presentation/widgets/accounts_style_widget.dart';
import 'package:paisa/features/settings/presentation/widgets/country_change_widget.dart';
import 'package:paisa/features/settings/presentation/widgets/expense_fix_widget.dart';
import 'package:paisa/features/settings/presentation/widgets/settings_group_card.dart';
import 'package:paisa/features/settings/presentation/widgets/small_size_fab_widget.dart';
import 'package:paisa/features/settings/presentation/widgets/version_widget.dart';
import 'package:paisa/main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/color_constant.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    final currentFormat = CalendarFormats.values[getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name).get(calendarFormatKey, defaultValue: 2)];
    return WillPopScope(
      onWillPop: () async {
        if(getIt<AdService>().bannerAd!=null){
          await getIt<AdService>().bannerAd!.dispose();
          await getIt<AdService>().initBannerAds(context);
        }
        getIt<AdService>().getDifferenceTime();
        return await true;
      },
      child: PaisaAnnotatedRegionWidget(
        color: Colors.transparent,
        child: Scaffold(
          appBar: context.materialYouAppBar(
            context.loc.settings,
            leadingWidget: InkWell(
              onTap: () async {
                if(getIt<AdService>().bannerAd!=null) {
                  await getIt<AdService>().bannerAd!.dispose();
                  await getIt<AdService>().initBannerAds(context);
                }
                getIt<AdService>().getDifferenceTime();
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.only(bottom:MediaQuery.of(context).padding.bottom),
            shrinkWrap: true,
            children: [
              SettingsGroup(
                title: context.loc.colorsUI,
                options: [
                  AccountsStyleWidget(),
                  SmallSizeFabWidget(),
                ],
              ),
              SettingsGroup(
                title: context.loc.others,
                options: [
                  CountryChangeWidget(),
                  appTheme.SettingItem(context.loc.calendarFormat, currentFormat.exampleValue, CalIcon, SizedBox(), () {
                    showModalBottomSheet(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width >= 700 ? 700 : double.infinity,
                        ),
                      shape: RoundedRectangleBorder(
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
                  FixExpenseWidget(),
                  appTheme.SettingItem(context.loc.backupAndRestoreTitle, "backup and restore your expenses\naccounts & categories", BackupIcon, SizedBox(), () {
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
                  // Divider(),
                  // SettingsOption(
                  //   icon: MdiIcons.star,
                  //   title: context.loc.appRate,
                  //   subtitle: context.loc.appRateDesc,
                  //   onTap: () => launchUrl(
                  //     Uri.parse(playStoreUrl),
                  //     mode: LaunchMode.externalApplication,
                  //   ),
                  // ),
                  // Divider(),
                  // SettingsOption(
                  //   icon: MdiIcons.github,
                  //   title: context.loc.github,
                  //   subtitle: context.loc.githubText,
                  //   onTap: () => launchUrl(
                  //     Uri.parse(gitHubUrl),
                  //     mode: LaunchMode.externalApplication,
                  //   ),
                  // ),
                  // Divider(),
                  // SettingsOption(
                  //   icon: MdiIcons.send,
                  //   title: context.loc.telegram,
                  //   subtitle: context.loc.telegramGroup,
                  //   onTap: () => launchUrl(
                  //     Uri.parse(telegramGroupUrl),
                  //     mode: LaunchMode.externalApplication,
                  //   ),
                  // ),
                  // Divider(),
                  // SettingsOption(
                  //   icon: MdiIcons.note,
                  //   title: context.loc.privacyPolicy,
                  //   onTap: () => launchUrl(
                  //     Uri.parse(termsAndConditionsUrl),
                  //     mode: LaunchMode.externalApplication,
                  //   ),
                  // ),
                  // Divider(),
                  VersionWidget(),
                ],
              ),
              Spacing.height(15),
            ],
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Obx(() => banner.value==true
                ? getIt<AdService>().isBannerLoaded.isTrue
                ? getIt<AdService>().getBannerAds()
                : SizedBox()
                : SizedBox()),
          ),
        ),
      ),
    );
  }
}