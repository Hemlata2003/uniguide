import 'package:flutter/material.dart';

import '../../data/message_model.dart';
import 'chat_bubble.dart';
import 'typing_indicator.dart';

class ChatMessageList extends StatelessWidget {
  const ChatMessageList({
    super.key,
    required this.messages,
    required this.isLoading,
    required this.scrollController,
  });

  final List<ChatMessage> messages;
  final bool isLoading;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty && !isLoading) {
      return const Center(
        child: Text(
          'Start a chat to get help with books, notes, or previous year questions.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
      itemCount: messages.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == messages.length) {
          return const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TypingIndicator(),
            ),
          );
        }

        final msg = messages[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ChatBubble(message: msg),
        );
      },
    );
  }
}
