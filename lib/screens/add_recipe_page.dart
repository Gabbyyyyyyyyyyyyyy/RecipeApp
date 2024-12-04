import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _recipeNameController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();

  // Fungsi untuk menyimpan resep baru ke server
  Future<void> _saveRecipe() async {
    if (_recipeNameController.text.isEmpty ||
        _ingredientsController.text.isEmpty ||
        _instructionsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    // Memisahkan ingredients berdasarkan koma untuk membuat List<String>
    List<String> ingredientsList = _ingredientsController.text.split(',');

    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/recipes'), // URL json-server
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': _recipeNameController.text,
        'ingredients': ingredientsList, // Mengirimkan sebagai List<String>
        'instructions': _instructionsController.text,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.pop(
          context, true); // Kembali ke halaman MyRecipePage dengan hasil
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add recipe')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Recipe',
          style: GoogleFonts.rowdies(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF6D412A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _recipeNameController,
                      labelText: 'Recipe Name',
                      icon: Icons.fastfood,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _ingredientsController,
                      labelText: 'Ingredients (e.g., Flour, Sugar, Milk)',
                      icon: Icons.restaurant_menu,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _instructionsController,
                      labelText: 'Instructions (e.g., Step 1, Step 2)',
                      icon: Icons.note_add,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6D412A),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _saveRecipe,
                icon: const Icon(Icons.save, color: Colors.white),
                label: Text(
                  'Save Recipe',
                  style: GoogleFonts.rowdies(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.rowdies(fontSize: 16, color: Colors.black54),
        prefixIcon: Icon(icon, color: const Color(0xFF6D412A)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF6D412A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF6D412A), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF6D412A)),
        ),
      ),
      cursorColor: const Color(0xFF6D412A),
    );
  }
}
