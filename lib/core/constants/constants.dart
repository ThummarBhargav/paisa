import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../main.dart';
import 'firebaseAdsCheck.dart';

const gitHubUrl = 'https://github.com/h4h13/paisa';
const playStoreUrl =
    'https://play.google.com/store/apps/details?id=com.mobileappxperts.incomeexpense.moneytracker';
const telegramGroupUrl = 'https://t.me/app_paisa';
const termsAndConditionsUrl =
    'https://sites.google.com/view/mobapp-privacy-policy/policy';

const String themeModeKey = 'key_theme_mode';
const String appColorKey = 'key_app_color';
const String dynamicThemeKey = 'key_dynamic_color';
const String biometricKey = 'key_biometric';
const String userNameKey = 'user_name_key';
const String userIntroKey = 'user_intro_key';
const String userImageKey = 'user_image_key';
const String userCategorySelectorKey = 'user_category_selector_key';
const String userAccountSelectorKey = 'user_account_selector_key';
const String userAuthKey = 'user_auth_key';
const String userAccountsStyleKey = 'user_accounts_style_key';
const String smallSizeFabKey = 'user_small_size_fab_key';
const String userLanguageKey = 'user_language_key';
const String userCountryKey = 'user_country_key';
const String userCustomCurrencyLeftOrRightKey =
    'user_custom_currency_let_or_right_key';
const String scheduleTime = 'schedule_time_key';
const String fontFamilyName = 'Material Design Icons';
const String fontFamilyPackageName = 'material_design_icons_flutter';
const String selectedFilterExpenseKey = "selected_filter_expense_key";
const String selectedHomeFilterExpenseKey = "selected_home_filter_expense_key";
const String defaultAccountIdKey = "default_account_id_key";
const String calendarFormatKey = "calendar_format_key";
const String appLanguageKey = "app_language_key";
const String appFontChangerKey = "app_font_changer_key";
const buyMeCoffeeUrl = 'https://www.buymeacoffee.com/h4h13';

const loginPath = '/login';
const loginName = 'login';

const countrySelectorPath = '/country-selector';
const countrySelectorName = 'country-selector';

const biometricPath = '/biometric';
const biometricName = 'biometric';

const landingPath = '/landing';
const landingName = 'landing';

const searchPath = 'search';
const searchName = 'search';

const addTransactionPath = 'add-transaction';
const addTransactionsName = 'add-transaction';

const editTransactionsName = 'edit-transaction';
const editTransactionsPath = 'edit-transaction/:eid';

const addCategoryPath = 'add-category';
const addCategoryName = 'add-category';

const manageCategoriesPath = 'categories';
const manageCategoriesName = 'categories';

const editCategoryPath = 'edit-category/:cid';
const editCategoryName = 'edit-category';

const addAccountPath = 'add-account';
const addAccountName = 'add-account';

const editAccountPath = 'edit-account/:aid';
const editAccountName = 'edit-account';

const editAccountWithIdPath = 'edit';
const editAccountWithIdName = 'edit';

const addAccountWithIdPath = 'add';
const addAccountWithIdName = 'add';

const accountTransactionPath = 'account-transaction/:aid';
const accountTransactionName = 'account-transaction';

const expensesByCategoryName = 'expenses-by-category';
const expensesByCategoryPath = 'expenses-by-category/:cid';

const exportAndImportName = 'import-export';
const exportAndImportPath = 'import-export';

const fontPickerName = 'font-picker';
const fontPickerPath = 'font-picker';

const recurringTransactionsName = 'recurring';
const recurringTransactionsPath = 'recurring';

const recurringName = 'add-recurring';
const recurringPath = 'add-recurring';

const settingsPath = 'settings';
const settingsName = 'settings';

const debtAddOrEditName = 'edit-debt';
const debtAddOrEditPath = 'edit-debt/:did';

const addDebitName = 'add-debit';
const addDebitPath = 'add-debit';

const introPageName = 'intro';
const introPagePath = '/intro';

const categorySelectorName = 'category-selector';
const categorySelectorPath = '/category-selector';

const accountSelectorName = 'account-selector';
const accountSelectorPath = '/account-selector';

const iconPickerName = 'icon-picker';
const iconPickerPath = 'icon-picker';
const isStartTime = "isStartTime";

const userOnboardingName = 'onboarding';
const userOnboardingPath = '/onboarding';
const screenWidth = '/onboarding';

const AcStyle = 'assets/images/AcStyle.png';
const ScaleIcon = 'assets/images/ScaleIcon.png';
const CurrencyIcon = 'assets/images/CurrencyIcon.png';
const CalIcon = 'assets/images/cal.png';
const FixIcon = 'assets/images/Fix.png';
const BackupIcon = 'assets/images/Backup.png';
const RateIcon = 'assets/images/rate.png';
const PrivIcon = 'assets/images/priv.png';
const VerIcon = 'assets/images/ver.png';
const FingIcon = 'assets/images/fing.png';

const isBannerAds = "isBannerAds";
const isAllAds = "isAllAds";
const isAppOpen = "isAppOpen";
const isInterstitial = "isInterstitial";

//Android Test
const BannerTestId_Android = "ca-app-pub-3940256099942544/6300978111";
const InterstitialTestId_Android = "ca-app-pub-3940256099942544/1033173712";
const AppOpenTestId_Android = "ca-app-pub-3940256099942544/3419835294";

//Android Live
const BannerLiveId_Android = "ca-app-pub-8608272927918158/2494618665";
const InterstitialLiveId_Android = "ca-app-pub-8608272927918158/3275586984";
const AppOpenLiveId_Android = "ca-app-pub-8608272927918158/2721053218";

