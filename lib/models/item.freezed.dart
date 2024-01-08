// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  @JsonKey(name: 'addon_avail')
  bool? get addonAvail => throw _privateConstructorUsedError;
  @JsonKey(name: 'iid')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'addons')
  List<Addon?>? get addons => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_description')
  String? get itemDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_image')
  String? get itemImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_name')
  String? get itemName => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_price')
  double? get itemPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_sub_category')
  String? get itemSubCategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'prep_time')
  double? get prepTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'qty_avail')
  bool? get qtyAvail => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity')
  List<Quantity>? get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'removal_avail')
  bool? get removalAvail => throw _privateConstructorUsedError;
  @JsonKey(name: 'removals')
  List<Removal?>? get removals => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_order')
  int? get totalOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'varient_avail')
  bool? get varientAvail => throw _privateConstructorUsedError;
  @JsonKey(name: 'varients')
  List<Varient?>? get varients => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call(
      {@JsonKey(name: 'addon_avail') bool? addonAvail,
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
      @JsonKey(name: 'total_order') int? totalOrder,
      @JsonKey(name: 'varient_avail') bool? varientAvail,
      @JsonKey(name: 'varients') List<Varient?>? varients});
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addonAvail = freezed,
    Object? id = freezed,
    Object? addons = freezed,
    Object? itemDescription = freezed,
    Object? itemImage = freezed,
    Object? itemName = freezed,
    Object? itemPrice = freezed,
    Object? itemSubCategory = freezed,
    Object? prepTime = freezed,
    Object? qtyAvail = freezed,
    Object? quantity = freezed,
    Object? removalAvail = freezed,
    Object? removals = freezed,
    Object? totalOrder = freezed,
    Object? varientAvail = freezed,
    Object? varients = freezed,
  }) {
    return _then(_value.copyWith(
      addonAvail: freezed == addonAvail
          ? _value.addonAvail
          : addonAvail // ignore: cast_nullable_to_non_nullable
              as bool?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      addons: freezed == addons
          ? _value.addons
          : addons // ignore: cast_nullable_to_non_nullable
              as List<Addon?>?,
      itemDescription: freezed == itemDescription
          ? _value.itemDescription
          : itemDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      itemImage: freezed == itemImage
          ? _value.itemImage
          : itemImage // ignore: cast_nullable_to_non_nullable
              as String?,
      itemName: freezed == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String?,
      itemPrice: freezed == itemPrice
          ? _value.itemPrice
          : itemPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      itemSubCategory: freezed == itemSubCategory
          ? _value.itemSubCategory
          : itemSubCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      prepTime: freezed == prepTime
          ? _value.prepTime
          : prepTime // ignore: cast_nullable_to_non_nullable
              as double?,
      qtyAvail: freezed == qtyAvail
          ? _value.qtyAvail
          : qtyAvail // ignore: cast_nullable_to_non_nullable
              as bool?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as List<Quantity>?,
      removalAvail: freezed == removalAvail
          ? _value.removalAvail
          : removalAvail // ignore: cast_nullable_to_non_nullable
              as bool?,
      removals: freezed == removals
          ? _value.removals
          : removals // ignore: cast_nullable_to_non_nullable
              as List<Removal?>?,
      totalOrder: freezed == totalOrder
          ? _value.totalOrder
          : totalOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      varientAvail: freezed == varientAvail
          ? _value.varientAvail
          : varientAvail // ignore: cast_nullable_to_non_nullable
              as bool?,
      varients: freezed == varients
          ? _value.varients
          : varients // ignore: cast_nullable_to_non_nullable
              as List<Varient?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemImplCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$ItemImplCopyWith(
          _$ItemImpl value, $Res Function(_$ItemImpl) then) =
      __$$ItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'addon_avail') bool? addonAvail,
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
      @JsonKey(name: 'total_order') int? totalOrder,
      @JsonKey(name: 'varient_avail') bool? varientAvail,
      @JsonKey(name: 'varients') List<Varient?>? varients});
}

