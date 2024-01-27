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
    await localDatabase.insertEntity(tableName: tableName, object: model);
  }

  Future<int> updateItem({required ItemModel model, required String id}) async {
    return await localDatabase.updateEntity(
        tableName: tableName, object: model, id: id);
  }

  Future<void> removeItem({required String id}) async {
    await localDatabase.deleteEntity(id: id, tableName: tableName);
  }

  Future<List<ItemModel>> getItems() async {
    return (await localDatabase.getEntities(
            objectModel: ItemModel(), tableName: tableName))
        .cast<ItemModel>();
  }
}
