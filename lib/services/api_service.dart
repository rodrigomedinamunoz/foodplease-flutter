import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/plato.dart';

class ApiService {
  static const String baseUrl =
      'https://web-production-ee57f.up.railway.app';

  static Future<String?> login(String user, String pass) async {
  try {
    final response = await http.post(
      Uri.parse('https://web-production-ee57f.up.railway.app/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': user,
        'password': pass,
      }),
    );

    if (response.statusCode == 200) {
      return null; // éxito
    } else if (response.statusCode == 401) {
      return 'Usuario o contraseña incorrectos';
    } else {
      return 'Error del servidor';
    }
  } catch (e) {
    return 'No se pudo conectar con el servidor';
  }
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
