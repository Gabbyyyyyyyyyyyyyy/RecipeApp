import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/model_reseplocal.dart';
import 'dart:convert';

class RecipeDetailPage extends StatelessWidget {
  final LocalRecipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  // Fungsi untuk menyimpan resep ke dalam favorit
  Future<void> _saveToFavorites(
      BuildContext context, LocalRecipe recipe) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Simpan objek resep dalam format JSON
    String recipeJson = jsonEncode(recipe.toJson());

    // Ambil list favorit yang sudah ada, jika ada
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    // Mengecek apakah resep sudah ada di favorit
    if (!favorites.contains(recipe.id)) {
      favorites.add(recipe.id);
      await prefs.setStringList('favorites', favorites);

      // Simpan resep dengan ID sebagai key di SharedPreferences
      await prefs.setString(recipe.id, recipeJson);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '"${recipe.name}" has been added to your favorites!',
            style: GoogleFonts.rowdies(fontSize: 14),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '"${recipe.name}" is already in your favorites!',
            style: GoogleFonts.rowdies(fontSize: 14),
          ),
          backgroundColor: Colors.orangeAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Recipe',
          style: GoogleFonts.rowdies(
              fontWeight: FontWeight.w600, color: const Color(0xFF6D412A)),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF6D412A),
        elevation: 2,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul resep
              Text(
                recipe.name,
                style: GoogleFonts.rowdies(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF6D412A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Bagian bahan-bahan
              Text(
                'Ingredients',
                style: GoogleFonts.rowdies(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6D412A),
                ),
              ),
              const SizedBox(height: 10),
              ...recipe.ingredients.map((ingredient) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            ingredient,
                            style: GoogleFonts.rowdies(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),

              // Bagian instruksi
              Text(
                'Instructions',
                style: GoogleFonts.rowdies(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6D412A),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                recipe.instructions,
                style: GoogleFonts.rowdies(fontSize: 18, height: 1.6),
              ),
              const SizedBox(height: 40),

              // Tombol untuk menyimpan ke favorit
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6D412A),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () => _saveToFavorites(context, recipe),
                  child: Text(
                    'Save to Favorites',
                    style: GoogleFonts.rowdies(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
