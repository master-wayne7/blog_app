import 'dart:io';

import 'package:blog_app/src/core/usecase/usecase.dart';
import 'package:blog_app/src/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/src/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/src/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _getAllBlogs = getAllBlogs,
        _uploadBlog = uploadBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });
    on<BlogUploadEvent>(_onBlogUpload);
    on<BlogGetAllEvent>(_onGetAllBlogs);
  }

  void _onBlogUpload(BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
      userId: event.userId,
      title: event.title,
      content: event.content,
      topics: event.topics,
      image: event.image,
    ));
    res.fold(
      (l) => emit(BlogFailure(error: l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _onGetAllBlogs(BlogGetAllEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParams());
    res.fold(
      (l) => emit(BlogFailure(error: l.message)),
      (r) => emit(BlogFetchSuccess(blogs: r)),
    );
  }
}
