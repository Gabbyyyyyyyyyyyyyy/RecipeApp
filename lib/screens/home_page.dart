import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import '../services/api_service.dart'; // Pastikan path service-nya benar
import '../screens/category_recipe_page.dart'; // Halaman list resep berdasarkan kategori

class HomePage extends StatefulWidget {
  final String? username;

  const HomePage({super.key, this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Category> categories = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ambil kategori saat halaman pertama kali dimuat
    fetchCategories().then((fetchedCategories) {
      setState(() {
        categories = fetchedCategories;
        isLoading = false;
      });
    }).catchError((error) {
      // Tangani error jika ada
      setState(() {
        isLoading = false;
      });
      print("Error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF5F3),
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/ava1.jpg'),
              radius: 18,
            ),
            const SizedBox(width: 10),
            Text(
              'Hello, ${widget.username ?? 'Guest'}!',
              style: GoogleFonts.rowdies(
                textStyle: const TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 109, 65, 42),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text untuk judul
            Text(
              'What ingredients do you have today?',
              style: GoogleFonts.rowdies(
                textStyle: const TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 109, 65, 42),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (query) {
                  // Handle search logic here
                  setState(() {
                    // Filter kategori berdasarkan query
                    categories = categories.where((category) {
                      return category.name
                          .toLowerCase()
                          .contains(query.toLowerCase());
                    }).toList();
                  });
                },
              ),
            ),
            const SizedBox(height: 16),

            // Kategori
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 item per baris
                        crossAxisSpacing: 1.0, // Jarak antar item horizontal
                        mainAxisSpacing: 0.5, // Jarak antar item vertikal
                        childAspectRatio:
                            0.8, // Menyesuaikan rasio lebar dan tinggi
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman resep berdasarkan kategori
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryRecipePage(
                                  category:
                                      categories[index].name, // Kirim kategori
                                ),
                              ),
                            );
                          },
                          child: CategoryCard(category: categories[index]),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFFDF5F3),
    );
  }
}
