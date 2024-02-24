import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../../../../app/core/app_storage_keys.dart';
import '../../../../data/api/end_points.dart';
import '../../../../data/error/api_error_handler.dart';
import '../../../../data/error/failures.dart';
import '../../../../main_repos/base_repo.dart';

class LoginRepo extends BaseRepo {
  LoginRepo({required super.sharedPreferences, required super.dioClient});

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

  saveUserData(Map<String, dynamic> json) {
    sharedPreferences.setBool(AppStorageKey.isLogin, true);
    sharedPreferences.setString(AppStorageKey.userId, json["id"].toString());
    sharedPreferences.setString(
        AppStorageKey.token, json["accessToken"].toString());
    sharedPreferences.setString(AppStorageKey.userData, jsonEncode(json));
    dioClient.updateHeader(token);
  }

  Future<Either<ServerFailure, Response>> logIn(
      Map<String, dynamic> data) async {
    try {
      data.addAll(
          {"fcm_token": (!kDebugMode) ? await saveDeviceToken() : "ffd"});

      Response response =
          await dioClient.post(uri: EndPoints.logIn, data: data);

      if (response.statusCode == 200) {
        if (response.data["data"]["email_verified_at"] != null) {
          saveUserData(response.data["data"] as Map<String, dynamic>);
        }
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }
}
