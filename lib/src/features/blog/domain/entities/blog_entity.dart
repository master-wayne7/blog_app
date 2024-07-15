// ignore_for_file: public_member_api_docs, sort_constructors_first
class BlogEntity {
  final String id;
  final String? name;
  final String userId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updatedAt;

  BlogEntity({
    this.name,
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
  });
}
