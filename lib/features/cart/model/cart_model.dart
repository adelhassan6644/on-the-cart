import '../../../data/config/mapper.dart';
import '../../../main_models/items_model.dart';

class CartModel extends SingleMapper {
  double total = 0;
  CartModel({required List<ItemModel> data}) {
    for (ItemModel model in data) {
      total += (model.price ?? 0);
    }
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
