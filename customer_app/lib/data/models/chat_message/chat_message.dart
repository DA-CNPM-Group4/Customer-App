enum ChatMessageType { passenger, driver }

class ChatMessage {
  final String text;
  final ChatMessageType chatMessageType;

  ChatMessage({required this.text, required this.chatMessageType});
}
