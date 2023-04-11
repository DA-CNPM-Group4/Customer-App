import 'package:customer_app/data/models/chat_message/chat_message.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final LifeCycleController lifeCycleController =
      Get.find<LifeCycleController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  final TextEditingController textController = TextEditingController();
  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final scrollController = ScrollController();

  void addMessage(ChatMessage message) {
    messages.add(message);
  }
}
