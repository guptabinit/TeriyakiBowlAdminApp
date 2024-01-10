import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@Freezed(copyWith: true)
class Item with _$Item {
  const factory Item({
    @JsonKey(name: 'addon_avail') bool? addonAvail,
    @JsonKey(name: 'iid') int? id,
    @JsonKey(name: 'addons') List<Addon?>? addons,
    @JsonKey(name: 'item_description') String? itemDescription,
    @JsonKey(name: 'item_image') String? itemImage,
    @JsonKey(name: 'item_name') String? itemName,
    @JsonKey(name: 'item_price') double? itemPrice,
    @JsonKey(name: 'item_sub_category') String? itemSubCategory,
    @JsonKey(name: 'prep_time') double? prepTime,
    @JsonKey(name: 'qty_avail') bool? qtyAvail,
    @JsonKey(name: 'quantity') List<Quantity>? quantity,
    @JsonKey(name: 'removal_avail') bool? removalAvail,
    @JsonKey(name: 'removals') List<Removal?>? removals,
    @JsonKey(name: 'total_order') num? totalOrder,
    @JsonKey(name: 'varient_avail') bool? varientAvail,
    @JsonKey(name: 'varients') List<Varient?>? varients,
  }) = _Item;

  factory Item.fromJson(Map<String, Object?> json) => _$ItemFromJson(json);
}

@Freezed(copyWith: true)
class Quantity with _$Quantity {
  const factory Quantity({
    String? quantity,
    double? quantityPrice,
  }) = _Quantity;

  factory Quantity.fromJson(Map<String, Object?> json) =>
      _$QuantityFromJson(json);
}

@Freezed(copyWith: true)
class Addon with _$Addon {
  const factory Addon({
    String? addonName,
    double? addonPrice,
  }) = _Addon;

  factory Addon.fromJson(Map<String, Object?> json) => _$AddonFromJson(json);
}

@Freezed(copyWith: true)
class Removal with _$Removal {
  const factory Removal({
    @JsonKey(name: 'removalname') String? removalName,
  }) = _Removal;

  factory Removal.fromJson(Map<String, Object?> json) =>
      _$RemovalFromJson(json);
}

@Freezed(copyWith: true)
class Varient with _$Varient {
  const factory Varient({
    @JsonKey(name: 'varientName') String? varientName,
    @JsonKey(name: 'varientPrice') double? varientPrice,
  }) = _Varient;

  factory Varient.fromJson(Map<String, Object?> json) =>
      _$VarientFromJson(json);
}
