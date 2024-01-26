import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:stepOut/app/core/app_strings.dart';
import '../../../../app/core/app_storage_keys.dart';
import '../../../../data/api/end_points.dart';
import '../../../../data/error/api_error_handler.dart';
import '../../../../data/error/failures.dart';
import '../../../../main_repos/base_repo.dart';

class LoginRepo extends BaseRepo {
  LoginRepo({required super.sharedPreferences, required super.dioClient});

  setLoggedIn() {
    removeGuestMode();
    subscribeToTopic();
    sharedPreferences.setBool(AppStorageKey.isLogin, true);
  }

  saveToken(token) {
    sharedPreferences.setString(AppStorageKey.token, token);
    dioClient.updateHeader(token);
  }

  getCredentials() {
    if (sharedPreferences.containsKey(AppStorageKey.credentials)) {
      return jsonDecode(sharedPreferences.getString(
            AppStorageKey.credentials,
          ) ??
          "{}");
    }
  }

  saveCredentials(credentials) {
    sharedPreferences.setString(
        AppStorageKey.credentials, jsonEncode(credentials));
  }

  forgetCredentials() {
    sharedPreferences.remove(AppStorageKey.credentials);
  }

  Future<String?> saveDeviceToken() async {
    String? deviceToken;
    // if (Platform.isIOS) {
    //   deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    // } else {
    deviceToken = await FirebaseMessaging.instance.getToken();
    // }

    if (deviceToken != null) {
      log('--------Device Token---------- $deviceToken');
    }
    return deviceToken;
  }

  Future subscribeToTopic() async {
    await FirebaseMessaging.instance
        .subscribeToTopic(userId)
        .then((v) async {
      await sharedPreferences.setBool(AppStorageKey.isSubscribe, true);
    });
  }

  Future unSubscribeToTopic() async {
    await FirebaseMessaging.instance
        .unsubscribeFromTopic(userId)
        .then((v) async {
      await sharedPreferences.remove(AppStorageKey.isSubscribe);
    });
  }

  setUserData(json) {
    sharedPreferences.setString(AppStorageKey.userData, jsonEncode(json));
  }

  Future<Either<ServerFailure, Response>> logIn(
      Map<String, dynamic> data) async {
    try {
      data.addAll({if (!kDebugMode) "fcm_token": await saveDeviceToken()});

      Response response =
          await dioClient.post(uri: EndPoints.logIn, data: data);

      if (response.statusCode == 200) {
        if (response.data['data']["is_verify"] == true) {
          setUserData(response.data["data"]);
          saveToken(response.data['data']["token"]);
        }
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> register(data) async {
    try {
      Response response =
          await dioClient.post(uri: EndPoints.register, data: data);

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<bool> logOut() async {
    await unSubscribeToTopic();

    if (sharedPreferences.containsKey(AppStorageKey.isSubscribe)) {
      return false;
    } else {
      await sharedPreferences.remove(AppStorageKey.token);
      await sharedPreferences.remove(AppStorageKey.isLogin);
      return true;
    }
  }

  removeGuestMode() async {
    await FirebaseMessaging.instance
        .unsubscribeFromTopic(AppStrings.guestTopic);
  }
}
