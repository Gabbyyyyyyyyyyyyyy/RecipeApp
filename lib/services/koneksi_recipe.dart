import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model_reseplocal.dart';

class ApiService {
  var client = http.Client();
  final String baseUrl =
      'http://10.0.2.2:3000/recipes'; // Ganti localhost dengan 10.0.2.2 untuk emulator

  // Fungsi untuk mengambil data (GET)
  Future<List<LocalRecipe>?> getRecipes() async {
    var uri = Uri.parse(baseUrl);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return localRecipeFromJson(response.body);
    } else {
      print("Gagal mengambil data: ${response.statusCode}");
      return null;
    }
  }

  // Fungsi untuk menambahkan data baru (POST)
  Future<bool> addRecipe(LocalRecipe recipe) async {
    var uri = Uri.parse(baseUrl);
    var response = await client.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(recipe.toJson()),
    );

    if (response.statusCode == 201) {
      print("Data resep berhasil ditambahkan!");
      return true;
    } else {
      print("Gagal menambahkan data resep: ${response.statusCode}");
      return false;
    }
  }

  // Fungsi untuk menghapus data (DELETE)
  Future<bool> deleteRecipe(String id) async {
    var uri = Uri.parse('$baseUrl/$id');
    var response = await client.delete(uri);
    if (response.statusCode == 200) {
      print("Data resep berhasil dihapus!");
      return true;
    } else {
      print("Gagal menghapus data resep: ${response.statusCode}");
      return false;
    }
  }

  // Fungsi untuk mengupdate data (PUT)
  Future<bool> updateRecipe(LocalRecipe recipe) async {
    var uri = Uri.parse('$baseUrl/${recipe.id}');
    var response = await client.put(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(recipe.toJson()),
    );

    // Log request body dan response untuk debugging
    print("Request body: ${jsonEncode(recipe.toJson())}");
    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      print("Data resep berhasil diupdate!");
      return true;
    } else {
      print("Gagal mengupdate data resep: ${response.statusCode}");
      return false;
    }
  }
}
