
import '../../domain/entities/home_category_entity.dart';

class Categorymodel {
  int? id;
  String? name;

  Categorymodel({
    this.id,
    this.name,
  });

  Categorymodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  HomeCategoryEntity toEntity() {
    return HomeCategoryEntity(
      id: id ?? 0,
      name: name ?? '',
    );
  }
}
