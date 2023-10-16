import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'constants.dart';
class FirebaseAdsCheck {
  final CollectionReference firestoreInstance =
      FirebaseFirestore.instance.collection('Data');
  final count = 0.obs;

  RxBool isAppOpenAds = false.obs;
  RxBool isBannerAds = false.obs;
  RxBool isInterstitialAds = false.obs;


  Future <void> firebaseData() async {
    await firestoreInstance.doc("paisa").get().then((event) {
      // you can access the values by


      isAppOpenAds.value = event['appOpen'];
      isBannerAds.value = event['bannerAds'];
      isInterstitialAds.value = event['interstitial'];


      print(isAppOpenAds.value);
      print(isBannerAds.value);
      print(isInterstitialAds.value);


    }).catchError((e) {



    });
    // Future.delayed(Duration(seconds: 3), () {
    //   Get.offAndToNamed(Routes.WELCOME);
    // });

  }

}
