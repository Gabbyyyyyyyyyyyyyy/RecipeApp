import 'dart:convert';

class LocalRecipe {
  String id;
  String name;
  List<String> ingredients;
  String instructions;

  LocalRecipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
  });

  // Konversi objek LocalRecipe ke JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'ingredients': ingredients,
        'instructions': instructions,
      };

  // Factory constructor untuk membuat LocalRecipe dari JSON
  factory LocalRecipe.fromJson(Map<String, dynamic> map) {
    return LocalRecipe(
      id: map["id"].toString(),
      name: map["name"],
      ingredients: List<String>.from(map["ingredients"]),
      instructions: map["instructions"],
    );
  }

  @override
  String toString() {
    return 'LocalRecipe{id: $id, name: $name, ingredients: $ingredients, instructions: $instructions}';
  }
}

// Fungsi untuk mengubah JSON string menjadi List<LocalRecipe>
List<LocalRecipe> localRecipeFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<LocalRecipe>.from(
      data['recipes'].map((item) => LocalRecipe.fromJson(item)));
}

// Fungsi untuk mengubah objek LocalRecipe menjadi JSON string
String localRecipeToJson(LocalRecipe data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
