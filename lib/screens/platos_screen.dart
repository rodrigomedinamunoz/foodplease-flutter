import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/plato.dart';

class PlatosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listado de Platos')),
      body: FutureBuilder<List<Plato>>(
        future: ApiService.fetchPlatos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else {
            final platos = snapshot.data!; 

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: platos.length,
              itemBuilder: (context, index) {
                final plato = platos[index];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.fastfood, color: Colors.orange),
                    title: Text(
                      plato.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '\$${plato.price}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
