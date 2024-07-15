import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/usecase/usecase.dart';
import 'package:blog_app/src/core/common/entities/user.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;
  CurrentUser(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.currentUser();
  }
}
