class Recipe {
  final String id; // Tambahkan id
  final String title;
  final String imageUrl;
  final String description;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['idMeal'] ?? '', // Gantilah dengan properti yang benar
      title: json['strMeal'] ?? 'No title',
      imageUrl: json['strMealThumb'] ?? 'https://via.placeholder.com/150',
      description: json['strInstructions'] ?? 'No description available',
    );
  }
}
