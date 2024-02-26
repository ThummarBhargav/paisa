import 'package:paisa/main.dart';
import 'AdsManager/ad_services.dart';

void setUp() {
  getIt.registerSingleton<AdService>(AdService());
}