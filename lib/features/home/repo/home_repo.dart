import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stepOut/main_repos/base_repo.dart';
import '../../../app/core/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class HomeRepo extends BaseRepo {
  HomeRepo({required super.dioClient, required super.sharedPreferences});

  String get userId => sharedPreferences.getString(AppStorageKey.token) ?? "";

  bool get isLogin => sharedPreferences.containsKey(AppStorageKey.isLogin);

  Future<Either<ServerFailure, Response>> getHomeAds() async {
    try {
      Response response = await dioClient.get(uri: EndPoints.ads);
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }
}
