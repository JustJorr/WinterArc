import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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

  Widget _buildMessageList() {
    return ListView.builder(
      controller: ScrollController(),
      padding: const EdgeInsets.all(12),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return ChatBubble(message: _messages[index]);
      },
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              textInputAction: TextInputAction.send,
              decoration: const InputDecoration(
                hintText: "Ko Jawa Tanya Sudah",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
            ),
        ],
      ),
    );
  }


  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients){
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } 
    });
  }


  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
      text: text, 
      sender: MessageSender.user, 
      timestamp: DateTime.now(),
      );

    setState(() {
      _messages.add(userMessage);

      _textController.clear();
      _scrollToBottom();
      _simulateBotReply();
    });
  }


  void _simulateBotReply() {
    Future.delayed(const Duration(seconds: 1), () {
      final botMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(), 
        text: "Kontolone", 
        sender: MessageSender.bot, 
        timestamp: DateTime.now(),
        );

        setState(() {
          _messages.add(botMessage);
        });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeMentor'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildInputArea(),
        ],
      ),
    );
  }
}
