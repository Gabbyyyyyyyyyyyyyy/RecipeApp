import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'main.dart';
import 'screens/favorite_page.dart';
import 'screens/profile_page.dart';
import 'screens/register_page.dart'; // Impor halaman Register
import '../services/model_reseplocal.dart'; // Import model LocalRecipe
import '../screens/detail_recipe_local.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String favorite = '/favorite';
  static const String profile = '/profile';
  static const String detailRecipe = '/detail-recipe';
  static const String register = '/register'; // Rute untuk halaman register

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        final String username = settings.arguments as String? ?? 'Guest';
        return MaterialPageRoute(
          builder: (_) => MainScreen(username: username),
        );
      case favorite:
        return MaterialPageRoute(builder: (_) => const FavoritePage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case detailRecipe:
        if (settings.arguments is LocalRecipe) {
          final recipe = settings.arguments as LocalRecipe;
          return MaterialPageRoute(
            builder: (_) => RecipeDetailPage(recipe: recipe),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text('Argumen tidak valid untuk Halaman Detail Resep!'),
              ),
            ),
          );
        }
      case register:
        return MaterialPageRoute(
            builder: (_) => RegisterPage()); // Halaman register
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Halaman tidak ditemukan!'),
            ),
          ),
        );
    }
  }
}
