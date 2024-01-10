// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
      addonAvail: json['addon_avail'] as bool?,
      id: json['iid'] as int?,
      addons: (json['addons'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Addon.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemDescription: json['item_description'] as String?,
      itemImage: json['item_image'] as String?,
      itemName: json['item_name'] as String?,
      itemPrice: (json['item_price'] as num?)?.toDouble(),
      itemSubCategory: json['item_sub_category'] as String?,
      prepTime: (json['prep_time'] as num?)?.toDouble(),
      qtyAvail: json['qty_avail'] as bool?,
      quantity: (json['quantity'] as List<dynamic>?)
          ?.map((e) => Quantity.fromJson(e as Map<String, dynamic>))
          .toList(),
      removalAvail: json['removal_avail'] as bool?,
      removals: (json['removals'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Removal.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalOrder: json['total_order'] as int?,
      varientAvail: json['varient_avail'] as bool?,
      varients: (json['varients'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Varient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'addon_avail': instance.addonAvail,
      'iid': instance.id,
      'addons': instance.addons,
      'item_description': instance.itemDescription,
      'item_image': instance.itemImage,
      'item_name': instance.itemName,
      'item_price': instance.itemPrice,
      'item_sub_category': instance.itemSubCategory,
      'prep_time': instance.prepTime,
      'qty_avail': instance.qtyAvail,
      'quantity': instance.quantity,
      'removal_avail': instance.removalAvail,
      'removals': instance.removals,
      'total_order': instance.totalOrder,
      'varient_avail': instance.varientAvail,
      'varients': instance.varients,
    };

_$QuantityImpl _$$QuantityImplFromJson(Map<String, dynamic> json) =>
    _$QuantityImpl(
      quantity: json['quantity'] as String?,
      quantityPrice: (json['quantityPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$QuantityImplToJson(_$QuantityImpl instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'quantityPrice': instance.quantityPrice,
    };

_$AddonImpl _$$AddonImplFromJson(Map<String, dynamic> json) => _$AddonImpl(
      addonName: json['addonName'] as String?,
      addonPrice: (json['addonPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$AddonImplToJson(_$AddonImpl instance) =>
    <String, dynamic>{
      'addonName': instance.addonName,
      'addonPrice': instance.addonPrice,
    };

_$RemovalImpl _$$RemovalImplFromJson(Map<String, dynamic> json) =>
    _$RemovalImpl(
      removalName: json['removalname'] as String?,
    );

Map<String, dynamic> _$$RemovalImplToJson(_$RemovalImpl instance) =>
    <String, dynamic>{
      'removalname': instance.removalName,
    };

_$VarientImpl _$$VarientImplFromJson(Map<String, dynamic> json) =>
    _$VarientImpl(
      varientName: json['varient_name'] as String?,
      varientPrice: (json['varient_price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$VarientImplToJson(_$VarientImpl instance) =>
    <String, dynamic>{
      'varient_name': instance.varientName,
      'varient_price': instance.varientPrice,
    };
