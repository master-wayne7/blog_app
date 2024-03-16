import 'package:blog_app/src/core/error/exceptions.dart';
import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:blog_app/src/features/auth/domain/entities/user.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, UserEntity>> signInWithEmailPassword({required String email, required String password}) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({required String name, required String email, required String password}) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(email: email, name: name, password: password);
      return right(user.toEntity());
    } on ServerExceptions catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
