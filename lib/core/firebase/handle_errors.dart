class FirebaseError {
  const FirebaseError({
    required this.code,
    this.message,
  });

  final String code;
  final String? message;
}
