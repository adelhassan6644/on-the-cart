import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../data/error/failures.dart';
import '../model/payment_model.dart';
import '../repo/check_out_repo.dart';

class CheckOutBloc extends Bloc<AppEvent, AppState> {
  final CheckOutRepo repo;

  CheckOutBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
  }

  List<PaymentModel> paymentTypes = [
    PaymentModel(id: 0, title: getTranslated("cash")),
    PaymentModel(id: 1, title: getTranslated("online")),
  ];


  final selectedPaymentType = BehaviorSubject<PaymentModel?>();
  Function(PaymentModel?) get updateSelectedPaymentType =>
      selectedPaymentType.sink.add;
  Stream<PaymentModel?> get selectedPaymentTypeStream =>
      selectedPaymentType.stream.asBroadcastStream();

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      Either<ServerFailure, Response> response = await repo.checkOut("");

      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
        emit(Error());
      }, (success) {});
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
}
