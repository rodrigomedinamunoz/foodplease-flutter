import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/plato.dart';

class ApiService {
  static const String baseUrl =
      'https://web-production-ee57f.up.railway.app';

  // LOGIN REAL
  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    return response.statusCode == 200;
  }

  // LISTADO DE PRODUCTOS
  static Future<List<Plato>> fetchPlatos() async {
    final response = await http.get(
      Uri.parse('$baseUrl/platos'),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Plato.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar platos');
    }
  }
}
