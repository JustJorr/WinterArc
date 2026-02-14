import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  final String _apiKey = dotenv.env["GEMINI_API_KEY"] ?? '';

  static const String _endpoint = 
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  Future<String> generateReply(String prompt) async {
    if (_apiKey.isEmpty) {
      throw Exception('Kontole API nya mana, wasu');
    }

    final uri = Uri.parse('$_endpoint?=key=$_apiKey');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents' : [
          {
            'parts' : [
              {'text' : prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gemininya error bodoh (${response.statusCode}): #{response.body}',
      );
    }

    final data = jsonDecode(response.body);

    return data['candidates'][0]['content']['parts'][0]['text'];
  }
}