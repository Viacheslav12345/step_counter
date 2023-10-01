class Achievement {
  final String image;
  final String title;
  final String description;

  Achievement(
      {required this.image, required this.title, required this.description});

  static Achievement fromJson(Map<String, dynamic> json) => Achievement(
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['description'] as String);

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'description': description,
    };
  }
}
