import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/localization/language_constant.dart';

import '../../../app/core/app_core.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_notification.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/styles.dart';
import '../../../main_models/items_model.dart';
import '../model/cart_model.dart';
import '../repo/cart_repo.dart';

class CartBloc extends Bloc<AppEvent, AppState> {
  final CartRepo repo;
  CartBloc({required this.repo}) : super(Start()) {
    on<Get>(onGet);
    on<Add>(onAdd);
    on<Update>(onUpdate);
    on<Delete>(onDelete);
    on<Clear>(onClear);
  }

  bool get isLogin => repo.isLogin;

  CartModel? cartModel;

  Future<void> onGet(Get event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      List<ItemModel> items = await repo.getItems();
      cartModel = CartModel(data: items);
      if (items.isNotEmpty) {
        emit(Done(list: items));
      } else {
        emit(Empty());
      }
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

  Future<void> onAdd(Add event, Emitter<AppState> emit) async {
    try {
      await repo.addItem(model: (event.arguments as ItemModel));
      AppCore.showSnackBar(
          notification: AppNotification(
        message: getTranslated("added_to_cart"),
        backgroundColor: Styles.ACTIVE,
        borderColor: Styles.ACTIVE,
      ));
      add(Get());
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

  Future<void> onUpdate(Update event, Emitter<AppState> emit) async {
    try {
      await repo.updateItem(
          model: (event.arguments as ItemModel),
          id: "${(event.arguments as ItemModel).id}");
      add(Get());
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
      await repo.removeItem(id: "${(event.arguments as ItemModel).id}", model: event.arguments as ItemModel,);
      add(Get());
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

  Future<void> onClear(Clear event, Emitter<AppState> emit) async {
    try {
      await repo.deleteTable();
      add(Get());
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
