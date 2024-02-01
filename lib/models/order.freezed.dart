// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  @JsonKey(name: 'oid')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'accepted_time')
  DateTime? get acceptedTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_total')
  double? get orderTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_completed')
  bool? get paymentCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_status')
  int? get orderStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_accepted')
  int? get orderAccepted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {@JsonKey(name: 'oid') String? id,
      @JsonKey(name: 'accepted_time') DateTime? acceptedTime,
      @JsonKey(name: 'order_total') double? orderTotal,
      @JsonKey(name: 'payment_completed') bool? paymentCompleted,
      @JsonKey(name: 'order_status') int? orderStatus,
      @JsonKey(name: 'order_accepted') int? orderAccepted});
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? acceptedTime = freezed,
    Object? orderTotal = freezed,
    Object? paymentCompleted = freezed,
    Object? orderStatus = freezed,
    Object? orderAccepted = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptedTime: freezed == acceptedTime
          ? _value.acceptedTime
          : acceptedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      orderTotal: freezed == orderTotal
          ? _value.orderTotal
          : orderTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      paymentCompleted: freezed == paymentCompleted
          ? _value.paymentCompleted
          : paymentCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      orderStatus: freezed == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      orderAccepted: freezed == orderAccepted
          ? _value.orderAccepted
          : orderAccepted // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'oid') String? id,
      @JsonKey(name: 'accepted_time') DateTime? acceptedTime,
      @JsonKey(name: 'order_total') double? orderTotal,
      @JsonKey(name: 'payment_completed') bool? paymentCompleted,
      @JsonKey(name: 'order_status') int? orderStatus,
      @JsonKey(name: 'order_accepted') int? orderAccepted});
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? acceptedTime = freezed,
    Object? orderTotal = freezed,
    Object? paymentCompleted = freezed,
    Object? orderStatus = freezed,
    Object? orderAccepted = freezed,
  }) {
    return _then(_$OrderImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptedTime: freezed == acceptedTime
          ? _value.acceptedTime
          : acceptedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      orderTotal: freezed == orderTotal
          ? _value.orderTotal
          : orderTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      paymentCompleted: freezed == paymentCompleted
          ? _value.paymentCompleted
          : paymentCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      orderStatus: freezed == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      orderAccepted: freezed == orderAccepted
          ? _value.orderAccepted
          : orderAccepted // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TimestampConverter()
class _$OrderImpl implements _Order {
  const _$OrderImpl(
      {@JsonKey(name: 'oid') this.id,
      @JsonKey(name: 'accepted_time') this.acceptedTime,
      @JsonKey(name: 'order_total') this.orderTotal,
      @JsonKey(name: 'payment_completed') this.paymentCompleted,
      @JsonKey(name: 'order_status') this.orderStatus,
      @JsonKey(name: 'order_accepted') this.orderAccepted});

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  @JsonKey(name: 'oid')
  final String? id;
  @override
  @JsonKey(name: 'accepted_time')
  final DateTime? acceptedTime;
  @override
  @JsonKey(name: 'order_total')
  final double? orderTotal;
  @override
  @JsonKey(name: 'payment_completed')
  final bool? paymentCompleted;
  @override
  @JsonKey(name: 'order_status')
  final int? orderStatus;
  @override
  @JsonKey(name: 'order_accepted')
  final int? orderAccepted;

  @override
  String toString() {
    return 'Order(id: $id, acceptedTime: $acceptedTime, orderTotal: $orderTotal, paymentCompleted: $paymentCompleted, orderStatus: $orderStatus, orderAccepted: $orderAccepted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.acceptedTime, acceptedTime) ||
                other.acceptedTime == acceptedTime) &&
            (identical(other.orderTotal, orderTotal) ||
                other.orderTotal == orderTotal) &&
            (identical(other.paymentCompleted, paymentCompleted) ||
                other.paymentCompleted == paymentCompleted) &&
            (identical(other.orderStatus, orderStatus) ||
                other.orderStatus == orderStatus) &&
            (identical(other.orderAccepted, orderAccepted) ||
                other.orderAccepted == orderAccepted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, acceptedTime, orderTotal,
      paymentCompleted, orderStatus, orderAccepted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  const factory _Order(
      {@JsonKey(name: 'oid') final String? id,
      @JsonKey(name: 'accepted_time') final DateTime? acceptedTime,
      @JsonKey(name: 'order_total') final double? orderTotal,
      @JsonKey(name: 'payment_completed') final bool? paymentCompleted,
      @JsonKey(name: 'order_status') final int? orderStatus,
      @JsonKey(name: 'order_accepted') final int? orderAccepted}) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  @JsonKey(name: 'oid')
  String? get id;
  @override
  @JsonKey(name: 'accepted_time')
  DateTime? get acceptedTime;
  @override
  @JsonKey(name: 'order_total')
  double? get orderTotal;
  @override
  @JsonKey(name: 'payment_completed')
  bool? get paymentCompleted;
  @override
  @JsonKey(name: 'order_status')
  int? get orderStatus;
  @override
  @JsonKey(name: 'order_accepted')
  int? get orderAccepted;
  @override
  @JsonKey(ignore: true)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
