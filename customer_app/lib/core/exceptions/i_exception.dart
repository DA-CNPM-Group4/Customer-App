class IException implements Exception {
  const IException(this.message,
      {this.debugMessage = "<Debug Message>", this.context = "<Context>"});

  final String? message;
  final String? debugMessage;
  final String? context;

  @override
  String toString() {
    String result = message ?? '<Message-Type>';
    if (debugMessage is String) {
      print('$context: $debugMessage');
    }
    return result;
  }
}
