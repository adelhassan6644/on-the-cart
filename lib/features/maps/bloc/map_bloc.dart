import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stepOut/features/maps/repo/maps_repo.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../data/error/failures.dart';
import '../../../data/config/di.dart';
import '../../../data/error/api_error_handler.dart';
import '../models/location_model.dart';
import '../models/prediction_model.dart';

class MapBloc extends Bloc<AppEvent, AppState> {
  final MapRepo repo;

  MapBloc get instance => sl<MapBloc>();

  MapBloc({required this.repo}) : super(Start()) {
    on<Init>(onInit);
    on<Get>(onGet);
    on<Update>(onUpdate);
  }

  List<PredictionModel> _predictionList = [];
  String pickAddress = '';
  LocationModel? addressModel;
  Position? pickPosition;
  Future<List<PredictionModel>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      Either<ServerFailure, Response> response =
          await repo.searchLocation(text);
      response.fold((error) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(error),
                isFloating: true,
                backgroundColor: Styles.ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        _predictionList = [];
        response.data['predictions'].forEach((prediction) =>
            _predictionList.add(PredictionModel.fromJson(prediction)));
      });
    }
    return _predictionList;
  }

  LocationModel? currentLocation;
  Future<void> onInit(Init event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      await Geolocator.requestPermission();
      Position newLocalData = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      Either<ServerFailure, Response> response =
          await repo.getAddressFromGeocode(
              LatLng(newLocalData.latitude, newLocalData.longitude));

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        emit(Error());
      }, (response) {
        pickAddress =
            response.data['results'][0]['formatted_address'].toString();
        currentLocation = LocationModel(
          latitude: newLocalData.latitude.toString(),
          longitude: newLocalData.longitude.toString(),
          address: response.data['results'][0]['formatted_address'].toString(),
        );
        emit(Done());
      });
    } catch (e) {
      AppCore.showSnackBar(
        notification: AppNotification(
          message: e.toString(),
          backgroundColor: Styles.IN_ACTIVE,
          borderColor: Styles.RED_COLOR,
          iconName: "fill-close-circle",
        ),
      );
      emit(Error());
    }
  }

  Future<void> onGet(Get event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      await Geolocator.requestPermission();
      pickPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      (event.arguments as GoogleMapController).animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(pickPosition!.latitude, pickPosition!.longitude),
            zoom: 14),
      ));

      await decodeLatLong(
        latitude: pickPosition!.latitude,
        longitude: pickPosition!.longitude,
      );
    } catch (e) {
      AppCore.showSnackBar(
        notification: AppNotification(
          message: e.toString(),
          backgroundColor: Styles.IN_ACTIVE,
          borderColor: Styles.RED_COLOR,
          iconName: "fill-close-circle",
        ),
      );
      emit(Error());
    }
  }

  Future<void> onUpdate(Update event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      pickPosition = Position(
          latitude: (event.arguments as CameraPosition).target.latitude,
          longitude: (event.arguments as CameraPosition).target.longitude,
          timestamp: DateTime.now(),
          heading: 1,
          accuracy: 1,
          altitude: 1,
          speedAccuracy: 1,
          speed: 1,
          altitudeAccuracy: 1,
          headingAccuracy: 1);
      decodeLatLong(
          latitude: (event.arguments as CameraPosition).target.latitude,
          longitude: (event.arguments as CameraPosition).target.longitude);

      emit(Done());
    } catch (e) {
      AppCore.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      emit(Error());
    }
  }

  Future<void> decodeLatLong({
    required latitude,
    required longitude,
  }) async {
    Either<ServerFailure, Response> response =
        await repo.getAddressFromGeocode(LatLng(latitude, longitude));
    response.fold((l) => null, (response) {
      pickAddress = response.data['results'][0]['formatted_address'].toString();
      addressModel = LocationModel(
        latitude: latitude.toString(),
        longitude: longitude.toString(),
        address: response.data['results'][0]['formatted_address'].toString(),
      );
    });
  }
}
