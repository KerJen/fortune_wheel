class NetworkException implements Exception {
  final String? details;

  const NetworkException([this.details]);

  @override
  String toString() => 'NetworkException: $details';
}
