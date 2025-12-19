import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://web-production-ee57f.up.railway.app';

  static Future<bool> login(String user, String pass) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': user,
        'password': pass,
      }),
    );

    return response.statusCode == 200;
  }
}
