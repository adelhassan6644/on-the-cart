import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/core/app_core.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_notification.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/styles.dart';
import '../../../data/config/di.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../model/setting_model.dart';
import '../repo/setting_repo.dart';

class SettingBloc extends Bloc<AppEvent, AppState> {
  final SettingRepo repo;

  static SettingBloc get instance => sl<SettingBloc>();

  SettingBloc({required this.repo}) : super(Start()) {
    on<Get>(onGet);
  }

  Future<void> onGet(Get event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      Either<ServerFailure, Response> response = await repo.getSetting();

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        emit(Error());
      }, (success) {
        SettingModel model = SettingModel.fromJson(success.data["data"]);
        if (model.data != null) {
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
          iconName: "fill-close-circle",
        ),
      );
      emit(Error());
    }
  }
}
