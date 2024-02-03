import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/features/search/model/suggestion_model.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_notification.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../data/error/failures.dart';
import '../repo/search_repo.dart';

class SearchBloc extends Bloc<AppEvent, AppState> {
  final SearchRepo repo;

  SearchBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
  }

  TextEditingController searchTEC = TextEditingController();

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    if (searchTEC.text.trim().isNotEmpty) {
      try {
        emit(Loading());

        Map data = {"search": searchTEC.text.trim()};

        Either<ServerFailure, Response> response =
            await repo.getSearchSuggestion(data);

        response.fold((fail) {
          AppCore.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.red));
          emit(Error());
        }, (success) {
          SuggestionModel model = SuggestionModel.fromJson(success.data);
          if (model.data != null && model.data!.isNotEmpty) {
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
    } else {
      emit(Start());
    }
  }
}
