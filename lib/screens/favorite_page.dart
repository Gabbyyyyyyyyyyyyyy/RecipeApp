import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/model_reseplocal.dart'; // Import model LocalRecipe
import '../routes.dart'; // Import routes
import 'dart:convert'; // Untuk encoding dan decoding JSON

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<LocalRecipe> favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  // Fungsi untuk memuat data favorit dari SharedPreferences
  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favorites') ?? [];

    List<LocalRecipe> recipes = [];
    for (String id in favoriteIds) {
      String? recipeJson = prefs.getString(id);
      if (recipeJson != null) {
        Map<String, dynamic> recipeMap = jsonDecode(recipeJson);
        recipes.add(LocalRecipe.fromJson(recipeMap));
      }
    }

    setState(() {
      favoriteRecipes = recipes;
    });
  }

  // Fungsi untuk menghapus resep dari favorit
  void _removeFavorite(LocalRecipe recipe) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Hapus?",
            style: GoogleFonts.rowdies(
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(
            "Apakah Anda yakin ingin menghapus ${recipe.name} dari favorit?",
            style: GoogleFonts.rowdies(
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Batal",
                style: GoogleFonts.rowdies(
                  textStyle:
                      const TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                "Hapus",
                style: GoogleFonts.rowdies(
                  textStyle:
                      const TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmDelete ?? false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favoriteIds = prefs.getStringList('favorites') ?? [];

      // Hapus ID resep dari daftar favorit
      favoriteIds.remove(recipe.id);

      // Hapus resep yang sesuai dari SharedPreferences
      await prefs.setStringList('favorites', favoriteIds);
      await prefs.remove(recipe.id); // Hapus resep dari SharedPreferences

      // Memperbarui UI
      setState(() {
        favoriteRecipes.remove(recipe);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${recipe.name} dihapus dari favorit',
            style: GoogleFonts.rowdies(
              textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorit Saya",
          style: GoogleFonts.rowdies(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 109, 65, 42),
            ),
          ),
        ),
        backgroundColor: Color(0xFFFDF5F3),
        elevation: 4,
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFFDF5F3),
        padding: const EdgeInsets.all(16.0),
        child: favoriteRecipes.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                itemCount: favoriteRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = favoriteRecipes[index];
                  return _buildFavoriteCard(recipe);
                },
              ),
      ),
    );
  }

  // Widget untuk menampilkan jika tidak ada resep favorit
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 60,
            color: Colors.redAccent,
          ),
          const SizedBox(height: 16),
          Text(
            "Belum Ada Resep Favorit!",
            style: GoogleFonts.rowdies(
              textStyle: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan setiap resep favorit dalam daftar
  Widget _buildFavoriteCard(LocalRecipe recipe) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail resep
        Navigator.pushNamed(
          context,
          AppRoutes.detailRecipe,
          arguments: recipe, // Mengirim objek LocalRecipe ke halaman detail
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: Icon(
            Icons.favorite,
            color: Colors.redAccent,
            size: 30,
          ),
          title: Text(
            recipe.name,
            style: GoogleFonts.rowdies(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6D412A),
              ),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Color(0xFF6D412A)),
            onPressed: () {
              _removeFavorite(recipe);
            },
          ),
        ),
      ),
    );
  }
}
