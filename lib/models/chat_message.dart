import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageSender {
  user,
  bot,
}

class ChatMessage {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'text' : text,
      'sender' : sender.name,
      'timestamp' : timestamp,
    };
  }

  factory ChatMessage.fromMap(String id, Map<String, dynamic> map) {
    return ChatMessage(
      id: id,
      text: map['text'],
      sender: MessageSender.values.byName(map['sender']),
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      );
  }
}