import 'package:flutter/material.dart';

/// Model data untuk item makanan
class FoodItem {
  final String name; // Nama makanan
  final String imagePath; // Path gambar makanan
  final Color bgColor; // Warna latar belakang kartu makanan
  final String category; // Kategori makanan
  final String description; // Deskripsi makanan
  final List<String> ingredients; // Daftar bahan
  final List<String> steps; // Langkah memasak

  FoodItem({
    required this.name,
    required this.imagePath,
    required this.bgColor,
    required this.category,
    required this.description,
    required this.ingredients,
    required this.steps,
  });
}

/// Daftar item makanan
final List<FoodItem> foodItems = [
  FoodItem(
    name: 'Broccoli',
    imagePath: 'assets/images/broccoli.png',
    bgColor: const Color.fromARGB(255, 199, 177, 152),
    category: 'Vegetables',
    description: 'A nutritious green vegetable that is rich in vitamins.',
    ingredients: ['Broccoli', 'Salt', 'Olive Oil'],
    steps: [
      'Wash the broccoli thoroughly.',
      'Cut into florets.',
      'Steam or sauté with olive oil and salt.',
    ],
  ),
  FoodItem(
    name: 'Cabbage',
    imagePath: 'assets/images/cabbage.png',
    bgColor: const Color.fromARGB(255, 223, 211, 195),
    category: 'Vegetables',
    description: 'A versatile vegetable used in many cuisines.',
    ingredients: ['Cabbage', 'Carrots', 'Vinegar', 'Salt'],
    steps: [
      'Slice the cabbage thinly.',
      'Mix with grated carrots.',
      'Add vinegar and salt, then toss to combine.',
    ],
  ),
  FoodItem(
    name: 'Carrot',
    imagePath: 'assets/images/carrot.png',
    bgColor: const Color.fromARGB(255, 223, 211, 195),
    category: 'Vegetables',
    description: 'A root vegetable that is sweet and crunchy.',
    ingredients: ['Carrots', 'Honey', 'Butter'],
    steps: [
      'Peel and slice the carrots.',
      'Sauté in butter and drizzle with honey.',
      'Cook until tender and serve warm.',
    ],
  ),
  FoodItem(
    name: 'Corn',
    imagePath: 'assets/images/corn.png',
    bgColor: const Color.fromARGB(255, 199, 177, 152),
    category: 'Vegetables',
    description: 'A sweet and juicy grain often eaten as a snack.',
    ingredients: ['Corn', 'Butter', 'Salt'],
    steps: [
      'Boil or grill the corn.',
      'Spread butter over the corn.',
      'Sprinkle with salt and serve.',
    ],
  ),
  FoodItem(
    name: 'Onion',
    imagePath: 'assets/images/onion.png',
    bgColor: const Color.fromARGB(255, 199, 177, 152),
    category: 'Vegetables',
    description: 'A staple ingredient with a pungent and savory flavor.',
    ingredients: ['Onions', 'Oil', 'Salt'],
    steps: [
      'Peel and slice the onions.',
      'Sauté in oil until golden brown.',
      'Add salt to taste and use in your recipe.',
    ],
  ),
  FoodItem(
    name: 'Orange',
    imagePath: 'assets/images/orange.png',
    bgColor: const Color.fromARGB(255, 223, 211, 195),
    category: 'Fruits',
    description: 'A juicy and tangy citrus fruit rich in vitamin C.',
    ingredients: ['Orange'],
    steps: [
      'Peel the orange.',
      'Separate into segments.',
      'Enjoy as a snack or add to a salad.',
    ],
  ),
  FoodItem(
    name: 'Soy Milk',
    imagePath: 'assets/images/soymilk.png',
    bgColor: const Color.fromARGB(255, 223, 211, 195),
    category: 'Dairy',
    description: 'A creamy, plant-based milk alternative.',
    ingredients: ['Soybeans', 'Water', 'Sugar'],
    steps: [
      'Soak soybeans overnight.',
      'Blend with water and strain.',
      'Sweeten with sugar and boil before serving.',
    ],
  ),
];
