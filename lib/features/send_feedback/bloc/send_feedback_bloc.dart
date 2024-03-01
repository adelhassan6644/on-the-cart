import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/navigation/custom_navigation.dart';

import '../../../app/core/app_core.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_notification.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/styles.dart';
import '../../../data/error/failures.dart';
import '../repo/send_feedback_repo.dart';

class SendFeedbackBloc extends Bloc<AppEvent, AppState> {
  final SendFeedbackRepo repo;
  SendFeedbackBloc({required this.repo}) : super(Start()) {
    updateRatting(-1);
    on<Click>(sendReview);
  }

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final ratting = BehaviorSubject<int>();
  Function(int) get updateRatting => ratting.sink.add;
  Stream<int> get rattingStream => ratting.stream.asBroadcastStream();

  TextEditingController commentTEC = TextEditingController();

  Future<void> sendReview(Click event, Emitter<AppState> emit) async {
    if (globalKey.currentState!.validate()) {
      try {
        if (ratting.value != -1) {
          emit(Loading());

          Map data = {
            "customer_id": repo.userId,
            "product_id": "${event.arguments}",
            "rating": (ratting.value ?? 0) + 1,
            "feedback": commentTEC.text.trim(),
          };

          Either<ServerFailure, Response> response =
              await repo.sendFeedback(data);

          response.fold((fail) {
            AppCore.showSnackBar(
                notification: AppNotification(
                    message: fail.error,
                    isFloating: true,
                    backgroundColor: Styles.IN_ACTIVE,
                    borderColor: Colors.red));
            emit(Error());
          }, (success) {
            CustomNavigator.pop();
            AppCore.showSnackBar(
                notification: AppNotification(
                    message: success.data["message"],
                    isFloating: true,
                    backgroundColor: Styles.ACTIVE,
                    borderColor: Colors.transparent));
            emit(Done());
          });
        } else {
          AppCore.showToast(
            getTranslated("oops_select_your_rate"),
          );
          emit(Start());
        }
      } catch (e) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: e.toString(),
                backgroundColor: Styles.IN_ACTIVE,
                isFloating: true));
        emit(Error());
      }
    }
  }
}
