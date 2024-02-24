import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/features/addresses/bloc/addresses_bloc.dart';
import 'package:stepOut/features/addresses/model/addresses_model.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../data/error/failures.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../data/config/di.dart';
import '../model/custom_field_model.dart';
import '../repo/add_address_repo.dart';

class AddAddressBloc extends Bloc<AppEvent, AppState> {
  final AddAddressRepo repo;
  AddAddressBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
    on<Init>(onInit);
  }

  PickResult? pickedLocation;

  TextEditingController nameTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();
  TextEditingController addressDetailsTEC = TextEditingController();

  final isDefault = BehaviorSubject<bool?>();
  final city = BehaviorSubject<CustomFieldItem?>();
  final area = BehaviorSubject<CustomFieldItem?>();

  Function(bool?) get upIsDefault => isDefault.sink.add;
  Function(CustomFieldItem?) get updateArea => area.sink.add;
  Function(CustomFieldItem?) get updateCity => city.sink.add;

  Stream<bool?> get isDefaultStream => isDefault.stream.asBroadcastStream();
  Stream<CustomFieldItem?> get areaStream => area.stream.asBroadcastStream();
  Stream<CustomFieldItem?> get cityStream => city.stream.asBroadcastStream();

  clear() {
    nameTEC.clear();
    phoneTEC.clear();
    addressTEC.clear();
    addressDetailsTEC.clear();
    updateCity(null);
    updateArea(null);
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      Map<String, dynamic> data = {
        "customer_id": repo.userId,
        "title": nameTEC.text.trim(),
        "phone": phoneTEC.text.trim(),
        "address": addressTEC.text.trim(),
        "city_id": city.value?.id,
        "area_id": area.value?.id,
        // "lat": pickedLocation?.geometry?.location.lat.toString(),
        // "long": pickedLocation?.geometry?.location.lng.toString(),
        "details": addressDetailsTEC.text.trim(),
        "default": (isDefault.value == true) ? 1 : 0,
      };

      Either<ServerFailure, Response> response = await repo.addAddress(
          data: data,
          id: event.arguments != null ? (event.arguments as int) : null);

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        emit(Error());
      }, (success) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: success.data["message"],
                isFloating: true,
                backgroundColor: Styles.ACTIVE,
                borderColor: Colors.transparent));
        sl<AddressesBloc>().add(Click());
        CustomNavigator.pop();
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

  Future<void> onInit(Init event, Emitter<AppState> emit) async {
    nameTEC.text = (event.arguments as AddressItem).name ?? "";
    phoneTEC.text = (event.arguments as AddressItem).phone ?? "";
    addressTEC.text = (event.arguments as AddressItem).address ?? "";
    addressDetailsTEC.text =
        (event.arguments as AddressItem).addressDetails ?? "";
    upIsDefault((event.arguments as AddressItem).isDefaultAddress);
    updateCity((event.arguments as AddressItem).city);
    updateArea((event.arguments as AddressItem).area);
    emit(Start());
  }
}
