import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/usecase/usecase.dart';
import 'package:blog_app/src/features/auth/domain/entities/user.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<UserEntity, UserSignUpParams> {
  final AuthRepository repository;

  UserSignUp({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(UserSignUpParams params) async {
    return await repository.signUpWithEmailPassword(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
