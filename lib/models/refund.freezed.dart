// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refund.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Refund _$RefundFromJson(Map<String, dynamic> json) {
  return _Refund.fromJson(json);
}

/// @nodoc
mixin _$Refund {
  TransactionResponse? get transactionResponse =>
      throw _privateConstructorUsedError;
  String? get refId => throw _privateConstructorUsedError;
  Messages? get messages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RefundCopyWith<Refund> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefundCopyWith<$Res> {
  factory $RefundCopyWith(Refund value, $Res Function(Refund) then) =
      _$RefundCopyWithImpl<$Res, Refund>;
  @useResult
  $Res call(
      {TransactionResponse? transactionResponse,
      String? refId,
      Messages? messages});

  $TransactionResponseCopyWith<$Res>? get transactionResponse;
  $MessagesCopyWith<$Res>? get messages;
}

/// @nodoc
class _$RefundCopyWithImpl<$Res, $Val extends Refund>
    implements $RefundCopyWith<$Res> {
  _$RefundCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionResponse = freezed,
    Object? refId = freezed,
    Object? messages = freezed,
  }) {
    return _then(_value.copyWith(
      transactionResponse: freezed == transactionResponse
          ? _value.transactionResponse
          : transactionResponse // ignore: cast_nullable_to_non_nullable
              as TransactionResponse?,
      refId: freezed == refId
          ? _value.refId
          : refId // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as Messages?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionResponseCopyWith<$Res>? get transactionResponse {
    if (_value.transactionResponse == null) {
      return null;
    }

    return $TransactionResponseCopyWith<$Res>(_value.transactionResponse!,
        (value) {
      return _then(_value.copyWith(transactionResponse: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MessagesCopyWith<$Res>? get messages {
    if (_value.messages == null) {
      return null;
    }

    return $MessagesCopyWith<$Res>(_value.messages!, (value) {
      return _then(_value.copyWith(messages: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RefundImplCopyWith<$Res> implements $RefundCopyWith<$Res> {
  factory _$$RefundImplCopyWith(
          _$RefundImpl value, $Res Function(_$RefundImpl) then) =
      __$$RefundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TransactionResponse? transactionResponse,
      String? refId,
      Messages? messages});

  @override
  $TransactionResponseCopyWith<$Res>? get transactionResponse;
  @override
  $MessagesCopyWith<$Res>? get messages;
}

/// @nodoc
class __$$RefundImplCopyWithImpl<$Res>
    extends _$RefundCopyWithImpl<$Res, _$RefundImpl>
    implements _$$RefundImplCopyWith<$Res> {
  __$$RefundImplCopyWithImpl(
      _$RefundImpl _value, $Res Function(_$RefundImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionResponse = freezed,
    Object? refId = freezed,
    Object? messages = freezed,
  }) {
    return _then(_$RefundImpl(
      transactionResponse: freezed == transactionResponse
          ? _value.transactionResponse
          : transactionResponse // ignore: cast_nullable_to_non_nullable
              as TransactionResponse?,
      refId: freezed == refId
          ? _value.refId
          : refId // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as Messages?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RefundImpl implements _Refund {
  const _$RefundImpl({this.transactionResponse, this.refId, this.messages});

  factory _$RefundImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefundImplFromJson(json);

  @override
  final TransactionResponse? transactionResponse;
  @override
  final String? refId;
  @override
  final Messages? messages;

  @override
  String toString() {
    return 'Refund(transactionResponse: $transactionResponse, refId: $refId, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefundImpl &&
            (identical(other.transactionResponse, transactionResponse) ||
                other.transactionResponse == transactionResponse) &&
            (identical(other.refId, refId) || other.refId == refId) &&
            (identical(other.messages, messages) ||
                other.messages == messages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, transactionResponse, refId, messages);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RefundImplCopyWith<_$RefundImpl> get copyWith =>
      __$$RefundImplCopyWithImpl<_$RefundImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RefundImplToJson(
      this,
    );
  }
}

abstract class _Refund implements Refund {
  const factory _Refund(
      {final TransactionResponse? transactionResponse,
      final String? refId,
      final Messages? messages}) = _$RefundImpl;

  factory _Refund.fromJson(Map<String, dynamic> json) = _$RefundImpl.fromJson;

  @override
  TransactionResponse? get transactionResponse;
  @override
  String? get refId;
  @override
  Messages? get messages;
  @override
  @JsonKey(ignore: true)
  _$$RefundImplCopyWith<_$RefundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) {
  return _TransactionResponse.fromJson(json);
}

/// @nodoc
mixin _$TransactionResponse {
  String? get responseCode => throw _privateConstructorUsedError;
  String? get authCode => throw _privateConstructorUsedError;
  String? get avsResultCode => throw _privateConstructorUsedError;
  String? get cvvResultCode => throw _privateConstructorUsedError;
  String? get cavvResultCode => throw _privateConstructorUsedError;
  String? get transId => throw _privateConstructorUsedError;
  String? get refTransID => throw _privateConstructorUsedError;
  String? get transHash => throw _privateConstructorUsedError;
  String? get accountNumber => throw _privateConstructorUsedError;
  String? get accountType => throw _privateConstructorUsedError;
  List<Message>? get messages => throw _privateConstructorUsedError;
  List<Error>? get errors => throw _privateConstructorUsedError;
  num? get SupplementalDataQualificationIndicator =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionResponseCopyWith<TransactionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionResponseCopyWith<$Res> {
  factory $TransactionResponseCopyWith(
          TransactionResponse value, $Res Function(TransactionResponse) then) =
      _$TransactionResponseCopyWithImpl<$Res, TransactionResponse>;
  @useResult
  $Res call(
      {String? responseCode,
      String? authCode,
      String? avsResultCode,
      String? cvvResultCode,
      String? cavvResultCode,
      String? transId,
      String? refTransID,
      String? transHash,
      String? accountNumber,
      String? accountType,
      List<Message>? messages,
      List<Error>? errors,
      num? SupplementalDataQualificationIndicator});
}

/// @nodoc
class _$TransactionResponseCopyWithImpl<$Res, $Val extends TransactionResponse>
    implements $TransactionResponseCopyWith<$Res> {
  _$TransactionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseCode = freezed,
    Object? authCode = freezed,
    Object? avsResultCode = freezed,
    Object? cvvResultCode = freezed,
    Object? cavvResultCode = freezed,
    Object? transId = freezed,
    Object? refTransID = freezed,
    Object? transHash = freezed,
    Object? accountNumber = freezed,
    Object? accountType = freezed,
    Object? messages = freezed,
    Object? errors = freezed,
    Object? SupplementalDataQualificationIndicator = freezed,
  }) {
    return _then(_value.copyWith(
      responseCode: freezed == responseCode
          ? _value.responseCode
          : responseCode // ignore: cast_nullable_to_non_nullable
              as String?,
      authCode: freezed == authCode
          ? _value.authCode
          : authCode // ignore: cast_nullable_to_non_nullable
              as String?,
      avsResultCode: freezed == avsResultCode
          ? _value.avsResultCode
          : avsResultCode // ignore: cast_nullable_to_non_nullable
              as String?,
      cvvResultCode: freezed == cvvResultCode
          ? _value.cvvResultCode
          : cvvResultCode // ignore: cast_nullable_to_non_nullable
              as String?,
      cavvResultCode: freezed == cavvResultCode
          ? _value.cavvResultCode
          : cavvResultCode // ignore: cast_nullable_to_non_nullable
              as String?,
      transId: freezed == transId
          ? _value.transId
          : transId // ignore: cast_nullable_to_non_nullable
              as String?,
      refTransID: freezed == refTransID
          ? _value.refTransID
          : refTransID // ignore: cast_nullable_to_non_nullable
              as String?,
      transHash: freezed == transHash
          ? _value.transHash
          : transHash // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      accountType: freezed == accountType
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>?,
      errors: freezed == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<Error>?,
      SupplementalDataQualificationIndicator: freezed ==
              SupplementalDataQualificationIndicator
          ? _value.SupplementalDataQualificationIndicator
          : SupplementalDataQualificationIndicator // ignore: cast_nullable_to_non_nullable
              as num?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionResponseImplCopyWith<$Res>
    implements $TransactionResponseCopyWith<$Res> {
  factory _$$TransactionResponseImplCopyWith(_$TransactionResponseImpl value,
          $Res Function(_$TransactionResponseImpl) then) =
      __$$TransactionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? responseCode,
      String? authCode,
      String? avsResultCode,
      String? cvvResultCode,
      String? cavvResultCode,
      String? transId,
      String? refTransID,
      String? transHash,
      String? accountNumber,
      String? accountType,
      List<Message>? messages,
      List<Error>? errors,
      num? SupplementalDataQualificationIndicator});
}

/// @nodoc
class __$$TransactionResponseImplCopyWithImpl<$Res>
    extends _$TransactionResponseCopyWithImpl<$Res, _$TransactionResponseImpl>
    implements _$$TransactionResponseImplCopyWith<$Res> {
  __$$TransactionResponseImplCopyWithImpl(_$TransactionResponseImpl _value,
      $Res Function(_$TransactionResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseCode = freezed,
    Object? authCode = freezed,
    Object? avsResultCode = freezed,
    Object? cvvResultCode = freezed,
    Object? cavvResultCode = freezed,
    Object? transId = freezed,
    Object? refTransID = freezed,
    Object? transHash = freezed,
    Object? accountNumber = freezed,
    Object? accountType = freezed,
    Object? messages = freezed,
    Object? errors = freezed,
    Object? SupplementalDataQualificationIndicator = freezed,
  }) {
    return _then(_$TransactionResponseImpl(
      responseCode: freezed == responseCode
          ? _value.responseCode
          : responseCode // ignore: cast_nullable_to_non_nullable
              as String?,
      authCode: freezed == authCode
          ? _value.authCode
          : authCode // ignore: cast_nullable_to_non_nullable
              as String?,
      avsResultCode: freezed == avsResultCode
          ? _value.avsResultCode
          : avsResultCode // ignore: cast_nullable_to_non_nullable
              as String?,
      cvvResultCode: freezed == cvvResultCode
          ? _value.cvvResultCode
          : cvvResultCode // ignore: cast_nullable_to_non_nullable
              as String?,
      cavvResultCode: freezed == cavvResultCode
          ? _value.cavvResultCode
          : cavvResultCode // ignore: cast_nullable_to_non_nullable
              as String?,
      transId: freezed == transId
          ? _value.transId
          : transId // ignore: cast_nullable_to_non_nullable
              as String?,
      refTransID: freezed == refTransID
          ? _value.refTransID
          : refTransID // ignore: cast_nullable_to_non_nullable
              as String?,
      transHash: freezed == transHash
          ? _value.transHash
          : transHash // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      accountType: freezed == accountType
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: freezed == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>?,
      errors: freezed == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<Error>?,
      SupplementalDataQualificationIndicator: freezed ==
              SupplementalDataQualificationIndicator
          ? _value.SupplementalDataQualificationIndicator
          : SupplementalDataQualificationIndicator // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionResponseImpl implements _TransactionResponse {
  const _$TransactionResponseImpl(
      {this.responseCode,
      this.authCode,
      this.avsResultCode,
      this.cvvResultCode,
      this.cavvResultCode,
      this.transId,
      this.refTransID,
      this.transHash,
      this.accountNumber,
      this.accountType,
      final List<Message>? messages,
      final List<Error>? errors,
      this.SupplementalDataQualificationIndicator})
      : _messages = messages,
        _errors = errors;

  factory _$TransactionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionResponseImplFromJson(json);

  @override
  final String? responseCode;
  @override
  final String? authCode;
  @override
  final String? avsResultCode;
  @override
  final String? cvvResultCode;
  @override
  final String? cavvResultCode;
  @override
  final String? transId;
  @override
  final String? refTransID;
  @override
  final String? transHash;
  @override
  final String? accountNumber;
  @override
  final String? accountType;
  final List<Message>? _messages;
  @override
  List<Message>? get messages {
    final value = _messages;
    if (value == null) return null;
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Error>? _errors;
  @override
  List<Error>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final num? SupplementalDataQualificationIndicator;

  @override
  String toString() {
    return 'TransactionResponse(responseCode: $responseCode, authCode: $authCode, avsResultCode: $avsResultCode, cvvResultCode: $cvvResultCode, cavvResultCode: $cavvResultCode, transId: $transId, refTransID: $refTransID, transHash: $transHash, accountNumber: $accountNumber, accountType: $accountType, messages: $messages, errors: $errors, SupplementalDataQualificationIndicator: $SupplementalDataQualificationIndicator)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionResponseImpl &&
            (identical(other.responseCode, responseCode) ||
                other.responseCode == responseCode) &&
            (identical(other.authCode, authCode) ||
                other.authCode == authCode) &&
            (identical(other.avsResultCode, avsResultCode) ||
                other.avsResultCode == avsResultCode) &&
            (identical(other.cvvResultCode, cvvResultCode) ||
                other.cvvResultCode == cvvResultCode) &&
            (identical(other.cavvResultCode, cavvResultCode) ||
                other.cavvResultCode == cavvResultCode) &&
            (identical(other.transId, transId) || other.transId == transId) &&
            (identical(other.refTransID, refTransID) ||
                other.refTransID == refTransID) &&
            (identical(other.transHash, transHash) ||
                other.transHash == transHash) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountType, accountType) ||
                other.accountType == accountType) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.SupplementalDataQualificationIndicator,
                    SupplementalDataQualificationIndicator) ||
                other.SupplementalDataQualificationIndicator ==
                    SupplementalDataQualificationIndicator));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      responseCode,
      authCode,
      avsResultCode,
      cvvResultCode,
      cavvResultCode,
      transId,
      refTransID,
      transHash,
      accountNumber,
      accountType,
      const DeepCollectionEquality().hash(_messages),
      const DeepCollectionEquality().hash(_errors),
      SupplementalDataQualificationIndicator);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionResponseImplCopyWith<_$TransactionResponseImpl> get copyWith =>
      __$$TransactionResponseImplCopyWithImpl<_$TransactionResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionResponseImplToJson(
      this,
    );
  }
}

abstract class _TransactionResponse implements TransactionResponse {
  const factory _TransactionResponse(
          {final String? responseCode,
          final String? authCode,
          final String? avsResultCode,
          final String? cvvResultCode,
          final String? cavvResultCode,
          final String? transId,
          final String? refTransID,
          final String? transHash,
          final String? accountNumber,
          final String? accountType,
          final List<Message>? messages,
          final List<Error>? errors,
          final num? SupplementalDataQualificationIndicator}) =
      _$TransactionResponseImpl;

  factory _TransactionResponse.fromJson(Map<String, dynamic> json) =
      _$TransactionResponseImpl.fromJson;

  @override
  String? get responseCode;
  @override
  String? get authCode;
  @override
  String? get avsResultCode;
  @override
  String? get cvvResultCode;
  @override
  String? get cavvResultCode;
  @override
  String? get transId;
  @override
  String? get refTransID;
  @override
  String? get transHash;
  @override
  String? get accountNumber;
  @override
  String? get accountType;
  @override
  List<Message>? get messages;
  @override
  List<Error>? get errors;
  @override
  num? get SupplementalDataQualificationIndicator;
  @override
  @JsonKey(ignore: true)
  _$$TransactionResponseImplCopyWith<_$TransactionResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String? get code => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call({String? code, String? text, String? description});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? text = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? text, String? description});
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? text = freezed,
    Object? description = freezed,
  }) {
    return _then(_$MessageImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl({this.code, this.text, this.description});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final String? code;
  @override
  final String? text;
  @override
  final String? description;

  @override
  String toString() {
    return 'Message(code: $code, text: $text, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, text, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {final String? code,
      final String? text,
      final String? description}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  String? get code;
  @override
  String? get text;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Messages _$MessagesFromJson(Map<String, dynamic> json) {
  return _Messages.fromJson(json);
}

/// @nodoc
mixin _$Messages {
  String? get resultCode => throw _privateConstructorUsedError;
  List<Message>? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessagesCopyWith<Messages> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagesCopyWith<$Res> {
  factory $MessagesCopyWith(Messages value, $Res Function(Messages) then) =
      _$MessagesCopyWithImpl<$Res, Messages>;
  @useResult
  $Res call({String? resultCode, List<Message>? message});
}

/// @nodoc
class _$MessagesCopyWithImpl<$Res, $Val extends Messages>
    implements $MessagesCopyWith<$Res> {
  _$MessagesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultCode = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      resultCode: freezed == resultCode
          ? _value.resultCode
          : resultCode // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as List<Message>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessagesImplCopyWith<$Res>
    implements $MessagesCopyWith<$Res> {
  factory _$$MessagesImplCopyWith(
          _$MessagesImpl value, $Res Function(_$MessagesImpl) then) =
      __$$MessagesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? resultCode, List<Message>? message});
}

/// @nodoc
class __$$MessagesImplCopyWithImpl<$Res>
    extends _$MessagesCopyWithImpl<$Res, _$MessagesImpl>
    implements _$$MessagesImplCopyWith<$Res> {
  __$$MessagesImplCopyWithImpl(
      _$MessagesImpl _value, $Res Function(_$MessagesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultCode = freezed,
    Object? message = freezed,
  }) {
    return _then(_$MessagesImpl(
      resultCode: freezed == resultCode
          ? _value.resultCode
          : resultCode // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value._message
          : message // ignore: cast_nullable_to_non_nullable
              as List<Message>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessagesImpl implements _Messages {
  const _$MessagesImpl({this.resultCode, final List<Message>? message})
      : _message = message;

  factory _$MessagesImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessagesImplFromJson(json);

  @override
  final String? resultCode;
  final List<Message>? _message;
  @override
  List<Message>? get message {
    final value = _message;
    if (value == null) return null;
    if (_message is EqualUnmodifiableListView) return _message;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Messages(resultCode: $resultCode, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagesImpl &&
            (identical(other.resultCode, resultCode) ||
                other.resultCode == resultCode) &&
            const DeepCollectionEquality().equals(other._message, _message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, resultCode, const DeepCollectionEquality().hash(_message));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagesImplCopyWith<_$MessagesImpl> get copyWith =>
      __$$MessagesImplCopyWithImpl<_$MessagesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessagesImplToJson(
      this,
    );
  }
}

abstract class _Messages implements Messages {
  const factory _Messages(
      {final String? resultCode,
      final List<Message>? message}) = _$MessagesImpl;

  factory _Messages.fromJson(Map<String, dynamic> json) =
      _$MessagesImpl.fromJson;

  @override
  String? get resultCode;
  @override
  List<Message>? get message;
  @override
  @JsonKey(ignore: true)
  _$$MessagesImplCopyWith<_$MessagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Error _$ErrorFromJson(Map<String, dynamic> json) {
  return _Error.fromJson(json);
}

/// @nodoc
mixin _$Error {
  String? get errorCode => throw _privateConstructorUsedError;
  String? get errorText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res, Error>;
  @useResult
  $Res call({String? errorCode, String? errorText});
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res, $Val extends Error>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorCode = freezed,
    Object? errorText = freezed,
  }) {
    return _then(_value.copyWith(
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
      errorText: freezed == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> implements $ErrorCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? errorCode, String? errorText});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ErrorCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorCode = freezed,
    Object? errorText = freezed,
  }) {
    return _then(_$ErrorImpl(
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
      errorText: freezed == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorImpl implements _Error {
  const _$ErrorImpl({this.errorCode, this.errorText});

  factory _$ErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorImplFromJson(json);

  @override
  final String? errorCode;
  @override
  final String? errorText;

  @override
  String toString() {
    return 'Error(errorCode: $errorCode, errorText: $errorText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, errorCode, errorText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorImplToJson(
      this,
    );
  }
}

abstract class _Error implements Error {
  const factory _Error({final String? errorCode, final String? errorText}) =
      _$ErrorImpl;

  factory _Error.fromJson(Map<String, dynamic> json) = _$ErrorImpl.fromJson;

  @override
  String? get errorCode;
  @override
  String? get errorText;
  @override
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
