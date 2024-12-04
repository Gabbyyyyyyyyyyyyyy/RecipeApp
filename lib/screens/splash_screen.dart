import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigasi otomatis ke halaman Login setelah 3 detik
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (mounted) {
        Navigator.of(context)
            .pushReplacementNamed('/login'); // Pastikan route '/login' ada
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/splash1.png', // Path ke gambar latar belakang
            ),
            fit: BoxFit.cover, // Gambar menutupi seluruh layar
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
