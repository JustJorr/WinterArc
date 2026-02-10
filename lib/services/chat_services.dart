import 'package:winterarc/models/chat.dart';
import 'firestore_service.dart';

class ChatServices {
  final List<Chat> _messages = [];
  final FirestoreService _firestoreService = FirestoreService();

  List<Chat> get messages => List.unmodifiable(_messages);

  Future<void> loadMessages() async {
    final loaded = await _firestoreService.loadMessages();
    _messages.clear();
    _messages.addAll(loaded);
  }

  Future<void> addUserMessage(String text) async {
    final message = Chat(
        id: DateTime.now().millisecondsSinceEpoch.toString(), 
        text: text, 
        sender: MessageSender.user, 
        timestamp: DateTime.now(),
      );

      _messages.add(message);
      await _firestoreService.saveMesage(message);
  }

  Future<void> addBotMessage (String text) async {
    final message = Chat(
    id: DateTime.now().millisecondsSinceEpoch.toString(), 
    text: text, 
    sender: MessageSender.bot, 
    timestamp: DateTime.now()
    );

    _messages.add(message);
    await _firestoreService.saveMesage(message);
  }

  Chat createBotReply(String text) {
    return Chat(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
      text: text, 
      sender: MessageSender.bot,
      timestamp: DateTime.now(),
      );
  }

  void addMessage(Chat message) {
    _messages.add(message);
  }
}