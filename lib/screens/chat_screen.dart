import 'package:flutter/material.dart';
import 'package:winterarc/services/auth_service.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/typing_indicator.dart';
import '../services/chat_services.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatServices _chatService = ChatServices();
  final AuthService _authService = AuthService();
  bool _isBotTyping = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    await _authService.signInAnonymously();
    await _chatService.loadMessages();
    setState(() {});
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WinterArc'),
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


  Widget _buildMessageList() {
    final messages = _chatService.messages;

    return ListView.builder(
      controller: ScrollController(),
      padding: const EdgeInsets.all(12),
      itemCount: messages.length + (_isBotTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (_isBotTyping && index == messages.length) {
          return const TypingIndicator();
        }
          return ChatBubble(message: messages[index]);
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
              enabled: !_isBotTyping,
              textInputAction: TextInputAction.send,
              decoration: const InputDecoration(
                hintText: "Kontol Kau anjeng",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isBotTyping ? null : _sendMessage,
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
    if (text.isEmpty || _isBotTyping) return;

    setState(() {
      _chatService.addUserMessage(text);
    });
      _textController.clear();
      _scrollToBottom();
      _simulateBotReply();
  }


  void _simulateBotReply() {
    setState(() {
      _isBotTyping = true;
    });

    _scrollToBottom();

    Future.delayed(const Duration(seconds: 2), () {
      final botMessage = _chatService.createBotReply(
        "Jancok ni tak jelasin Kont...",
        );

        setState(() {
          _isBotTyping = false;
          _chatService.addMessage(botMessage);
        });

        _scrollToBottom();
    });
  }
}
