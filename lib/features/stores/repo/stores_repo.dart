import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stepOut/main_repos/base_repo.dart';
import '../../../data/api/end_points.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class StoresRepo extends BaseRepo {
  StoresRepo({required super.dioClient, required super.sharedPreferences});

  Future<Either<ServerFailure, Response>> getStores() async {
    try {
      Response response = await dioClient.get(uri: EndPoints.stores);
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