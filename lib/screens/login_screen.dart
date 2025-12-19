import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'platos_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  String error = '';
  
	  Future<void> login() async {
	  FocusScope.of(context).unfocus();

	  setState(() {
		error = '';
	  });

	  try {
		final response = await http.post(
		  Uri.parse('https://web-production-ee57f.up.railway.app/login'),
		  headers: {
			'Content-Type': 'application/json',
		  },
		  body: jsonEncode({
			'username': userController.text,
			'password': passController.text,
		  }),
		);

		if (response.statusCode == 200) {
		  final data = jsonDecode(response.body);

		  if (data['success'] == true) {
			Navigator.pushReplacement(
			  context,
			  MaterialPageRoute(builder: (_) => PlatosScreen()),
			);
		  } else {
			setState(() {
			  error = data['message'] ?? 'Credenciales incorrectas';
			});
		  }
		} else {
		  setState(() {
			error = 'Error de servidor (${response.statusCode})';
		  });
		}
	  } catch (e) {
		setState(() {
		  error = 'No se pudo conectar con el servidor';
		});
	  }
	}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( 
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.restaurant,
                        size: 60, color: Colors.orange),
                    const SizedBox(height: 16),
                    const Text(
                      'FoodPlease',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: userController,
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),

                    if (error.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: login,
                        child: const Text('Ingresar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
