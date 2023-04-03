import 'package:customer_app/data/models/chat_message/chat_message.dart';
import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;
  const ChatMessageWidget({
    Key? key,
    required this.text,
    required this.chatMessageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chatMessageType == ChatMessageType.passenger
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            color: Colors.grey[200],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.black)),
                )
              ],
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(16, 163, 127, 1),
                      child: Image.asset(
                        "assets/icons/face_icon.png",
                        color: Colors.white,
                        scale: 1.5,
                      ),
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.black)),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
