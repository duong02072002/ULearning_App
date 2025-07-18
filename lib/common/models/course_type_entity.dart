class CourseTypeEntity {
  final int id;
  final String title;

  CourseTypeEntity({required this.id, required this.title});

  factory CourseTypeEntity.fromJson(Map<String, dynamic> json) {
    return CourseTypeEntity(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}
