class NetworkException implements Exception {
  final String? details;

  const NetworkException([this.details]);

  @override
  String toString() => 'NetworkException: $details';
}

class TooManyRequestsException extends NetworkException {
  const TooManyRequestsException() : super('Too many requests (429)');
}
