import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      id: '1',
      text: 'Hello! Saya Adalah WinterArc. Bisakah saya membantu anda?',
      sender: MessageSender.bot,
      timestamp: DateTime.now(),
    ),
    ChatMessage(
      id: '2',
      text: 'Kau kek kontl',
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeMentor'),
        centerTitle: true,
      ),
      body: _buildMessageList(),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return ChatBubble(message: message);
      },
    );
  }
}
