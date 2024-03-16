import 'package:blog_app/dependency_injection.dart';
import 'package:blog_app/src/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:blog_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_signup.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_bloc.dart';

void initAuth() {
  // data source
  serviceLocator.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(supabaseClient: serviceLocator()));

  // repository
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(serviceLocator()));

  // use case
  serviceLocator.registerFactory<UserSignUp>(() => UserSignUp(repository: serviceLocator()));

  // bloc
  serviceLocator.registerLazySingleton<AuthBloc>(() => AuthBloc(userSignUp: serviceLocator()));
}
