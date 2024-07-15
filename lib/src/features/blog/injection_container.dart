import 'package:blog_app/dependency_injection.dart';
import 'package:blog_app/src/features/blog/data/data_sources/blog_local_datasource.dart';
import 'package:blog_app/src/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_app/src/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/src/features/blog/domain/repositories/blog_repositories.dart';
import 'package:blog_app/src/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/src/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/src/features/blog/presentation/bloc/blog_bloc.dart';

void initBlog() {
  // data source
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(() => BlogRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<BlogLocalDataSource>(() => BlogLocalDatasourceImpl(box: serviceLocator()))

    // repository
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
        ))

    // use case
    ..registerFactory<UploadBlog>(() => UploadBlog(repository: serviceLocator()))
    ..registerFactory<GetAllBlogs>(() => GetAllBlogs(serviceLocator()))

    // bloc
    ..registerLazySingleton<BlogBloc>(() => BlogBloc(uploadBlog: serviceLocator(), getAllBlogs: serviceLocator()));
}
