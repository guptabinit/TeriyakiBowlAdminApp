// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RefundImpl _$$RefundImplFromJson(Map<String, dynamic> json) => _$RefundImpl(
      transactionResponse: json['transactionResponse'] == null
          ? null
          : TransactionResponse.fromJson(
              json['transactionResponse'] as Map<String, dynamic>),
      refId: json['refId'] as String?,
      messages: json['messages'] == null
          ? null
          : Messages.fromJson(json['messages'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RefundImplToJson(_$RefundImpl instance) =>
    <String, dynamic>{
      'transactionResponse': instance.transactionResponse,
      'refId': instance.refId,
      'messages': instance.messages,
    };

_$TransactionResponseImpl _$$TransactionResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionResponseImpl(
      responseCode: json['responseCode'] as String?,
      authCode: json['authCode'] as String?,
      avsResultCode: json['avsResultCode'] as String?,
      cvvResultCode: json['cvvResultCode'] as String?,
      cavvResultCode: json['cavvResultCode'] as String?,
      transId: json['transId'] as String?,
      refTransID: json['refTransID'] as String?,
      transHash: json['transHash'] as String?,
      accountNumber: json['accountNumber'] as String?,
      accountType: json['accountType'] as String?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => Error.fromJson(e as Map<String, dynamic>))
          .toList(),
      SupplementalDataQualificationIndicator:
          json['SupplementalDataQualificationIndicator'] as num?,
    );

Map<String, dynamic> _$$TransactionResponseImplToJson(
        _$TransactionResponseImpl instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'authCode': instance.authCode,
      'avsResultCode': instance.avsResultCode,
      'cvvResultCode': instance.cvvResultCode,
      'cavvResultCode': instance.cavvResultCode,
      'transId': instance.transId,
      'refTransID': instance.refTransID,
      'transHash': instance.transHash,
      'accountNumber': instance.accountNumber,
      'accountType': instance.accountType,
      'messages': instance.messages,
      'errors': instance.errors,
      'SupplementalDataQualificationIndicator':
          instance.SupplementalDataQualificationIndicator,
    };

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      code: json['code'] as String?,
      text: json['text'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'text': instance.text,
      'description': instance.description,
    };

_$MessagesImpl _$$MessagesImplFromJson(Map<String, dynamic> json) =>
    _$MessagesImpl(
      resultCode: json['resultCode'] as String?,
      message: (json['message'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MessagesImplToJson(_$MessagesImpl instance) =>
    <String, dynamic>{
      'resultCode': instance.resultCode,
      'message': instance.message,
    };

_$ErrorImpl _$$ErrorImplFromJson(Map<String, dynamic> json) => _$ErrorImpl(
      errorCode: json['errorCode'] as String?,
      errorText: json['errorText'] as String?,
    );

Map<String, dynamic> _$$ErrorImplToJson(_$ErrorImpl instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorText': instance.errorText,
    };
