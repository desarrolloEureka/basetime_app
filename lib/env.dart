class Env {
  /// Wompi
  static const testPublicKey = String.fromEnvironment(
    'test_public_key',
    defaultValue: 'pub_test_ghV85YqU2lg0FekOU0EVKMwxSSjwDO83',
  );
  static const testSecretKey = String.fromEnvironment(
    'test_secret_key',
    defaultValue: 'prv_test_H8mz1Td8qlhK7HE3KSrQdePJb00MU3eX',
  );
  static const testEvents = String.fromEnvironment(
    'test_events',
    defaultValue: 'test_events_1HyGYz4MhW9pLjOxM9Lzk1q2taOLNFFM',
  );
  static const testIntegrity = String.fromEnvironment(
    'test_integrity',
    defaultValue: 'test_integrity_WEMSeZ4iyicCARsELZs28RbjJK7vmuDp',
  );
}
