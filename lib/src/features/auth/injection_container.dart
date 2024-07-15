import 'package:blog_app/dependency_injection.dart';
import 'package:blog_app/src/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:blog_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/src/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_signin.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_signup.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_bloc.dart';

void initAuth() {
  // data source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(supabaseClient: serviceLocator()))

    // repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(serviceLocator(), serviceLocator()))

    // use case
    ..registerFactory<UserSignUp>(() => UserSignUp(serviceLocator()))
    ..registerFactory<UserSignIn>(() => UserSignIn(serviceLocator()))
    ..registerFactory<CurrentUser>(() => CurrentUser(serviceLocator()))

    // bloc
    ..registerLazySingleton<AuthBloc>(() => AuthBloc(
          userSignUp: serviceLocator(),
          userSignIn: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator(),
        ));
}
