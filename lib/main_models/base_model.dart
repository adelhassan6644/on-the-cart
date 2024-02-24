abstract class BaseModel {
  int? id;
  String? image;
  String? name;
  String? description;
  bool? isStore;

  BaseModel({
    this.id,
    this.image,
    this.name,
    this.description,
    this.isStore,
  });
}
