import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/features/addresses/model/addresses_model.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../data/error/failures.dart';
import '../../../components/loading_dialog.dart';
import '../repo/addresses_repo.dart';

class AddressesBloc extends Bloc<AppEvent, AppState> {
  final AddressesRepo repo;

  AddressesBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
  }

  AddressesModel? model;
  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      Either<ServerFailure, Response> response = await repo.getAddresses();

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
        emit(Error());
      }, (success) {
        model = AddressesModel.fromJson(success.data);
        if (model?.data != null && model!.data!.isNotEmpty) {
          emit(Done(model: model));
        } else {
          emit(Empty());
        }
      });
    } catch (e) {
      AppCore.showSnackBar(
          notification: AppNotification(
        message: e.toString(),
        backgroundColor: Styles.IN_ACTIVE,
        borderColor: Styles.RED_COLOR,
      ));
      emit(Error());
    }
  }

  Future<void> onDelete(Delete event, Emitter<AppState> emit) async {
    try {
      loadingDialog();
      Either<ServerFailure, Response> response =
          await repo.deleteAddress(event.arguments);
      CustomNavigator.pop();

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
      }, (success) {
        model?.data?.removeWhere((e) => e.id == (event.arguments as int));
        emit(Done(model: model));
      });
    } catch (e) {
      CustomNavigator.pop();
      AppCore.showSnackBar(
          notification: AppNotification(
        message: e.toString(),
        backgroundColor: Styles.IN_ACTIVE,
        borderColor: Styles.RED_COLOR,
      ));
    }
  }
}
