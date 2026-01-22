import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';

void main() {
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