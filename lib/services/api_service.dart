import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/recipe.dart';

// Mendapatkan kategori dari API
Future<List<Category>> fetchCategories() async {
  final url =
      'https://www.themealdb.com/api/json/v1/1/categories.php'; // URL API untuk kategori

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['categories'];
    return data.map((json) => Category.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}

// Mendapatkan resep berdasarkan kategori tanpa API key (menggunakan TheMealDB)
Future<List<Recipe>> fetchRecipesByCategory(String category) async {
  final String url =
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'; // URL API untuk resep berdasarkan kategori

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body)['meals'];
    return data.map<Recipe>((json) => Recipe.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load recipes');
  }
}

// Mendapatkan detail resep berdasarkan ID (untuk mendapatkan informasi detail)
Future<Map<String, dynamic>> fetchRecipeDetails(String recipeId) async {
  final String url =
      'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$recipeId'; // Endpoint API

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    // Pastikan kita mendapatkan data resep dari 'meals'
    if (data['meals'] != null && data['meals'].isNotEmpty) {
      return data['meals'][0]; // Mengambil data dari array 'meals' (pertama)
    } else {
      throw Exception('Recipe not found');
    }
  } else {
    throw Exception('Failed to load recipe details');
  }
}
