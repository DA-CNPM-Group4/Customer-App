import 'package:json_annotation/json_annotation.dart';

part 'firestore_message.g.dart';

@JsonSerializable()
class FirestoreMessageModel {
  String? date;
  final String message;
  final String senderId;
  final String senderName;

  FirestoreMessageModel(
      {this.date,
      required this.message,
      required this.senderId,
      required this.senderName});

  factory FirestoreMessageModel.fromJson(Map<String, dynamic> json) =>
      _$FirestoreMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$FirestoreMessageModelToJson(this);
}
