import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/model_user.dart'; // Model untuk data pengguna

class ApiService {
  var client = http.Client();
  final String baseUrl =
      'http://10.0.2.2:3001/users'; // Ganti localhost dengan 10.0.2.2 untuk emulator

  // Fungsi untuk mengambil data pengguna (GET)
  Future<List<User>?> getUsers() async {
    var uri = Uri.parse(baseUrl);
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      try {
        // Parsing data JSON dan memetakan ke List<User>
        List<dynamic> usersJson = json.decode(response.body);
        return usersJson.map((data) => User.fromJson(data)).toList();
      } catch (e) {
        print("Gagal parsing data: $e");
        return null;
      }
    } else {
      print("Gagal mengambil data pengguna: ${response.statusCode}");
      print("Response Body: ${response.body}");
      return null;
    }
  }

  // Fungsi untuk menambahkan data pengguna baru (POST)
  Future<bool> addUser(User user) async {
    var uri = Uri.parse(baseUrl);

    // Mengirim data pengguna tanpa ID, JSON Server akan menambahkan ID secara otomatis
    var response = await client.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 201) {
      print("Data pengguna berhasil ditambahkan!");
      return true;
    } else {
      print("Gagal menambahkan data pengguna: ${response.statusCode}");
      return false;
    }
  }

  // Fungsi untuk menghapus data pengguna (DELETE)
  Future<bool> deleteUser(String id) async {
    var uri = Uri.parse('$baseUrl/$id');
    var response = await client.delete(uri);

    if (response.statusCode == 200) {
      print("Data pengguna berhasil dihapus!");
      return true;
    } else {
      print("Gagal menghapus data pengguna: ${response.statusCode}");
      return false;
    }
  }

  // Fungsi untuk mengupdate data pengguna (PUT)
  Future<bool> updateUser(User user) async {
    var uri = Uri.parse('$baseUrl/${user.id}');
    var response = await client.put(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    print("Request body: ${jsonEncode(user.toJson())}");
    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      print("Data pengguna berhasil diupdate!");
      return true;
    } else {
      print("Gagal mengupdate data pengguna: ${response.statusCode}");
      return false;
    }
  }
}
