import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/usecase/usecase.dart';
import 'package:blog_app/src/core/common/entities/user.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements UseCase<UserEntity, UserSignInParams> {
  final AuthRepository repository;
  UserSignIn(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(UserSignInParams params) {
    return repository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
