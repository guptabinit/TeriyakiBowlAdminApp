import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nanoid/nanoid.dart';
import 'package:teriyaki_bowl_admin_app/models/doordash/quote_response.dart';
import 'package:teriyaki_bowl_admin_app/utils/jwt.dart';

class DoordashApiClient {
  DoordashApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<QuoteResponse> getDeliveryInfo(String deliveryId) async {
    final getDeliveryInfoRequest = Uri.https(
      _baseUrlDoorDash,
      '/drive/v2/deliveries/$deliveryId',
    );

    final token = generateJwt();

    final getDeliveryInfoResponse = await _httpClient.get(
      getDeliveryInfoRequest,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept-Language': "en-US,en;q=0.9",
        "Accept-Encoding": "deflate, compress",
      },
    );

    final getDeliveryJson = jsonDecode(getDeliveryInfoResponse.body);

    switch (getDeliveryInfoResponse.statusCode) {
      case 200:
        return QuoteResponse.fromJson(
          getDeliveryJson as Map<String, dynamic>,
        );
      case 400:
        if (!getDeliveryJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final errors = getDeliveryJson["field_errors"] as List;
        if (errors.isEmpty) {
          throw const FormatException('Something went wrong!');
        }
        final message = errors.map((e) => e["error"]).join(". ");
        throw FormatException(message);
      case 401:
        if (!getDeliveryJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = getDeliveryJson["message"] ?? "Something went wrong!";
        throw FormatException(message);
      case 403:
        if (!getDeliveryJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = getDeliveryJson["message"] ?? "Something went wrong!";
        throw Exception(message);
      case 409:
        if (!getDeliveryJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = getDeliveryJson["message"] ?? "Something went wrong!";
        throw FormatException(message);
      case 422:
        if (!getDeliveryJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = getDeliveryJson["message"] ?? "Something went wrong!";
        throw FormatException(message);
      case 500:
        if (!getDeliveryJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = getDeliveryJson["message"] ?? "Something went wrong!";
        throw FormatException(message);
      default:
        throw const FormatException('Something went wrong!');
    }
  }

  Future<QuoteResponse> createDelivery({
    required String pickupAddress,
    required String pickupBusinessName,
    required String pickupPhoneNumber,
    required String dropoffAddress,
    required String dropoffBusinessName,
    required String dropoffPhoneNumber,
    required String dropoffContactGivenName,
    required int orderValue,
    required double latitude,
    required double longitude,
    required List<Item> items,
  }) async {
    final createQuoteRequest = Uri.https(
      _baseUrlDoorDash,
      '/drive/v2/deliveries',
    );

    final token = generateJwt();

    final createQuoteResponse = await _httpClient.post(
      createQuoteRequest,
      body: jsonEncode(
        {
          "external_delivery_id": "WB-${nanoid(8)}",
          "locale": "en-US",
          "order_fulfillment_method": "standard",
          "pickup_address": pickupAddress,
          "pickup_business_name": pickupBusinessName,
          "pickup_phone_number": pickupPhoneNumber,
          "pickup_instructions":
              "Come inside the store and ask for the order with Delivery ID",
          "dropoff_address": dropoffAddress,
          "dropoff_business_name": dropoffBusinessName,
          "dropoff_location": {
            "lat": latitude,
            "lng": longitude,
          },
          "dropoff_phone_number": dropoffPhoneNumber,
          "dropoff_contact_given_name": dropoffContactGivenName,
          "dropoff_contact_send_notifications": true,
          "contactless_dropoff": false,
          "order_value": orderValue * 100,
          "action_if_undeliverable": "return_to_pickup",
          "order_contains": {
            "alcohol": false,
          },
          "items": items,
        },
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        "Accept-Language": "en-US,en;q=0.9",
        "Accept-Encoding": "deflate, compress",
      },
    );

    final createQuoteJson = jsonDecode(createQuoteResponse.body) as Map;

    switch (createQuoteResponse.statusCode) {
      case 200:
        return QuoteResponse.fromJson(
          createQuoteJson as Map<String, dynamic>,
        );
      case 400:
        if (!createQuoteJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final errors = createQuoteJson["field_errors"] as List;
        if (errors.isEmpty) {
          throw const FormatException('Something went wrong!');
        }
        final message = errors.map((e) => e["error"]).join(". ");
        throw FormatException(message);
      case 401:
        if (!createQuoteJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = createQuoteJson["message"] ?? "Something went wrong!";
        throw FormatException(message);
      case 403:
        if (!createQuoteJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = createQuoteJson["message"] ?? "Something went wrong!";
        throw Exception(message);
      case 409:
        if (!createQuoteJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = createQuoteJson["message"] ?? "Something went wrong!";
        throw FormatException(message);
      case 422:
        if (!createQuoteJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = createQuoteJson["message"] ?? "Something went wrong!";
        throw FormatException(message);
      case 500:
        if (!createQuoteJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = createQuoteJson["message"] ?? "Something went wrong!";
        throw FormatException(message);
      default:
        throw const FormatException('Something went wrong!');
    }
  }

  Future<QuoteResponse> cancelDelivery(String deliveryId) async {
    final createQuoteRequest = Uri.https(
      _baseUrlDoorDash,
      '/drive/v2/deliveries/$deliveryId/cancel',
    );

    final token = generateJwt();

    final createQuoteResponse = await _httpClient.put(
      createQuoteRequest,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        "Accept-Language": "en-US,en;q=0.9",
        "Accept-Encoding": "deflate, compress",
      },
    );

    final createQuoteJson = jsonDecode(createQuoteResponse.body) as Map;

    switch (createQuoteResponse.statusCode) {
      case 200:
        return QuoteResponse.fromJson(
          createQuoteJson as Map<String, dynamic>,
        );
      case 400:
        if (!createQuoteJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final errors = createQuoteJson["field_errors"] as List;
        if (errors.isEmpty) {
          throw const FormatException('Something went wrong!');
        }
        final message = errors.map((e) => e["error"]).join(". ");
        throw FormatException(message);
      case 401:
        if (!createQuoteJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = createQuoteJson["message"] ?? "Something went wrong!";
        throw FormatException(message);
      case 403:
        if (!createQuoteJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = createQuoteJson["message"] ?? "Something went wrong!";
        throw Exception(message);
      case 409:
        if (!createQuoteJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = createQuoteJson["message"] ?? "Something went wrong!";
        throw FormatException(message);
      case 422:
        if (!createQuoteJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = createQuoteJson["message"] ?? "Something went wrong!";
        throw FormatException(message);
      case 500:
        if (!createQuoteJson.containsKey("code")) {
          throw const FormatException('Something went wrong!');
        }
        final message = createQuoteJson["message"] ?? "Something went wrong!";
        throw FormatException(message);
      default:
        throw const FormatException('Something went wrong!');
    }
  }

  static const _baseUrlDoorDash = 'openapi.doordash.com';

  final http.Client _httpClient;
}
