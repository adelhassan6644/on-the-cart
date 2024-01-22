import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stepOut/main_repos/base_repo.dart';

import '../../../app/core/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class ProfileRepo extends BaseRepo {
  ProfileRepo({required super.dioClient, required super.sharedPreferences});

  String? get userName => sharedPreferences.getString(AppStorageKey.userName);

  bool get isLogin => sharedPreferences.containsKey(AppStorageKey.isLogin);

  Future<Either<ServerFailure, Response>> getProfile() async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.getProfile,
      );
      if (response.statusCode == 200) {
        setUserData(response.data["data"]);
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  setUserData(json) {
    sharedPreferences.setString(AppStorageKey.userData, jsonEncode(json));
  }

  Future<Either<ServerFailure, Response>> deleteAcc() async {
    try {
      Response response = await dioClient.post(
        uri: EndPoints.deleteProfile,
      );
      if (response.statusCode == 200) {
        await clearCache();
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  clearCache() async {
    await unSubscribeToTopic();

    if (sharedPreferences.containsKey(AppStorageKey.isSubscribe)) {
      await unSubscribeToTopic();
    } else {
      await sharedPreferences.remove(AppStorageKey.userName);
      await sharedPreferences.remove(AppStorageKey.userData);
      await sharedPreferences.remove(AppStorageKey.token);
      await sharedPreferences.remove(AppStorageKey.isLogin);
      return;
    }
  }

  Future unSubscribeToTopic() async {
    await FirebaseMessaging.instance
        .unsubscribeFromTopic("$userName")
        .then((v) async {
      await sharedPreferences.remove(AppStorageKey.isSubscribe);
    });
  }
}
