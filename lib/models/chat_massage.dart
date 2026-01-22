enum MassageSender {
  user,
  bot,
}

class ChatMassage {
  final String id;
  final String text;
  final MassageSender sender;
  final DateTime timestamp;

  ChatMassage({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
  });
}