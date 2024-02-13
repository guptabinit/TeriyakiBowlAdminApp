import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

enum CategoryItems {
  teriyaki('TERIYAKI'),
  bento('BENTO'),
  signatureRoll('SIGNATURE ROLLS'),
  sushiRoll('SUSHI ROLLS'),
  sidesSalads('SIDES & SALAD'),
  beverages('BEVERAGES'),
  lemonade('LEMONADE');

  final String name;

  const CategoryItems(this.name);
}

@freezed
class Category with _$Category {
  const factory Category({
    String? name,
    int? category,
    String? thumbnail,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