//Ios Test
const BannerTestId_Ios = "ca-app-pub-3940256099942544/2934735716";
const InterstitialTestId_Ios = "ca-app-pub-3940256099942544/4411468910";
const AppOpenTestId_Ios = "ca-app-pub-3940256099942544/5662855259";

//Ios Live
const BannerLiveId_Ios = "ca-app-pub-8608272927918158/1718978640";
const InterstitialLiveId_Ios = "ca-app-pub-8608272927918158/8420102450";
const AppOpenLiveId_Ios = "ca-app-pub-8608272927918158/7746945345";

const List<String> iconListSelected = [
  "assets/images/homeS.png",
  "assets/images/accountsS.png",
  "assets/images/debtsS.png",
  "assets/images/overviewS.png",
  "assets/images/categoriesS.png",
  "assets/images/budgetS.png",
  "assets/images/recurringS.png",
  "assets/images/settingsS.png",
];
const List<String> iconList = [
  "assets/images/home.png",
  "assets/images/accounts.png",
  "assets/images/debts.png",
  "assets/images/overview.png",
  "assets/images/categories.png",
  "assets/images/budget.png",
  "assets/images/recurring.png",
  "assets/images/settings.png",
];
const List<String> iconListName = [
  "Home",
  "Accounts",
  "Debts",
  "Overview",
  "Categories",
  "Budget",
  "Recurring",
  "Settings",
];

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}

bool getDifferenceTime() {
  if (!isNullEmptyOrFalse(box.read(isStartTime).toString())) {
    String startTime = box.read(isStartTime).toString();
    String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    int difference = int.parse(currentTime) - int.parse(startTime);
    int differenceTime = difference ~/ 1000;
    if (differenceTime > 30) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

showAdsDifferenceTime() {
  if (box.read(isStartTime) != null) {
    String startTime = box.read(isStartTime).toString();
    String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    int difference = int.parse(currentTime) - int.parse(startTime);
    print("Difference := $difference");
    print("StartTime := $startTime");
    print("currentDate := $currentTime");
    int differenceTime = difference ~/ 1000;
    if (differenceTime > 30) {
      showInterstitialAd();
    }
  }
}

AnchoredAdaptiveBannerAdSize? size;
BannerAd? bannerAd;
bool isBannerLoaded = false;
InterstitialAd? interstitialAds;

initBannerAds() async {
  if (getIt<FirebaseAdsCheck>().isBannerAds.value) {
    size = await anchoredAdaptiveBannerAdSize();
    bannerAd = BannerAd(
        size: size!,
        adUnitId: BannerID(),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            isBannerLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: const AdRequest())
      ..load();
  }
}

Widget getBannerAds() {
  return SizedBox(
    width: size!.width.toDouble(),
    height: size!.height.toDouble(),
    child: bannerAd != null ? AdWidget(ad: bannerAd!) : const SizedBox(),
  );
}

showInterstitialAd() async {
  if (getIt<FirebaseAdsCheck>().isInterstitialAds.value) {
    if (interStitialAdRunning) {
      interstitialAds?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          interStitialAdIsShow = true;
        },
        onAdDismissedFullScreenContent: (ad) {
          box.write(
              isStartTime, DateTime.now().millisecondsSinceEpoch.toString());
          interstitialAds?.dispose();
          interStitialAdIsShow = false;
          interStitialAdRunning = false;
          loadInterstitialAd(); // Preload the next ad
          print('Ad dismissed fullscreen content.');
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          interStitialAdRunning = false;
          print('Ad failed to show fullscreen content: $error');
        },
      );
      interstitialAds?.show();
    } else {
      print('Interstitial ad is not loaded yet.');
      loadInterstitialAd(); // Load a new ad if not already loaded
    }
  }
}

loadInterstitialAd() async {
  InterstitialAd.load(
    adUnitId: InterstitialID(),
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad) {
        interstitialAds = ad;
        interStitialAdRunning = true;
      },
      onAdFailedToLoad: (error) {
        interStitialAdRunning = false;
        print('InterstitialAd failed to load: $error');
      },
    ),
  );
}

String BannerID() {
  if (Platform.isAndroid) {
    if (kDebugMode) {
      return BannerTestId_Android;
    } else {
      return BannerLiveId_Android;
    }
  } else if (Platform.isIOS) {
    if (kDebugMode) {
      return BannerTestId_Ios;
    } else {
      return BannerLiveId_Ios;
    }
  }
  return BannerTestId_Android;
}

String InterstitialID() {
  if (Platform.isAndroid) {
    if (kDebugMode) {
      return InterstitialTestId_Android;
    } else {
      return InterstitialLiveId_Android;
    }
  } else if (Platform.isIOS) {
    if (kDebugMode) {
      return InterstitialTestId_Ios;
    } else {
      return InterstitialLiveId_Ios;
    }
  }
  return InterstitialTestId_Android;
}

String AppOpenID() {
  if (Platform.isAndroid) {
    if (kDebugMode) {
      return AppOpenTestId_Android;
    } else {
      return AppOpenLiveId_Android;
    }
  } else if (Platform.isIOS) {
    if (kDebugMode) {
      return AppOpenTestId_Ios;
    } else {
      return AppOpenLiveId_Ios;
    }
  }
  return AppOpenTestId_Ios;
}

Future<AnchoredAdaptiveBannerAdSize?> anchoredAdaptiveBannerAdSize() async {
  // Used to set size of adaptive banner ad according to device width and orientation.
  return await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      box.read(screenWidth));
}
