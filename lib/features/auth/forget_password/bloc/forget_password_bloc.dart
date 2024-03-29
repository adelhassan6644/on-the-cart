import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../data/error/failures.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../../verification/model/verification_model.dart';
import '../repo/forget_password_repo.dart';

class ForgetPasswordBloc extends Bloc<AppEvent, AppState> {
  final ForgetPasswordRepo repo;

  ForgetPasswordBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
  }

  TextEditingController mailTEC = TextEditingController();

  clear() {
    mailTEC.clear();
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      Either<ServerFailure, Response> response =
          await repo.forgetPassword(mail: mailTEC.text.trim());

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
        emit(Error());
      }, (success) {
        CustomNavigator.push(Routes.VERIFICATION,
            replace: true,
            arguments:
                VerificationModel(mailTEC.text.trim(), fromRegister: false));
        AppCore.showSnackBar(
            notification: AppNotification(
                message: success.data?["message"] ?? "",
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Styles.RED_COLOR,
                iconName: "fill-close-circle"));
        clear();
        emit(Done());
      });
    } catch (e) {
      AppCore.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Styles.RED_COLOR,
              iconName: "fill-close-circle"));
      emit(Error());
    }
  }
}
