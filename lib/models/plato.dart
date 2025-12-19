class Plato {
  final int id;
  final String name;
  final int price;

  Plato({required this.id, required this.name, required this.price});

  factory Plato.fromJson(Map<String, dynamic> json) {
    return Plato(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}