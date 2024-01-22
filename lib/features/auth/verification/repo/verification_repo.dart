import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stepOut/app/core/app_strings.dart';
import 'package:stepOut/features/auth/verification/model/verification_model.dart';
import '../../../../app/core/app_storage_keys.dart';
import '../../../../data/api/end_points.dart';
import '../../../../data/error/api_error_handler.dart';
import '../../../../data/error/failures.dart';
import '../../../../main_repos/base_repo.dart';

class VerificationRepo extends BaseRepo {
  VerificationRepo(
      {required super.sharedPreferences, required super.dioClient});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  String? get userId => sharedPreferences.getString(AppStorageKey.token);

  setLoggedIn() {
    removeGuestMode();
    subscribeToTopic();
    sharedPreferences.setBool(AppStorageKey.isLogin, true);
  }

  saveUserToken(token) {
    sharedPreferences.setString(AppStorageKey.token, token.toString());
    dioClient.updateHeader(token);
    setLoggedIn();
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

  forget() {
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
        .subscribeToTopic("$userId")
        .then((v) async {
      await sharedPreferences.setBool(AppStorageKey.isSubscribe, true);
    });
  }

  Future unSubscribeToTopic() async {
    await FirebaseMessaging.instance
        .unsubscribeFromTopic("$userId")
        .then((v) async {
      await sharedPreferences.remove(AppStorageKey.isSubscribe);
    });
  }

  Future<Either<ServerFailure, Response>> resendCode(
      VerificationModel model) async {
    try {
      Response response = await dioClient.post(
        uri: model.fromRegister ? EndPoints.resend : EndPoints.forgetPassword,
        data: {
          "email": model.email,
        },
      );

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> verifyMail(
      VerificationModel model) async {
    try {
      Response response = await dioClient.post(
          uri: model.fromRegister
              ? EndPoints.verifyEmail
              : EndPoints.checkMailForResetPassword,
          data: model.toJson());
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  removeGuestMode() async {
    await FirebaseMessaging.instance
        .unsubscribeFromTopic(AppStrings.guestTopic);
  }
}
