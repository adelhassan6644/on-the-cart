import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stepOut/main_repos/base_repo.dart';
import '../../../../data/api/end_points.dart';
import '../../../../data/error/api_error_handler.dart';
import '../../../../data/error/failures.dart';

class AddAddressRepo extends BaseRepo {
  AddAddressRepo({required super.dioClient, required super.sharedPreferences});

  Future<Either<ServerFailure, Response>> addAddress(
      {int? id, required Map data}) async {
    try {
      Response response = await dioClient.post(
          uri: id == null ? EndPoints.addAddress : EndPoints.addAddress,
          data: data);
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> getCities() async {
    try {
      Response response = await dioClient.get(uri: EndPoints.cities);
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> getAreas() async {
    try {
      Response response = await dioClient.get(uri: EndPoints.areas);
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
