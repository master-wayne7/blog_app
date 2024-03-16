import 'package:blog_app/src/core/error/exceptions.dart';
import 'package:blog_app/src/features/auth/data/models/user_model.dart';
import 'package:supabase/supabase.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String name,
    required String password,
  });
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<UserModel> signInWithEmailPassword({required String email, required String password}) async {
    // try {
    // final response = await supabaseClient.auth.signInWithPassword(email: email, password: password);

    // } catch (e) {

    // }
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUpWithEmailPassword({required String email, required String name, required String password}) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );
      if (response.user == null) {
        throw const ServerExceptions("User is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
