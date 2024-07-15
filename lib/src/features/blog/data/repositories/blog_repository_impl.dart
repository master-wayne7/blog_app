import 'dart:io';

import 'package:blog_app/src/core/error/exceptions.dart';
import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/network/connection_checker.dart';
import 'package:blog_app/src/features/blog/data/data_sources/blog_local_datasource.dart';
import 'package:blog_app/src/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_app/src/features/blog/data/model/blog_model.dart';
import 'package:blog_app/src/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/src/features/blog/domain/repositories/blog_repositories.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImpl(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
    this.connectionChecker,
  );
  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String userId,
    required List<String> topics,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure("No Internet Connection"));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        userId: userId,
        title: title,
        content: content,
        imageUrl: "",
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(blog: blogModel, image: image);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      return right(await blogRemoteDataSource.uploadBlog(blogModel));
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    if (!await connectionChecker.isConnected) {
      final blogs = blogLocalDataSource.loadBlogs();
      return right(blogs);
    }
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlog(blogs: blogs);
      return right(blogs);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
