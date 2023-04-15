import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/data/models/realtime_models/firestore_chat.dart';
import 'package:customer_app/data/models/realtime_models/firestore_message.dart';
import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class FireStoreDatabaseService {
  static FireStoreDatabaseService? _instance;

  static FireStoreDatabaseService get instance {
    return _instance ??= FireStoreDatabaseService();
  }

  FirebaseFirestore database = FirebaseFirestore.instance;

  Future<void> createChat({
    required FirestoreChatModel data,
    required String tripId,
  }) async {
    await database
        .collection(FirestoreDatabasePath.chat)
        .doc(tripId)
        .set(data.toJson())
        .onError(
          (error, stackTrace) => throw IBussinessException(
            "Cannot Setup Chat",
            debugMessage: error.toString(),
            place: "Firestore-set-chat",
          ),
        );
  }

  Future<void> sendMessage({
    required FirestoreMessageModel data,
    required String tripId,
  }) async {
    CollectionReference messages = database
        .collection(FirestoreDatabasePath.chat)
        .doc(tripId)
        .collection(FirestoreDatabasePath.message);

    await messages.add(data.toJson()).onError(
          (error, stackTrace) => throw IBussinessException(
            "Cannot Send Chat",
            debugMessage: error.toString(),
            place: "Firestore-send-message",
          ),
        );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatStream(
      {required String tripId}) {
    final docRef = database
        .collection(FirestoreDatabasePath.chat)
        .doc(tripId)
        .collection(FirestoreDatabasePath.message);
    return docRef.snapshots();
  }

  Future<void> example() async {
    String id = "test-trip-id";
    String driverId = "aa035210-8fff-482f-5316-08db340feda2";
    String passengerId = "5686df08-cdc0-45a0-a45a-08db257d53cf";
    List<FirestoreMessageModel> chats = [];

    //
    final chatData = FirestoreChatModel(
        driverId: driverId,
        passengerId: passengerId,
        createTime: Utils.currentDateTime);

    try {
      await createChat(tripId: id, data: chatData);
    } catch (e) {
      debugPrint(e.toString());
    }

    Stream<QuerySnapshot<Map<String, dynamic>>> chatStreamController =
        getChatStream(tripId: id);

    final listenChatAgent = chatStreamController.listen((event) {
      for (var docAdd in event.docChanges) {
        if (docAdd.type == DocumentChangeType.added) {
          var chat = FirestoreMessageModel.fromJson(docAdd.doc.data()!);
          chats.add(chat);
        }
        debugPrint(chats.length.toString());
      }
    });

    await _testSendMessage("test 1", driverId, id);
    await _testSendMessage("test 2", driverId, id);
    await _testSendMessage("test 3", driverId, id);

    await listenChatAgent.cancel();

    await _testSendMessage("test 4", driverId, id);
  }

  Future<void> _testSendMessage(
      String content, String driverId, String id) async {
    try {
      final messsage = FirestoreMessageModel(
          date: Utils.currentDateTime,
          message: content,
          senderId: driverId,
          senderName: "Test name");
      await sendMessage(data: messsage, tripId: id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

abstract class FirestoreDatabasePath {
  static const chat = 'Chat';
  static const message = 'messages';
}
