// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SalesReport _$SalesReportFromJson(Map<String, dynamic> json) {
  return _SalesReport.fromJson(json);
}

/// @nodoc
mixin _$SalesReport {
  double? get totalAmount => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SalesReportCopyWith<SalesReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesReportCopyWith<$Res> {
  factory $SalesReportCopyWith(
          SalesReport value, $Res Function(SalesReport) then) =
      _$SalesReportCopyWithImpl<$Res, SalesReport>;
  @useResult
  $Res call({double? totalAmount, int? count});
}

/// @nodoc
class _$SalesReportCopyWithImpl<$Res, $Val extends SalesReport>
    implements $SalesReportCopyWith<$Res> {
  _$SalesReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAmount = freezed,
    Object? count = freezed,
  }) {
    return _then(_value.copyWith(
      totalAmount: freezed == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalesReportImplCopyWith<$Res>
    implements $SalesReportCopyWith<$Res> {
  factory _$$SalesReportImplCopyWith(
          _$SalesReportImpl value, $Res Function(_$SalesReportImpl) then) =
      __$$SalesReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? totalAmount, int? count});
}

/// @nodoc
class __$$SalesReportImplCopyWithImpl<$Res>
    extends _$SalesReportCopyWithImpl<$Res, _$SalesReportImpl>
    implements _$$SalesReportImplCopyWith<$Res> {
  __$$SalesReportImplCopyWithImpl(
      _$SalesReportImpl _value, $Res Function(_$SalesReportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAmount = freezed,
    Object? count = freezed,
  }) {
    return _then(_$SalesReportImpl(
      totalAmount: freezed == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesReportImpl implements _SalesReport {
  const _$SalesReportImpl({this.totalAmount, this.count});

  factory _$SalesReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesReportImplFromJson(json);

  @override
  final double? totalAmount;
  @override
  final int? count;

  @override
  String toString() {
    return 'SalesReport(totalAmount: $totalAmount, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesReportImpl &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalAmount, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesReportImplCopyWith<_$SalesReportImpl> get copyWith =>
      __$$SalesReportImplCopyWithImpl<_$SalesReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesReportImplToJson(
      this,
    );
  }
}

abstract class _SalesReport implements SalesReport {
  const factory _SalesReport({final double? totalAmount, final int? count}) =
      _$SalesReportImpl;

  factory _SalesReport.fromJson(Map<String, dynamic> json) =
      _$SalesReportImpl.fromJson;

  @override
  double? get totalAmount;
  @override
  int? get count;
  @override
  @JsonKey(ignore: true)
  _$$SalesReportImplCopyWith<_$SalesReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
