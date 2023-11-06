import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/app.dart';
import 'package:paisa/core/enum/box_types.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:paisa/di/di.dart';
import 'package:paisa/features/recurring/domain/repository/recurring_repository.dart';

import 'core/constants/constants.dart';
import 'core/constants/firebaseAdsCheck.dart';
import 'firebase_options.dart';

final getIt = GetIt.instance;
GetStorage box = GetStorage();
bool interStitialAdRunning = false;
bool interStitialAdIsShow = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
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
      testDeviceIds: [/*"4796378E2BBA42CC7D1DE7367E50828B"*/]));
  await configInjector(getIt);
  getIt.get<RecurringRepository>().checkForRecurring();
  final Box<dynamic> settings =
      getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);
  getIt.registerSingleton<FirebaseAdsCheck>(FirebaseAdsCheck());
  await getIt<FirebaseAdsCheck>().firebaseData();
  if (isNullEmptyOrFalse(box.read(isStartTime))) {
    box.write(isStartTime, 0); // getIt<TimerService>().verifyTimer();
  }
  runApp(PaisaApp(settings: settings));
}
