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
import '../model/verification_model.dart';
import '../repo/verification_repo.dart';

class VerificationBloc extends Bloc<AppEvent, AppState> {
  final VerificationRepo repo;
  VerificationBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
    on<Resend>(onResend);
  }

  TextEditingController codeTEC = TextEditingController();

  clear() {
    codeTEC.clear();
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      VerificationModel data = event.arguments as VerificationModel;
      data.code = codeTEC.text.trim();

      Either<ServerFailure, Response> response = await repo.verifyMail(data);

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
        emit(Error());
      }, (success) {
        if (data.fromRegister) {
          repo.saveUserToken(success.data['data']["token"]);
          CustomNavigator.push(Routes.DASHBOARD, clean: true);
          AppCore.showSnackBar(
              notification: AppNotification(
                  message: "You logged in successfully",
                  backgroundColor: Styles.ACTIVE,
                  borderColor: Styles.ACTIVE,
                  iconName: "check-circle"));
        } else {
          CustomNavigator.push(Routes.RESET_PASSWORD, arguments: data.email);
          AppCore.showSnackBar(
              notification: AppNotification(
                  message: success.data?["message"] ?? "",
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Styles.RED_COLOR,
                  iconName: "fill-close-circle"));
        }
        clear();
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

  Future<void> onResend(Resend event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      VerificationModel data = event.arguments as VerificationModel;

      Either<ServerFailure, Response> response = await repo.resendCode(data);

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
        emit(Error());
      }, (success) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: success.data?["message"] ?? "",
                backgroundColor: Styles.ACTIVE,
                borderColor: Styles.ACTIVE,
                iconName: "fill-close-circle"));
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
}
