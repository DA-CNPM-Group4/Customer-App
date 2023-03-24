class UnexpectedException implements Exception {
  const UnexpectedException(
      {this.debugMessage = "Unexprected exception",
      this.context = "unknown",
      this.message});

  final String? message;
  final String? debugMessage;
  final String? context;

  @override
  String toString() {
    String result = message ?? "Something went wrong! Contact the owner";
    if (debugMessage is String) {
      print('$context: $debugMessage');
    }
    return result;
  }
}
