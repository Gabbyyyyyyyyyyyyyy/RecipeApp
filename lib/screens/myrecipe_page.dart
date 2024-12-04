import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'add_recipe_page.dart';
import 'edit_recipe_page.dart';
import '../screens/detail_recipe_local.dart';
import '../services/model_reseplocal.dart';
import '../services/koneksi_recipe.dart';

class MyRecipePage extends StatefulWidget {
  const MyRecipePage({super.key});

  @override
  _MyRecipePageState createState() => _MyRecipePageState();
}

class _MyRecipePageState extends State<MyRecipePage> {
  List<LocalRecipe> _recipes = [];
  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:3000/recipes'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          setState(() {
            _recipes = data.map((item) => LocalRecipe.fromJson(item)).toList();
            _isLoading = false;
          });
        } else {
          throw Exception("Unexpected data format");
        }
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _confirmDeleteRecipe(String id) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Hapus"),
        content: const Text("Apakah Anda yakin ingin menghapus resep ini?"),
        actions: [
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text("Hapus"),
            onPressed: () async {
              bool success = await _apiService.deleteRecipe(id);
              if (success) {
                setState(() {
                  _recipes.removeWhere((recipe) => recipe.id == id);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Resep berhasil dihapus')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gagal menghapus resep')),
                );
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Recipes',
          style: GoogleFonts.rowdies(
            color: Colors.brown[700],
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[50],
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.brown[700]),
      ),
      body: Container(
        color: Colors.brown[50],
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _recipes.isEmpty
                    ? Center(
                        child: Text(
                          "Belum ada resep",
                          style: GoogleFonts.rowdies(
                            fontSize: 18,
                            color: Colors.brown[400],
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _recipes.length,
                          itemBuilder: (context, index) {
                            return _buildRecipeCard(_recipes[index]);
                          },
                        ),
                      ),
            const SizedBox(height: 16),
            FloatingActionButton.extended(
              backgroundColor: Colors.brown[700],
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddRecipePage()),
                );
                if (result == true) _fetchRecipes();
              },
              label: Row(
                children: const [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Tambah Resep", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeCard(LocalRecipe recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailPage(recipe: recipe),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        shadowColor: Colors.brown.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  recipe.name,
                  style: GoogleFonts.rowdies(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.brown[700]),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditRecipePage(
                            recipe: recipe,
                            onRecipeUpdated: _fetchRecipes,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red[400]),
                    onPressed: () => _confirmDeleteRecipe(recipe.id),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
