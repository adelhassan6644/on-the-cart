import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../app/core/app_storage_keys.dart';
import '../../../app/core/app_strings.dart';
import '../../../main_repos/base_repo.dart';

class SplashRepo extends BaseRepo {
  SplashRepo({required super.sharedPreferences, required super.dioClient});

  bool get isLogin => sharedPreferences.containsKey(AppStorageKey.isLogin);

  bool get isFirstTime =>
      !sharedPreferences.containsKey(AppStorageKey.notFirstTime);

  setFirstTime() {
    sharedPreferences.setBool(AppStorageKey.notFirstTime, true);
  }

  guestMode() async {
    await FirebaseMessaging.instance.subscribeToTopic(AppStrings.guestTopic);
  }
}
