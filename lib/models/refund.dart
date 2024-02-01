import 'package:freezed_annotation/freezed_annotation.dart';

part 'refund.freezed.dart';

part 'refund.g.dart';

@freezed
class Refund with _$Refund {
  const factory Refund({
    TransactionResponse? transactionResponse,
    String? refId,
    Messages? messages,
  }) = _Refund;

  factory Refund.fromJson(Map<String, dynamic> json) => _$RefundFromJson(json);
}

@freezed
class TransactionResponse with _$TransactionResponse {
  const factory TransactionResponse({
    String? responseCode,
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
    num? SupplementalDataQualificationIndicator,
  }) = _TransactionResponse;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);
}

@freezed
class Message with _$Message {
  const factory Message({
    String? code,
    String? text,
    String? description,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@freezed
class Messages with _$Messages {
  const factory Messages({
    String? resultCode,
    List<Message>? message,
  }) = _Messages;

  factory Messages.fromJson(Map<String, dynamic> json) =>
      _$MessagesFromJson(json);
}

@freezed
class Error with _$Error {
  const factory Error({
    String? errorCode,
    String? errorText,
  }) = _Error;

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
}
