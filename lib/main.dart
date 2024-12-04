import 'package:flutter/material.dart';
import 'routes.dart'; // Pastikan rute Anda didefinisikan dengan benar di sini
import 'screens/home_page.dart'; // Home page
import 'screens/favorite_page.dart'; // Halaman Favorite
import 'screens/profile_page.dart'; // Halaman Profile
import 'screens/myrecipe_page.dart'; // Halaman MyRecipe
import 'widgets/bottom_navbar.dart'; // Pastikan BottomNavBar sudah dibuat

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EasyBites',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: AppRoutes.splash, // Mulai dari Splash Screen
      onGenerateRoute: AppRoutes.generateRoute, // Generator untuk rute
    );
  }
}

class MainScreen extends StatefulWidget {
  final String username;

  const MainScreen({super.key, this.username = 'Guest'}); // Default ke 'Guest'

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // Indeks tab aktif

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Halaman yang terhubung ke setiap tab
    _pages = [
      HomePage(username: widget.username), // Tab Home dengan username
      const MyRecipePage(), // Halaman MyRecipe
      const FavoritePage(), // Tab Favorites
      const ProfilePage(), // Tab Profile
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Ubah indeks tab aktif
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Halaman sesuai tab aktif
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped, // Callback untuk perubahan tab
      ),
    );
  }
}
