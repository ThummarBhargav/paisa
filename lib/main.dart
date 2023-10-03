import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/app.dart';
import 'package:paisa/core/enum/box_types.dart';
import 'package:paisa/di/di.dart';
import 'package:paisa/features/recurring/domain/repository/recurring_repository.dart';

import 'core/constants/constants.dart';

final getIt = GetIt.instance;
GetStorage box = GetStorage();
bool interStitialAdRunning = false;
Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: ["4796378E2BBA42CC7D1DE7367E50828B"]));
  await configInjector(getIt);
  getIt.get<RecurringRepository>().checkForRecurring();
  final Box<dynamic> settings =
      getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);
  if (isNullEmptyOrFalse(box.read(isStartTime))) {
    box.write(isStartTime, 0); // getIt<TimerService>().verifyTimer();
  }
  runApp(PaisaApp(settings: settings));
}
