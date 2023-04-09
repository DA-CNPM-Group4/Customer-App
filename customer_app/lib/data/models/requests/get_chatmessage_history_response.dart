import 'package:json_annotation/json_annotation.dart';
part 'get_chatmessage_history_response.g.dart';

@JsonSerializable()
class ChatMessageHistoryResponseBody {
  String? tripId;
  String? driverId;
  String? passengerId;
  List<ChatMessageResponseBody>? messages;

  ChatMessageHistoryResponseBody(
      {this.tripId, this.driverId, this.passengerId, this.messages});

  factory ChatMessageHistoryResponseBody.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageHistoryResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageHistoryResponseBodyToJson(this);
}

@JsonSerializable()
class ChatMessageResponseBody {
  final String? tripId;
  final String message;
  final String? senderName;
  final String sendTime;

  ChatMessageResponseBody({
    this.tripId,
    required this.message,
    required this.senderName,
    required this.sendTime,
  });

  factory ChatMessageResponseBody.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageResponseBodyToJson(this);
}
