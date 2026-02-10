import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageSender {
  user,
  bot,
}

class Chat {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;

  Chat({
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

  factory Chat.fromMap(String id, Map<String, dynamic> map) {
    return Chat(
      id: id,
      text: map['text'],
      sender: MessageSender.values.byName(map['sender']),
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      );
  }
}