import 'package:jose/jose.dart';

String generateJwt() {
  final currentTimer = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  final claims = JsonWebTokenClaims.fromJson({
    "aud": "doordash",
    "iss": 'fc160dbc-9283-4e26-b568-9ee0efd384fc',
    // "fc160dbc-9283-4e26-b568-9ee0efd384fc" = Live,
    // "fc160dbc-9283-4e26-b568-9ee0efd384fc" = Sandbox,
    "kid": '0b863bc5-41d3-420d-b9c6-58560e6bd961',
    // "0b863bc5-41d3-420d-b9c6-58560e6bd961" - Live,
    // "84437014-fe30-4a75-b931-62a8c60a07d9" - Sandbox,
    "iat": currentTimer,
    "exp": currentTimer + 1800,
  });

  final builder = JsonWebSignatureBuilder();

  builder.jsonContent = claims.toJson();

  builder.setProtectedHeader("typ", "JWT");
  builder.setProtectedHeader("dd-ver", "DD-JWT-V1");

  builder.addRecipient(
    JsonWebKey.fromJson(
      {
        "kty": "oct",
        "k": 'wFhHqQ8AvqlMex3FU6x2-CZ13KiB6fdtnCEUTkNoWr8'
        // "wFhHqQ8AvqlMex3FU6x2-CZ13KiB6fdtnCEUTkNoWr8" - Live,
        // "UMITk03e1-EldszRof6ZqI2QeduL7mgSONjcIrDGXUs" - Sandbox,
      },
    ),
    algorithm: "HS256",
  );

  final jws = builder.build();

  final token = jws.toCompactSerialization();

  return token;
}
