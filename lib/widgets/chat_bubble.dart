import "package:flutter/material.dart";
import '../models/chat.dart';

class ChatBubble extends StatelessWidget {
  final Chat message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser
          ? colorScheme.onPrimary
          : colorScheme.onSurfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          ),
        ),
      ),
    );
  }
}