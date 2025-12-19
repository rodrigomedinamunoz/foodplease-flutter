import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/plato.dart';

class ApiService {
  static const String baseUrl =
      'https://web-production-ee57f.up.railway.app/platos';

  static Future<List<Plato>> fetchPlatos() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Plato.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar platos');
    }
  }
}
