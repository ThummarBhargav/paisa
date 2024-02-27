import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdpr_dialog/gdpr_dialog.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/app.dart';
import 'package:paisa/core/FirebaseDatabase_controller.dart';
import 'package:paisa/core/constants/constants.dart';
import 'package:paisa/core/enum/box_types.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:paisa/di/di.dart';
import 'package:paisa/features/recurring/domain/repository/recurring_repository.dart';
import 'core/app_module.dart';
import 'firebase_options.dart';

RxBool appOpen = false.obs;
RxBool banner = false.obs;
RxBool interstitial = false.obs;
bool appOpenAdRunning = false;
RxBool interStitialAdRunning = false.obs;
RxString AppOpenID = "".obs;
RxString BannerID = "".obs;
RxString InterstitialID = "".obs;
RxInt interShowTime = 0.obs;
RxInt appOpenShowTime = 0.obs;
RxBool adaptiveBannerSize = false.obs;

final getIt = GetIt.instance;
GetStorage box = GetStorage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await GetStorage.init();
  FirebaseDatabaseHelper().adsVisible();
  setUp();
  WidgetsFlutterBinding.ensureInitialized();
  await GdprDialog.instance.showDialog(isForTest: false, testDeviceId: '').then((onValue) {
    print('result === $onValue');
  });
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("a56b8f66-9401-4683-a057-d898aa474783");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {
    print(event.notification.body);
    event.complete(event.notification);
  });
  await MobileAds.instance.initialize();
  await MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: (kReleaseMode) ? [] : [
        "E132702A0BCE9312E7EFAA26C6396860",
      ],
  ));
  await configInjector(getIt);
  getIt.get<RecurringRepository>().checkForRecurring();
  final Box<dynamic> settings = getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);
  if (isNullEmptyOrFalse(box.read(ArgumentConstant.isStartTime))) {
    box.write(ArgumentConstant.isStartTime, 0);
  }
  if (isNullEmptyOrFalse(box.read(ArgumentConstant.isAppOpenStartTime))) {
    box.write(ArgumentConstant.isAppOpenStartTime, 0);
  }
  runApp(
    Home(settings),
  );
}

//ignore: must_be_immutable
class Home extends StatefulWidget {
  Box<dynamic> settings;
  Home(this.settings);

  @override State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const platform = MethodChannel('samples.flutter.dev/firebase');
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        await platform.invokeMethod('setId').then((value) async {
          if (value == "Success") {
            await MobileAds.instance.initialize();
            MobileAds.instance.updateRequestConfiguration(
              RequestConfiguration(
                tagForChildDirectedTreatment:
                TagForChildDirectedTreatment.unspecified,
                testDeviceIds: kDebugMode
                    ? [
                  "921ECDEF8D5D6B5B6CD6F3BC93FF97D7",
                ]
                    : [],
              ),
            );
          }
        });
      } on PlatformException catch (e) {
        print(e);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Money tracker (Paisa) App",
      debugShowCheckedModeBanner: false,
      home: PaisaApp(settings: widget.settings),
    );
  }
}