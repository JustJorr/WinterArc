import 'package:winterarc/models/chat_message.dart';

class ChatServices {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  void addUserMessage(String text) {
    _messages.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(), 
        text: text, 
        sender: MessageSender.user, 
        timestamp: DateTime.now(),
      ));
  }

  ChatMessage createBotReply(String text) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
      text: text, 
      sender: MessageSender.bot,
      timestamp: DateTime.now(),
      );
  }

  void addMessage(ChatMessage message) {
    _messages.add(message);
  }
}