import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'food_item.dart';
import '../routes.dart'; // Tambahkan import untuk rute

class FoodCard extends StatelessWidget {
  final FoodItem foodItem;

  const FoodCard({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke layar detail saat kartu diklik
        Navigator.pushNamed(
          context,
          AppRoutes.detailRecipe,
          arguments: foodItem, // Kirim data foodItem sebagai argumen
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: foodItem.bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        height: 150, // Set a fixed height to maintain consistent size
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              foodItem.imagePath,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              foodItem.name,
              style: GoogleFonts.rowdies(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: const Color.fromARGB(255, 109, 65, 42),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
