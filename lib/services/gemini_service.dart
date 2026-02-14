import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  final String _apiKey = dotenv.env["GEMINI_API_KEY"] ?? '';
  
 static const String _endpoint =
  'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';


  Future<String> generateReply(String prompt) async {
    if (_apiKey.isEmpty) {
      throw Exception('Kontole API nya mana, wasu');
    }

    final url = Uri.parse('$_endpoint?key=$_apiKey');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gemininya error (${response.statusCode}): ${response.body}',
      );
    }

    final data = jsonDecode(response.body);
    return data['candidates'][0]['content']['parts'][0]['text'];
  }
}