/// @nodoc
class __$$ItemImplCopyWithImpl<$Res>
    extends _$ItemCopyWithImpl<$Res, _$ItemImpl>
    implements _$$ItemImplCopyWith<$Res> {
  __$$ItemImplCopyWithImpl(_$ItemImpl _value, $Res Function(_$ItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addonAvail = freezed,
    Object? id = freezed,
    Object? addons = freezed,
    Object? itemDescription = freezed,
    Object? itemImage = freezed,
    Object? itemName = freezed,
    Object? itemPrice = freezed,
    Object? itemSubCategory = freezed,
    Object? prepTime = freezed,
    Object? qtyAvail = freezed,
    Object? quantity = freezed,
    Object? removalAvail = freezed,
    Object? removals = freezed,
    Object? totalOrder = freezed,
    Object? varientAvail = freezed,
    Object? varients = freezed,
  }) {
    return _then(_$ItemImpl(
      addonAvail: freezed == addonAvail
          ? _value.addonAvail
          : addonAvail // ignore: cast_nullable_to_non_nullable
              as bool?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      addons: freezed == addons
          ? _value._addons
          : addons // ignore: cast_nullable_to_non_nullable
              as List<Addon?>?,
      itemDescription: freezed == itemDescription
          ? _value.itemDescription
          : itemDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      itemImage: freezed == itemImage
          ? _value.itemImage
          : itemImage // ignore: cast_nullable_to_non_nullable
              as String?,
      itemName: freezed == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String?,
      itemPrice: freezed == itemPrice
          ? _value.itemPrice
          : itemPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      itemSubCategory: freezed == itemSubCategory
          ? _value.itemSubCategory
          : itemSubCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      prepTime: freezed == prepTime
          ? _value.prepTime
          : prepTime // ignore: cast_nullable_to_non_nullable
              as double?,
      qtyAvail: freezed == qtyAvail
          ? _value.qtyAvail
          : qtyAvail // ignore: cast_nullable_to_non_nullable
              as bool?,
      quantity: freezed == quantity
          ? _value._quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as List<Quantity>?,
      removalAvail: freezed == removalAvail
          ? _value.removalAvail
          : removalAvail // ignore: cast_nullable_to_non_nullable
              as bool?,
      removals: freezed == removals
          ? _value._removals
          : removals // ignore: cast_nullable_to_non_nullable
              as List<Removal?>?,
      totalOrder: freezed == totalOrder
          ? _value.totalOrder
          : totalOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      varientAvail: freezed == varientAvail
          ? _value.varientAvail
          : varientAvail // ignore: cast_nullable_to_non_nullable
              as bool?,
      varients: freezed == varients
          ? _value._varients
          : varients // ignore: cast_nullable_to_non_nullable
              as List<Varient?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemImpl implements _Item {
  const _$ItemImpl(
      {@JsonKey(name: 'addon_avail') this.addonAvail,
      @JsonKey(name: 'iid') this.id,
      @JsonKey(name: 'addons') final List<Addon?>? addons,
      @JsonKey(name: 'item_description') this.itemDescription,
      @JsonKey(name: 'item_image') this.itemImage,
      @JsonKey(name: 'item_name') this.itemName,
      @JsonKey(name: 'item_price') this.itemPrice,
      @JsonKey(name: 'item_sub_category') this.itemSubCategory,
      @JsonKey(name: 'prep_time') this.prepTime,
      @JsonKey(name: 'qty_avail') this.qtyAvail,
      @JsonKey(name: 'quantity') final List<Quantity>? quantity,
      @JsonKey(name: 'removal_avail') this.removalAvail,
      @JsonKey(name: 'removals') final List<Removal?>? removals,
      @JsonKey(name: 'total_order') this.totalOrder,
      @JsonKey(name: 'varient_avail') this.varientAvail,
      @JsonKey(name: 'varients') final List<Varient?>? varients})
      : _addons = addons,
        _quantity = quantity,
        _removals = removals,
        _varients = varients;

  factory _$ItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemImplFromJson(json);

  @override
  @JsonKey(name: 'addon_avail')
  final bool? addonAvail;
  @override
  @JsonKey(name: 'iid')
  final int? id;
  final List<Addon?>? _addons;
  @override
  @JsonKey(name: 'addons')
  List<Addon?>? get addons {
    final value = _addons;
    if (value == null) return null;
    if (_addons is EqualUnmodifiableListView) return _addons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'item_description')
  final String? itemDescription;
  @override
  @JsonKey(name: 'item_image')
  final String? itemImage;
  @override
  @JsonKey(name: 'item_name')
  final String? itemName;
  @override
  @JsonKey(name: 'item_price')
  final double? itemPrice;
  @override
  @JsonKey(name: 'item_sub_category')
  final String? itemSubCategory;
  @override
  @JsonKey(name: 'prep_time')
  final double? prepTime;
  @override
  @JsonKey(name: 'qty_avail')
  final bool? qtyAvail;
  final List<Quantity>? _quantity;
  @override
  @JsonKey(name: 'quantity')
  List<Quantity>? get quantity {
    final value = _quantity;
    if (value == null) return null;
    if (_quantity is EqualUnmodifiableListView) return _quantity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'removal_avail')
  final bool? removalAvail;
  final List<Removal?>? _removals;
  @override
  @JsonKey(name: 'removals')
  List<Removal?>? get removals {
    final value = _removals;
    if (value == null) return null;
    if (_removals is EqualUnmodifiableListView) return _removals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'total_order')
  final int? totalOrder;
  @override
  @JsonKey(name: 'varient_avail')
  final bool? varientAvail;
  final List<Varient?>? _varients;
  @override
  @JsonKey(name: 'varients')
  List<Varient?>? get varients {
    final value = _varients;
    if (value == null) return null;
    if (_varients is EqualUnmodifiableListView) return _varients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Item(addonAvail: $addonAvail, id: $id, addons: $addons, itemDescription: $itemDescription, itemImage: $itemImage, itemName: $itemName, itemPrice: $itemPrice, itemSubCategory: $itemSubCategory, prepTime: $prepTime, qtyAvail: $qtyAvail, quantity: $quantity, removalAvail: $removalAvail, removals: $removals, totalOrder: $totalOrder, varientAvail: $varientAvail, varients: $varients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemImpl &&
            (identical(other.addonAvail, addonAvail) ||
                other.addonAvail == addonAvail) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._addons, _addons) &&
            (identical(other.itemDescription, itemDescription) ||
                other.itemDescription == itemDescription) &&
            (identical(other.itemImage, itemImage) ||
                other.itemImage == itemImage) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.itemPrice, itemPrice) ||
                other.itemPrice == itemPrice) &&
            (identical(other.itemSubCategory, itemSubCategory) ||
                other.itemSubCategory == itemSubCategory) &&
            (identical(other.prepTime, prepTime) ||
                other.prepTime == prepTime) &&
            (identical(other.qtyAvail, qtyAvail) ||
                other.qtyAvail == qtyAvail) &&
            const DeepCollectionEquality().equals(other._quantity, _quantity) &&
            (identical(other.removalAvail, removalAvail) ||
                other.removalAvail == removalAvail) &&
            const DeepCollectionEquality().equals(other._removals, _removals) &&
            (identical(other.totalOrder, totalOrder) ||
                other.totalOrder == totalOrder) &&
            (identical(other.varientAvail, varientAvail) ||
                other.varientAvail == varientAvail) &&
            const DeepCollectionEquality().equals(other._varients, _varients));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      addonAvail,
      id,
      const DeepCollectionEquality().hash(_addons),
      itemDescription,
      itemImage,
      itemName,
      itemPrice,
      itemSubCategory,
      prepTime,
      qtyAvail,
      const DeepCollectionEquality().hash(_quantity),
      removalAvail,
      const DeepCollectionEquality().hash(_removals),
      totalOrder,
      varientAvail,
      const DeepCollectionEquality().hash(_varients));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      __$$ItemImplCopyWithImpl<_$ItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemImplToJson(
      this,
    );
  }
}

