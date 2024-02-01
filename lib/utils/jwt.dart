import 'package:jose/jose.dart';

String generateJwt() {
  final currentTimer = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  final claims = JsonWebTokenClaims.fromJson({
    "aud": "doordash",
    "iss": '2e3be3e9-e42e-446d-909c-ab8bdd60c1d3',
    // "2e3be3e9-e42e-446d-909c-ab8bdd60c1d3" = Live,
    // "2e3be3e9-e42e-446d-909c-ab8bdd60c1d3" = Sandbox,
    "kid": '5e5e5d0d-66d2-4302-b2cb-132cc65d0854',
    // "5e5e5d0d-66d2-4302-b2cb-132cc65d0854" - Live,
    // "af79a37e-39cf-426b-a153-b5826cc2a305" - Sandbox,
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
        "k": "iNUSvPAopv2nC5YCc08dazjHr-c8Benpd18gbYoTPxw",
        // "W6z_poOSWyFNtAgdoPxIeXcJ2hTIxXSeuqTN0TywIbw",
        // Live: "iNUSvPAopv2nC5YCc08dazjHr-c8Benpd18gbYoTPxw"
      },
    ),
    algorithm: "HS256",
  );

  final jws = builder.build();

  final token = jws.toCompactSerialization();

  return token;
}
