abstract class BaseModel {
  int? id;
  String? image;
  String? title;
  String? description;
  bool? isStore;

  BaseModel({
    this.id,
    this.image,
    this.title,
    this.description,
    this.isStore,
  });
}
