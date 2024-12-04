class User {
  final String id;
  final String username;
  final String password;
  final String email;
  final String phone;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
  });

  // Fungsi untuk mengonversi objek User menjadi Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
    };
  }

  // Fungsi untuk membuat objek User dari Map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(), // Pastikan ID selalu dalam bentuk String
      username: json['username'],
      password: json['password'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
