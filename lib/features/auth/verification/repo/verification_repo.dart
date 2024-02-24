import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stepOut/features/auth/verification/model/verification_model.dart';
import '../../../../app/core/app_storage_keys.dart';
import '../../../../data/api/end_points.dart';
import '../../../../data/error/api_error_handler.dart';
import '../../../../data/error/failures.dart';
import '../../../../main_repos/base_repo.dart';

class VerificationRepo extends BaseRepo {
  VerificationRepo(
      {required super.sharedPreferences, required super.dioClient});

  saveUserData(Map<String, dynamic> json) {
    sharedPreferences.setBool(AppStorageKey.isLogin, true);
    sharedPreferences.setString(AppStorageKey.userId, json["id"].toString());
    sharedPreferences.setString(
        AppStorageKey.token, json["accessToken"].toString());
    sharedPreferences.setString(AppStorageKey.userData, jsonEncode(json));
    dioClient.updateHeader(token);
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
        if (model.fromRegister) {
          saveUserData(response.data["data"]);
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
