import 'package:blog_app/src/core/error/exceptions.dart';
import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/network/connection_checker.dart';
import 'package:blog_app/src/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:blog_app/src/core/common/entities/user.dart';
import 'package:blog_app/src/features/auth/data/models/user_model.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure("User not logged in."));
        }
        return right(UserModel(
          id: session.user.id,
          email: session.user.email ?? "",
          name: '',
        ));
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure("User not logged in!"));
      }
      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailPassword({required String email, required String password}) async {
    return _getUser(
      () async => await remoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({required String name, required String email, required String password}) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        email: email,
        name: name,
        password: password,
      ),
    );
  }

  Future<Either<Failure, UserEntity>> _getUser(Future<UserEntity> Function() fn) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure("No Internet Connection"));
      }
      final user = await fn();
      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
