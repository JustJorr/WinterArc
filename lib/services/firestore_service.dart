import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/chat_message.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _messagesRef{
    final uid = _auth.currentUser!.uid;
    return _firestore
      .collection('users')
      .doc(uid)
      .collection('messages');
  }

  Future<void> saveMesage(ChatMessage message) async {
    await _messagesRef.doc(message.id).set(message.toMap());
  }

  Future<List<ChatMessage>> loadMessages() async {
    final snapshot = await _messagesRef
      .orderBy('timestamp')
      .get();

    return snapshot.docs
      .map((doc) => ChatMessage.fromMap(doc.id, doc.data()))
      .toList();
  }
}