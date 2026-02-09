import 'package:winterarc/models/chat_message.dart';
import 'firestore_service.dart';

class ChatServices {
  final List<ChatMessage> _messages = [];
  final FirestoreService _firestoreService = FirestoreService();

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  Future<void> loadMessages() async {
    final loaded = await _firestoreService.loadMessages();
    _messages.clear();
    _messages.addAll(loaded);
  }

  Future<void> addUserMessage(String text) async {
    final message = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(), 
        text: text, 
        sender: MessageSender.user, 
        timestamp: DateTime.now(),
      );

      _messages.add(message);
      await _firestoreService.saveMesage(message);
  }

  Future<void> addBotMessage (String text) async {
    final message = ChatMessage(
    id: DateTime.now().millisecondsSinceEpoch.toString(), 
    text: text, 
    sender: MessageSender.bot, 
    timestamp: DateTime.now()
    );

    _messages.add(message);
    await _firestoreService.saveMesage(message);
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