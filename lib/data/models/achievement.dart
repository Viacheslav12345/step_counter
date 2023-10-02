class Achievement {
  final String image;
  final String title;
  final String description;
  final int point;

  Achievement({
    required this.image,
    required this.title,
    required this.description,
    required this.point,
  });

  static Achievement fromJson(Map<String, dynamic> json) => Achievement(
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      point: json['point'] as int);

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'description': description,
    };
  }
}
