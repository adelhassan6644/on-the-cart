import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../data/error/failures.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../main_blocs/user_bloc.dart';
import '../repo/profile_repo.dart';

class EditProfileBloc extends Bloc<AppEvent, AppState> {
  final ProfileRepo repo;

  EditProfileBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
    on<Init>(onInit);
  }

  Map<String, dynamic> body = {
    "name": "${UserBloc.instance.user?.name?.trim()}",
    "email": "${UserBloc.instance.user?.email?.trim()}",
    "phone": "${UserBloc.instance.user?.phone?.trim()}",
    // "country_code": "${UserBloc.instance.user?.countryCode}",
    // "country_flag": "${UserBloc.instance.user?.countryFlag}",
  };

  TextEditingController nameTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController mailTEC = TextEditingController();

  final profileImage = BehaviorSubject<File?>();
  Function(File?) get updateProfileImage => profileImage.sink.add;
  Stream<File?> get profileImageStream =>
      profileImage.stream.asBroadcastStream();

  // final country = BehaviorSubject<Country?>();
  // Function(Country?) get updateCountry => profileImage.sink.add;
  // Stream<Country?> get countryStream => profileImage.stream.asBroadcastStream();

  clear() {
    nameTEC.clear();
    phoneTEC.clear();
    mailTEC.clear();
    updateProfileImage(null);
    // updateCountry(null);
  }

  @override
  Future<void> close() {
    clear();
    return super.close();
  }

  hasImage() {
    if (profileImage.value != null || UserBloc.instance.user?.image != null) {
      return true;
    } else {
      // showToast(getTranslated("please_select_profile_image",
      //     CustomNavigator.navigatorState.currentContext!));
      return false;
    }
  }

  bool _boolCheckString(dynamic value, String key) {
    if (value != null && value != "" && value != body[key]) {
      return true;
    } else {
      return false;
    }
  }

  bool checkData() {
    return _boolCheckString(nameTEC.text.trim(), "name") ||
        _boolCheckString(mailTEC.text.trim(), "email") ||
        _boolCheckString(phoneTEC.text.trim(), "phone");
    // _boolCheckString(mailTEC.text.trim(), "country_code") ||
    // _boolCheckString(phoneTEC.text.trim(), "country_flag");
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      if (checkData() || profileImage.value != null) {
        if (profileImage.value != null) {
          body.addAll({
            "image": await MultipartFile.fromFile(profileImage.value!.path)
          });
        }

        Either<ServerFailure, Response> response =
            await repo.updateProfile(body);

        response.fold((fail) {
          AppCore.showSnackBar(
              notification: AppNotification(
                  message: ApiErrorHandler.getMessage(fail),
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
          emit(Error());
        }, (success) {
          AppCore.showSnackBar(
              notification: AppNotification(
            message: getTranslated("your_profile_successfully_updated"),
            backgroundColor: Styles.ACTIVE,
            borderColor: Styles.ACTIVE,
          ));

          ///To init Profile Data
          UserBloc.instance.add(Click());
          emit(Done());
        });
      } else {
        AppCore.showSnackBar(
          notification: AppNotification(
            message: getTranslated("you_must_change_something"),
            backgroundColor: Styles.IN_ACTIVE,
            borderColor: Styles.RED_COLOR,
          ),
        );
        emit(Start());
      }
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
  }

  ///To init Profile Data
  Future<void> onInit(Init event, Emitter<AppState> emit) async {
    nameTEC.text = UserBloc.instance.user?.name?.trim() ?? "";
    phoneTEC.text = UserBloc.instance.user?.phone?.trim() ?? "";
    mailTEC.text = UserBloc.instance.user?.email?.trim() ?? "";
    emit(Start());
  }
}
