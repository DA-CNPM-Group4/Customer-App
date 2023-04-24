import 'package:customer_app/modules/chat/widgets/chat_message_widget.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const ChatView();
  }

  @override
  bool get wantKeepAlive => true;
}

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  controller.popBack();
                },
              ),
              title: Text(
                "Chat",
                style: BaseTextStyle.heading2(fontSize: 20),
              ),
              elevation: 1,
            ),
            body: Center(
              child: Column(children: [
                Expanded(
                  child: _buildListMessage(),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      _buildTextField(),
                      _buildSendButton(),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ));
  }

  Widget _buildTextField() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Form(
          key: controller.formKey,
          child: TextFormField(
            validator: (value) => controller.messageValidator(value!),
            textCapitalization: TextCapitalization.sentences,
            controller: controller.textController,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              hintText: "Type a message...",
              hintStyle: TextStyle(color: Colors.black38),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: const Color(0xff00A67E),
          borderRadius: BorderRadius.circular(30),
        ),
        child: controller.isLoading.value
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : IconButton(
                icon: const Icon(Icons.send),
                iconSize: 25,
                color: Colors.white,
                onPressed: () async {
                  await controller.addMessage();
                  // Future.delayed(const Duration(milliseconds: 50))
                  //     .then((value) => _scrollDown());
                }),
      ),
    );
  }

  Widget _buildListMessage() {
    return Obx(
      () => ListView.builder(
        itemCount: controller.messages.length,
        controller: controller.scrollController,
        itemBuilder: (context, index) {
          var message = controller.messages[index];
          return ChatMessageWidget(
            text: message.text,
            chatMessageType: message.chatMessageType,
          );
        },
      ),
    );
  }
}
