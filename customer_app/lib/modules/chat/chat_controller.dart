import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/data/models/chat_message/chat_message.dart';
import 'package:customer_app/data/models/realtime_models/firestore_chat.dart';
import 'package:customer_app/data/models/realtime_models/firestore_message.dart';
import 'package:customer_app/data/services/firestore_database_service.dart';
import 'package:customer_app/core/exceptions/unexpected_exception.dart';
import 'package:customer_app/core/utils/utils.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/modules/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../lifecycle_controller.dart';

class ChatController extends GetxController {
  final LifeCycleController lifeCycleController =
      Get.find<LifeCycleController>();
  final isLoading = false.obs;

  late final UserEntity passengerEntity;
  String? tripId;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  final scrollController = ScrollController();

  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  late Stream<QuerySnapshot<Map<String, dynamic>>> chatStreamController;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? chatStreamlistener;

  @override
  void onInit() async {
    super.onInit();
    passengerEntity = await lifeCycleController.getPassenger;
  }

  String? messageValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    }
    return null;
  }

  Future<void> addMessage() async {
    isLoading.value = true;
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      isLoading.value = false;
      return;
    }

    final newMessage = FirestoreMessageModel(
        message: textController.text,
        senderId: passengerEntity.accountId,
        senderName: passengerEntity.name,
        date: Utils.currentDateTime);
    try {
      if (tripId == null) {
        throw const UnexpectedException();
      } else {
        await FireStoreDatabaseService.instance
            .sendMessage(data: newMessage, tripId: tripId!);
      }
    } catch (e) {
      showSnackBar("Error", "Cant send message");
    } finally {
      isLoading.value = false;
      textController.clear();
    }
  }

  Future<void> initChat(String driverId, String newTripId) async {
    tripId = newTripId;
    messages.clear();
    FireStoreDatabaseService.instance.createChat(
        data: FirestoreChatModel(
          createTime: Utils.currentDateTime,
          driverId: driverId,
          passengerId: passengerEntity.accountId,
        ),
        tripId: newTripId);
    chatStreamController =
        FireStoreDatabaseService.instance.getChatStream(tripId: newTripId);

    chatStreamlistener = chatStreamController.listen((event) {
      for (var docAdd in event.docChanges) {
        if (docAdd.type == DocumentChangeType.added) {
          final chat = FirestoreMessageModel.fromJson(docAdd.doc.data()!);
          messages.add(
            ChatMessage(
              text: chat.message,
              chatMessageType: chat.senderId != passengerEntity.accountId
                  ? ChatMessageType.driver
                  : ChatMessageType.passenger,
            ),
          );
        }
      }
    });
  }

  Future<void> resetState() async {
    tripId = null;
    await chatStreamlistener?.cancel();
  }

  void popBack() {
    Get.back();
  }
}
