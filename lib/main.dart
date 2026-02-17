import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/chat_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final auth = AuthService();
  await auth.signInAnonymously();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signInAnonymously();
  runApp(const WinterArc());
}

class WinterArc extends StatelessWidget {
  const WinterArc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo
      ),
      home: const ChatScreen(),
    );
  }
}