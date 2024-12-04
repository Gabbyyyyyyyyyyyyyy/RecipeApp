class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});

  // Fungsi untuk mengubah JSON menjadi objek Category
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['strCategory'], // Gantilah ini sesuai dengan response JSON
      imageUrl:
          json['strCategoryThumb'], // Gantilah ini sesuai dengan response JSON
    );
  }
}
