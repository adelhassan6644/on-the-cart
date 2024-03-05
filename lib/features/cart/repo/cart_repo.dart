import 'package:stepOut/data/api/end_points.dart';
import 'package:stepOut/main_repos/base_repo.dart';

import '../../../data/local_data/local_database.dart';
import '../../../main_models/items_model.dart';

class CartRepo extends BaseRepo {
  final LocaleDatabase localDatabase;
  CartRepo(
      {required this.localDatabase,
      required super.dioClient,
      required super.sharedPreferences});

  static String tableName = "Items";

  Future<void> addItem({required ItemModel model}) async {
    await dioClient.post(uri: EndPoints.addToCart, data: {
      "customer_id": userId,
      "product_id": model.id,
      "quantity": model.count
    });
    await localDatabase.insertEntity(tableName: tableName, object: model);
  }

  Future<int> updateItem({required ItemModel model, required String id}) async {
    await dioClient.post(
        uri: EndPoints.updateQuantity(model.cartProductId),
        data: {"product_id": model.id, "quantity": model.count});

    return await localDatabase.updateEntity(
        tableName: tableName, object: model, id: id);
  }

  Future<void> removeItem({
    required String id,
    required ItemModel model,
  }) async {
    await dioClient.post(uri: EndPoints.removeItame(model.cartProductId), data: {
      "product_id": model.cartProductId,
    });
    await localDatabase.deleteEntity(id: id, tableName: tableName);
  }

  Future<List<ItemModel>> getItems() async {
    return await dioClient
        .get(
          uri: EndPoints.getCart(userId),
        )
        .then((value) => List<ItemModel>.from(value.data["data"]!.map(
            (x) => ItemModel.fromJson(x["product"], quantity: x["quantity"],cartProductId:x["id"] ))));

  }

  Future<void> deleteTable() async {
    await localDatabase.deleteTable(tableName: tableName);
  }
}
