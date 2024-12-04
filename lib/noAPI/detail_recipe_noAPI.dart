// File path: lib/screens/detail_recipe.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'food_item.dart';

class DetailRecipeScreen extends StatelessWidget {
  final FoodItem foodItem;

  const DetailRecipeScreen({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF5F3),
        elevation: 0,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.red),
            onPressed: () {
              // TODO: Tambahkan fungsi favorit
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama makanan di atas gambar
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  foodItem.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rowdies(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      color: Color.fromARGB(255, 109, 65, 42),
                    ),
                  ),
                ),
              ),

              // Adjusted food image with BoxFit.contain
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(15.0), // Membuat sudut rounded
                child: Image.asset(
                  foodItem.imagePath,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.contain, // Gambar terlihat sepenuhnya tanpa crop
                ),
              ),
              const SizedBox(height: 16),

              // Chips for details (centered)
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Untuk menengahkan chip
                children: [
                  _buildOutlinedChip('25 min'),
                  const SizedBox(width: 8),
                  _buildOutlinedChip('For lunch'),
                  const SizedBox(width: 8),
                  _buildOutlinedChip('Yummy'),
                ],
              ),
              const SizedBox(height: 16),

              // Recipe description
              Text(
                foodItem.description,
                style: GoogleFonts.rowdies(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 70, 50, 30),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Ingredients section
              _buildSectionTitle('Required Ingredients'),
              ...foodItem.ingredients.map((ingredient) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '- $ingredient',
                    style: GoogleFonts.rowdies(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 70, 50, 30),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),

              // Steps section
              _buildSectionTitle('Steps to Prepare'),
              ...foodItem.steps.map((step) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '- $step',
                    style: GoogleFonts.rowdies(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 70, 50, 30),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFDF5F3),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.rowdies(
        textStyle: const TextStyle(
          fontSize: 24,
          color: Color.fromARGB(255, 109, 65, 42),
        ),
      ),
    );
  }

  // Helper method to build outlined chips
  Widget _buildOutlinedChip(String label) {
    return Chip(
      label: Text(
        label,
        style: GoogleFonts.rowdies(
          textStyle: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 109, 65, 42), // Warna teks
          ),
        ),
      ),
      backgroundColor: Colors.transparent, // Tidak ada background
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color.fromARGB(255, 109, 65, 42), // Warna garis tepi
          width: 1.5, // Ketebalan garis
        ),
        borderRadius: BorderRadius.circular(20), // Membuat chip rounded
      ),
    );
  }
}
