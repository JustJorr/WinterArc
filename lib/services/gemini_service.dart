import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:winterarc/models/chat.dart';
import '../core/personality.dart';

class GeminiService {
  final String _apiKey = dotenv.env["GEMINI_API_KEY"] ?? '';

  static const String _endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

  Future<String> generateReply(List<Chat> messages) async {
    if (_apiKey.isEmpty) {
      throw Exception('Kontole API nya mana asu');
    }

    final url = Uri.parse('$_endpoint?key=$_apiKey');

    final List<Map<String, dynamic>> contents = [
      {
        "role": "model",
        "parts": [
          {"text": winterArcPersonality2}
        ]
      }
    ];

    contents.addAll(
      messages.map((msg) {
        return {
          "role": msg.sender == MessageSender.user ? "user" : "model",
          "parts": [
            {"text": msg.text}
          ]
        };
      }),
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": contents,
      }),
    );

    if (response.statusCode == 429) {
      return "Slow down, champ. Even AI needs to breathe.";
    }

    if (response.statusCode != 200) {
      throw Exception(
        'Gemini error (${response.statusCode}): ${response.body}',
      );
    }

    if (response.statusCode == 404) {
      return "API key is missing";
    }

    final data = jsonDecode(response.body);
    return data['candidates'][0]['content']['parts'][0]['text'];
  }
}