abstract class _Item implements Item {
  const factory _Item(
      {@JsonKey(name: 'addon_avail') final bool? addonAvail,
      @JsonKey(name: 'iid') final int? id,
      @JsonKey(name: 'addons') final List<Addon?>? addons,
      @JsonKey(name: 'item_description') final String? itemDescription,
      @JsonKey(name: 'item_image') final String? itemImage,
      @JsonKey(name: 'item_name') final String? itemName,
      @JsonKey(name: 'item_price') final double? itemPrice,
      @JsonKey(name: 'item_sub_category') final String? itemSubCategory,
      @JsonKey(name: 'prep_time') final double? prepTime,
      @JsonKey(name: 'qty_avail') final bool? qtyAvail,
      @JsonKey(name: 'quantity') final List<Quantity>? quantity,
      @JsonKey(name: 'removal_avail') final bool? removalAvail,
      @JsonKey(name: 'removals') final List<Removal?>? removals,
      @JsonKey(name: 'total_order') final int? totalOrder,
      @JsonKey(name: 'varient_avail') final bool? varientAvail,
      @JsonKey(name: 'varients') final List<Varient?>? varients}) = _$ItemImpl;

  factory _Item.fromJson(Map<String, dynamic> json) = _$ItemImpl.fromJson;

  @override
  @JsonKey(name: 'addon_avail')
  bool? get addonAvail;
  @override
  @JsonKey(name: 'iid')
  int? get id;
  @override
  @JsonKey(name: 'addons')
  List<Addon?>? get addons;
  @override
  @JsonKey(name: 'item_description')
  String? get itemDescription;
  @override
  @JsonKey(name: 'item_image')
  String? get itemImage;
  @override
  @JsonKey(name: 'item_name')
  String? get itemName;
  @override
  @JsonKey(name: 'item_price')
  double? get itemPrice;
  @override
  @JsonKey(name: 'item_sub_category')
  String? get itemSubCategory;
  @override
  @JsonKey(name: 'prep_time')
  double? get prepTime;
  @override
  @JsonKey(name: 'qty_avail')
  bool? get qtyAvail;
  @override
  @JsonKey(name: 'quantity')
  List<Quantity>? get quantity;
  @override
  @JsonKey(name: 'removal_avail')
  bool? get removalAvail;
  @override
  @JsonKey(name: 'removals')
  List<Removal?>? get removals;
  @override
  @JsonKey(name: 'total_order')
  int? get totalOrder;
  @override
  @JsonKey(name: 'varient_avail')
  bool? get varientAvail;
  @override
  @JsonKey(name: 'varients')
  List<Varient?>? get varients;
  @override
  @JsonKey(ignore: true)
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Quantity _$QuantityFromJson(Map<String, dynamic> json) {
  return _Quantity.fromJson(json);
}

/// @nodoc
mixin _$Quantity {
  String? get quantity => throw _privateConstructorUsedError;
  double? get quantityPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuantityCopyWith<Quantity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuantityCopyWith<$Res> {
  factory $QuantityCopyWith(Quantity value, $Res Function(Quantity) then) =
      _$QuantityCopyWithImpl<$Res, Quantity>;
  @useResult
  $Res call({String? quantity, double? quantityPrice});
}

/// @nodoc
class _$QuantityCopyWithImpl<$Res, $Val extends Quantity>
    implements $QuantityCopyWith<$Res> {
  _$QuantityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = freezed,
    Object? quantityPrice = freezed,
  }) {
    return _then(_value.copyWith(
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String?,
      quantityPrice: freezed == quantityPrice
          ? _value.quantityPrice
          : quantityPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuantityImplCopyWith<$Res>
    implements $QuantityCopyWith<$Res> {
  factory _$$QuantityImplCopyWith(
          _$QuantityImpl value, $Res Function(_$QuantityImpl) then) =
      __$$QuantityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? quantity, double? quantityPrice});
}

/// @nodoc
class __$$QuantityImplCopyWithImpl<$Res>
    extends _$QuantityCopyWithImpl<$Res, _$QuantityImpl>
    implements _$$QuantityImplCopyWith<$Res> {
  __$$QuantityImplCopyWithImpl(
      _$QuantityImpl _value, $Res Function(_$QuantityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = freezed,
    Object? quantityPrice = freezed,
  }) {
    return _then(_$QuantityImpl(
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String?,
      quantityPrice: freezed == quantityPrice
          ? _value.quantityPrice
          : quantityPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuantityImpl implements _Quantity {
  const _$QuantityImpl({this.quantity, this.quantityPrice});

  factory _$QuantityImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuantityImplFromJson(json);

  @override
  final String? quantity;
  @override
  final double? quantityPrice;

  @override
  String toString() {
    return 'Quantity(quantity: $quantity, quantityPrice: $quantityPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuantityImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.quantityPrice, quantityPrice) ||
                other.quantityPrice == quantityPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, quantity, quantityPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuantityImplCopyWith<_$QuantityImpl> get copyWith =>
      __$$QuantityImplCopyWithImpl<_$QuantityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuantityImplToJson(
      this,
    );
  }
}

abstract class _Quantity implements Quantity {
  const factory _Quantity(
      {final String? quantity, final double? quantityPrice}) = _$QuantityImpl;

  factory _Quantity.fromJson(Map<String, dynamic> json) =
      _$QuantityImpl.fromJson;

  @override
  String? get quantity;
  @override
  double? get quantityPrice;
  @override
  @JsonKey(ignore: true)
  _$$QuantityImplCopyWith<_$QuantityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Addon _$AddonFromJson(Map<String, dynamic> json) {
  return _Addon.fromJson(json);
}

/// @nodoc
mixin _$Addon {
  String? get addonName => throw _privateConstructorUsedError;
  double? get addonPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddonCopyWith<Addon> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddonCopyWith<$Res> {
  factory $AddonCopyWith(Addon value, $Res Function(Addon) then) =
      _$AddonCopyWithImpl<$Res, Addon>;
  @useResult
  $Res call({String? addonName, double? addonPrice});
}

/// @nodoc
class _$AddonCopyWithImpl<$Res, $Val extends Addon>
    implements $AddonCopyWith<$Res> {
  _$AddonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addonName = freezed,
    Object? addonPrice = freezed,
  }) {
    return _then(_value.copyWith(
      addonName: freezed == addonName
          ? _value.addonName
          : addonName // ignore: cast_nullable_to_non_nullable
              as String?,
      addonPrice: freezed == addonPrice
          ? _value.addonPrice
          : addonPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddonImplCopyWith<$Res> implements $AddonCopyWith<$Res> {
  factory _$$AddonImplCopyWith(
          _$AddonImpl value, $Res Function(_$AddonImpl) then) =
      __$$AddonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? addonName, double? addonPrice});
}

/// @nodoc
class __$$AddonImplCopyWithImpl<$Res>
    extends _$AddonCopyWithImpl<$Res, _$AddonImpl>
    implements _$$AddonImplCopyWith<$Res> {
  __$$AddonImplCopyWithImpl(
      _$AddonImpl _value, $Res Function(_$AddonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addonName = freezed,
    Object? addonPrice = freezed,
  }) {
    return _then(_$AddonImpl(
      addonName: freezed == addonName
          ? _value.addonName
          : addonName // ignore: cast_nullable_to_non_nullable
              as String?,
      addonPrice: freezed == addonPrice
          ? _value.addonPrice
          : addonPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddonImpl implements _Addon {
  const _$AddonImpl({this.addonName, this.addonPrice});

  factory _$AddonImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddonImplFromJson(json);

  @override
  final String? addonName;
  @override
  final double? addonPrice;

  @override
  String toString() {
    return 'Addon(addonName: $addonName, addonPrice: $addonPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddonImpl &&
            (identical(other.addonName, addonName) ||
                other.addonName == addonName) &&
            (identical(other.addonPrice, addonPrice) ||
                other.addonPrice == addonPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, addonName, addonPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddonImplCopyWith<_$AddonImpl> get copyWith =>
      __$$AddonImplCopyWithImpl<_$AddonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddonImplToJson(
      this,
    );
  }
}

abstract class _Addon implements Addon {
  const factory _Addon({final String? addonName, final double? addonPrice}) =
      _$AddonImpl;

  factory _Addon.fromJson(Map<String, dynamic> json) = _$AddonImpl.fromJson;

  @override
  String? get addonName;
  @override
  double? get addonPrice;
  @override
  @JsonKey(ignore: true)
  _$$AddonImplCopyWith<_$AddonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Removal _$RemovalFromJson(Map<String, dynamic> json) {
  return _Removal.fromJson(json);
}

/// @nodoc
mixin _$Removal {
  @JsonKey(name: 'removalname')
  String? get removalName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RemovalCopyWith<Removal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemovalCopyWith<$Res> {
  factory $RemovalCopyWith(Removal value, $Res Function(Removal) then) =
      _$RemovalCopyWithImpl<$Res, Removal>;
  @useResult
  $Res call({@JsonKey(name: 'removalname') String? removalName});
}

/// @nodoc
class _$RemovalCopyWithImpl<$Res, $Val extends Removal>
    implements $RemovalCopyWith<$Res> {
  _$RemovalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? removalName = freezed,
  }) {
    return _then(_value.copyWith(
      removalName: freezed == removalName
          ? _value.removalName
          : removalName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RemovalImplCopyWith<$Res> implements $RemovalCopyWith<$Res> {
  factory _$$RemovalImplCopyWith(
          _$RemovalImpl value, $Res Function(_$RemovalImpl) then) =
      __$$RemovalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'removalname') String? removalName});
}

/// @nodoc
class __$$RemovalImplCopyWithImpl<$Res>
    extends _$RemovalCopyWithImpl<$Res, _$RemovalImpl>
    implements _$$RemovalImplCopyWith<$Res> {
  __$$RemovalImplCopyWithImpl(
      _$RemovalImpl _value, $Res Function(_$RemovalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? removalName = freezed,
  }) {
    return _then(_$RemovalImpl(
      removalName: freezed == removalName
          ? _value.removalName
          : removalName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemovalImpl implements _Removal {
  const _$RemovalImpl({@JsonKey(name: 'removalname') this.removalName});

  factory _$RemovalImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemovalImplFromJson(json);

  @override
  @JsonKey(name: 'removalname')
  final String? removalName;

  @override
  String toString() {
    return 'Removal(removalName: $removalName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemovalImpl &&
            (identical(other.removalName, removalName) ||
                other.removalName == removalName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, removalName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemovalImplCopyWith<_$RemovalImpl> get copyWith =>
      __$$RemovalImplCopyWithImpl<_$RemovalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RemovalImplToJson(
      this,
    );
  }
}

abstract class _Removal implements Removal {
  const factory _Removal(
          {@JsonKey(name: 'removalname') final String? removalName}) =
      _$RemovalImpl;

  factory _Removal.fromJson(Map<String, dynamic> json) = _$RemovalImpl.fromJson;

  @override
  @JsonKey(name: 'removalname')
  String? get removalName;
  @override
  @JsonKey(ignore: true)
  _$$RemovalImplCopyWith<_$RemovalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Varient _$VarientFromJson(Map<String, dynamic> json) {
  return _Varient.fromJson(json);
}

/// @nodoc
mixin _$Varient {
  @JsonKey(name: 'varient_name')
  String? get varientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'varient_price')
  double? get varientPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VarientCopyWith<Varient> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VarientCopyWith<$Res> {
  factory $VarientCopyWith(Varient value, $Res Function(Varient) then) =
      _$VarientCopyWithImpl<$Res, Varient>;
  @useResult
  $Res call(
      {@JsonKey(name: 'varient_name') String? varientName,
      @JsonKey(name: 'varient_price') double? varientPrice});
}

/// @nodoc
class _$VarientCopyWithImpl<$Res, $Val extends Varient>
    implements $VarientCopyWith<$Res> {
  _$VarientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? varientName = freezed,
    Object? varientPrice = freezed,
  }) {
    return _then(_value.copyWith(
      varientName: freezed == varientName
          ? _value.varientName
          : varientName // ignore: cast_nullable_to_non_nullable
              as String?,
      varientPrice: freezed == varientPrice
          ? _value.varientPrice
          : varientPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VarientImplCopyWith<$Res> implements $VarientCopyWith<$Res> {
  factory _$$VarientImplCopyWith(
          _$VarientImpl value, $Res Function(_$VarientImpl) then) =
      __$$VarientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'varient_name') String? varientName,
      @JsonKey(name: 'varient_price') double? varientPrice});
}

/// @nodoc
class __$$VarientImplCopyWithImpl<$Res>
    extends _$VarientCopyWithImpl<$Res, _$VarientImpl>
    implements _$$VarientImplCopyWith<$Res> {
  __$$VarientImplCopyWithImpl(
      _$VarientImpl _value, $Res Function(_$VarientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? varientName = freezed,
    Object? varientPrice = freezed,
  }) {
    return _then(_$VarientImpl(
      varientName: freezed == varientName
          ? _value.varientName
          : varientName // ignore: cast_nullable_to_non_nullable
              as String?,
      varientPrice: freezed == varientPrice
          ? _value.varientPrice
          : varientPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VarientImpl implements _Varient {
  const _$VarientImpl(
      {@JsonKey(name: 'varient_name') this.varientName,
      @JsonKey(name: 'varient_price') this.varientPrice});

  factory _$VarientImpl.fromJson(Map<String, dynamic> json) =>
      _$$VarientImplFromJson(json);

  @override
  @JsonKey(name: 'varient_name')
  final String? varientName;
  @override
  @JsonKey(name: 'varient_price')
  final double? varientPrice;

  @override
  String toString() {
    return 'Varient(varientName: $varientName, varientPrice: $varientPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VarientImpl &&
            (identical(other.varientName, varientName) ||
                other.varientName == varientName) &&
            (identical(other.varientPrice, varientPrice) ||
                other.varientPrice == varientPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, varientName, varientPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VarientImplCopyWith<_$VarientImpl> get copyWith =>
      __$$VarientImplCopyWithImpl<_$VarientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VarientImplToJson(
      this,
    );
  }
}

abstract class _Varient implements Varient {
  const factory _Varient(
          {@JsonKey(name: 'varient_name') final String? varientName,
          @JsonKey(name: 'varient_price') final double? varientPrice}) =
      _$VarientImpl;

  factory _Varient.fromJson(Map<String, dynamic> json) = _$VarientImpl.fromJson;

  @override
  @JsonKey(name: 'varient_name')
  String? get varientName;
  @override
  @JsonKey(name: 'varient_price')
  double? get varientPrice;
  @override
  @JsonKey(ignore: true)
  _$$VarientImplCopyWith<_$VarientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
