import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Data pengguna yang akan ditampilkan
  String name = "Gavrila";
  String email = "gavrila@gmail.com";
  String phone = "0123456789";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5F3), // Latar belakang yang lembut
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.rowdies(
            textStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 109, 65, 42),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFDF5F3), // Warna appbar
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 109, 65, 42)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto Profil
            Container(
              width: 140,
              height: 140,
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/ava2.png', // Gambar profil
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Informasi Pengguna
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserInfoRow(
                      label: "Name",
                      value: name,
                      icon: Icons.person,
                    ),
                    const Divider(color: Colors.grey),
                    _buildUserInfoRow(
                      label: "Email",
                      value: email,
                      icon: Icons.email,
                    ),
                    const Divider(color: Colors.grey),
                    _buildUserInfoRow(
                      label: "Phone",
                      value: phone,
                      icon: Icons.phone,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tombol Logout
            _buildCard(
              icon: Icons.logout,
              text: "Logout",
              iconColor: Colors.red,
              onTap: () {
                // Tampilkan dialog konfirmasi
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: Text(
                      "Confirm Logout",
                      style: GoogleFonts.rowdies(
                        color: const Color.fromARGB(255, 109, 65, 42),
                      ),
                    ),
                    content: Text(
                      "Are you sure you want to log out?",
                      style: GoogleFonts.rowdies(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.rowdies(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Tutup dialog
                          Navigator.pushReplacementNamed(
                              context, '/login'); // Logout
                        },
                        child: Text(
                          "Logout",
                          style: GoogleFonts.rowdies(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoRow({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(icon, color: const Color.fromARGB(255, 109, 65, 42), size: 24),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.rowdies(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.rowdies(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 109, 65, 42),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String text,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 30),
        title: Text(
          text,
          style: GoogleFonts.rowdies(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 109, 65, 42),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
