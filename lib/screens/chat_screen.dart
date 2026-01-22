import 'package:flutter/material.dart';
import 'package:winterarc/models/chat_massage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMassage> _messages = [
    ChatMassage(
      id: "1", text: "Hello! Apakah Wajah Kamu kek Kontol", sender: MassageSender.bot, timestamp: DateTime.now()
    ),
    ChatMassage(
      id: "2", text: "Hello! Tepat Sekali!", sender: MassageSender.user, timestamp: DateTime.now()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WinterArc"),
        centerTitle: true,
      ),
      body: _buildMassageList(),
    );
  }

  Widget _buildMassageList() {
      return ListView.builder(
        padding: (const EdgeInsets.all(12)),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final massage = _messages[index];
          return ChatBubble(massage: massage);
        },
      );
  }
}