import 'package:json_annotation/json_annotation.dart';

part 'firestore_chat.g.dart';

@JsonSerializable()
class FirestoreChatModel {
  final String createTime;
  final String driverId;
  final String passengerId;

  FirestoreChatModel({
    required this.createTime,
    required this.driverId,
    required this.passengerId,
  });

  factory FirestoreChatModel.fromJson(Map<String, dynamic> json) =>
      _$FirestoreChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$FirestoreChatModelToJson(this);
}
