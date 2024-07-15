import 'dart:io';

import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/usecase/usecase.dart';
import 'package:blog_app/src/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/src/features/blog/domain/repositories/blog_repositories.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<BlogEntity, UploadBlogParams> {
  final BlogRepository repository;

  UploadBlog({required this.repository});
  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async {
    return await repository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      userId: params.userId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String userId;
  final String title;
  final String content;
  final List<String> topics;
  final File image;

  UploadBlogParams({
    required this.userId,
    required this.title,
    required this.content,
    required this.topics,
    required this.image,
  });
}
