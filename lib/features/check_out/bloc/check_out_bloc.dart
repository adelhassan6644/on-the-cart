import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/features/cart/repo/cart_repo.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../data/error/failures.dart';
import '../../../app/core/images.dart';
import '../../../components/confirmation_dialog.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../addresses/bloc/addresses_bloc.dart';
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

      Either<ServerFailure, Response> response = await repo.checkOut({
        "customer_id": repo.userId,
        "customer_address_id": sl<AddressesBloc>()
            .model!
            .data!
            .firstWhere((e) => e.isDefaultAddress == true)
            .id,
        "is_online_payment": selectedPaymentType.value?.id ?? 0
      });
      /// delete cart local database
      await sl.get<CartRepo>().deleteTable();
      response.fold((fail) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
        emit(Error());
      }, (success) {
        Future.delayed(
          Duration.zero,
          () => CustomSimpleDialog.parentSimpleDialog(
            canDismiss: false,
            icon: Images.success,
            customListWidget: ConfirmationDialog(
              title: getTranslated("order_has_been_confirmed"),
              description: getTranslated(
                  "you_can_track_your_order_from_the_order_history"),
              withOneButton: true,
              txtBtn: getTranslated("continue_shopping"),
              onContinue: () =>
                  CustomNavigator.push(Routes.dashboard, clean: true,arguments: 2),
            ),
          ),
        );
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
}
