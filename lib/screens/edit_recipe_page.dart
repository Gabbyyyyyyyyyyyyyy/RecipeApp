// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/model_reseplocal.dart';
import '../services/koneksi_recipe.dart';

class EditRecipePage extends StatefulWidget {
  final LocalRecipe recipe; // Membawa data resep yang akan diedit
  final VoidCallback onRecipeUpdated;

  const EditRecipePage({
    Key? key,
    required this.recipe,
    required this.onRecipeUpdated,
  }) : super(key: key);

  @override
  _EditRecipePageState createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _ingredientsController;
  late TextEditingController _instructionsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.recipe.name);
    _ingredientsController = TextEditingController(
        text: widget.recipe.ingredients
            .join(', ')); // Gabungkan list menjadi string
    _instructionsController =
        TextEditingController(text: widget.recipe.instructions);
  }

  void _updateRecipe() async {
    if (_formKey.currentState!.validate()) {
      // Mengonversi ingredients yang dipisahkan koma kembali ke list
      List<String> updatedIngredients = _ingredientsController.text
          .split(',')
          .map((ingredient) => ingredient.trim())
          .toList();

      LocalRecipe updatedRecipe = LocalRecipe(
        id: widget.recipe.id,
        name: _nameController.text,
        ingredients: updatedIngredients,
        instructions: _instructionsController.text,
      );

      bool success = await ApiService().updateRecipe(updatedRecipe);

      if (success) {
        widget.onRecipeUpdated();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Resep berhasil diupdate!"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Gagal mengupdate resep!"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Recipe',
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField(
                            controller: _nameController,
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
                onPressed: _updateRecipe,
                icon: const Icon(Icons.save, color: Colors.white),
                label: Text(
                  'Save Changes',
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
    return TextFormField(
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
