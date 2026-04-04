import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/app_config.dart';

class ApiService {
  final String baseUrl = AppConfig.baseUrl;

  Future<String> getRAGResponse(String query) async {
    final uri = Uri.parse('$baseUrl/chat/');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'question': query}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['answer'] ??
          data['response'] ??
          data['result'] ??
          'No valid response from backend';
    }

    throw Exception('Backend error: ${response.statusCode}');
  }
}
