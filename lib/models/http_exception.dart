class HttpException implements Exception {
  final String message;
  final int statusCode;

  HttpException(this.message, this.statusCode);

  @override
  String toString() {
    return "Error: ${statusCode}\n${message}";
    // return super.toString(); / Instance of HttpException
  }
}
