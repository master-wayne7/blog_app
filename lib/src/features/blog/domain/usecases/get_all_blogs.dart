import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/usecase/usecase.dart';
import 'package:blog_app/src/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/src/features/blog/domain/repositories/blog_repositories.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<BlogEntity>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
