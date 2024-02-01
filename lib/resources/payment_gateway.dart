import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:http/http.dart' as http;
import 'package:teriyaki_bowl_admin_app/models/refund.dart';

@immutable
class PaymentGateway {
  PaymentGateway({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  Future<Refund> refund({
    required String refTransId,
    required String cardNumber,
    required double amount,
  }) async {
    final refundRequest = Uri.https(
      _baseUrl,
      'xml/v1/request.api',
    );

    final refundResponse = await _httpClient.post(
      refundRequest,
      body: jsonEncode(
        {
          "createTransactionRequest": {
            "merchantAuthentication": {
              "name": name,
              "transactionKey": transactionKey,
            },
            "refId": refId,
            "transactionRequest": {
              "transactionType": "refundTransaction",
              "amount": "$amount",
              "payment": {
                "creditCard": {
                  "cardNumber": cardNumber,
                  "expirationDate": "XXXX",
                }
              },
              "refTransId": refTransId,
            }
          },
        },
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (refundResponse.statusCode != 200) {
      throw PaymentGatewayFailure.fromCode('refund_transaction');
    }

    return Refund.fromJson(jsonDecode(refundResponse.body));
  }

  static const String name =
      '3ujXYX5w7s'; // '5KP3u95bQpv', //'3ujXYX5w7s', (live)
  static const String transactionKey =
      '99RA628ynSA3Uw9n'; //'346HZ32z3fP4hTG2', //'99RA628ynSA3Uw9n', (live)
  static const String refId = '8582957'; // '123456' //'8582957', (live)

  static const String _baseUrl =
      'api.authorize.net'; // sandbox - 'apitest.authorize.net', Live - api.authorize.net;

  final http.Client _httpClient;
}

@immutable
class PaymentGatewayFailure implements Exception {
  const PaymentGatewayFailure([
    this.message = 'Payment gateway failed',
  ]);

  factory PaymentGatewayFailure.fromCode(String code) {
    switch (code) {
      case 'refund_transaction':
        return const PaymentGatewayFailure('Refund transaction failed');
      default:
        return const PaymentGatewayFailure('Payment gateway failed');
    }
  }

  final String message;
}
