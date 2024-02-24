import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/features/auth/verification/model/verification_model.dart';

import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../data/error/failures.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../repo/register_repo.dart';

class RegisterBloc extends Bloc<AppEvent, AppState> {
  final agreeToTerms = BehaviorSubject<bool?>();

  final RegisterRepo repo;
  RegisterBloc({required this.repo}) : super(Start()) {
    updateAgreeToTerms(false);
    on<Click>(onClick);
  }

  TextEditingController nameTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController mailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController confirmPasswordTEC = TextEditingController();

  Function(bool?) get updateAgreeToTerms => agreeToTerms.sink.add;

  Stream<bool?> get agreeToTermsStream =>
      agreeToTerms.stream.asBroadcastStream();

  clear() {
    nameTEC.clear();
    phoneTEC.clear();
    mailTEC.clear();
    passwordTEC.clear();
    confirmPasswordTEC.clear();
    updateAgreeToTerms(false);
  }

  @override
  Future<void> close() {
    updateAgreeToTerms(false);
    return super.close();
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    if (agreeToTerms.value!) {
      try {
        emit(Loading());
        Map<String, dynamic> data = {
          "name": nameTEC.text.trim(),
          "phone": phoneTEC.text.trim(),
          "email": mailTEC.text.trim(),
          "password": passwordTEC.text.trim(),
        };

        Either<ServerFailure, Response> response = await repo.register(data);

        response.fold((fail) {
          AppCore.showSnackBar(
              notification: AppNotification(
                  message: getTranslated("invalid_credentials"),
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
          emit(Error());
        }, (success) {
          CustomNavigator.push(Routes.verification,
              arguments: VerificationModel(mailTEC.text.trim()));
          clear();
          emit(Done());
        });
      } catch (e) {
        AppCore.showSnackBar(
          notification: AppNotification(
            message: e.toString(),
            backgroundColor: Styles.IN_ACTIVE,
            borderColor: Styles.RED_COLOR,
          ),
        );
        emit(Error());
      }
    } else {
      AppCore.showSnackBar(
          notification: AppNotification(
              message:
                  getTranslated("oops_you_must_agree_to_terms_and_conditions"),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
    }
  }
}
