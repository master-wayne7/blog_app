import 'package:blog_app/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/src/core/network/connection_checker.dart';
import 'package:blog_app/src/core/secrets/app_secrets.dart';
import 'package:blog_app/src/features/auth/injection_container.dart';
import 'package:blog_app/src/features/blog/injection_container.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  initAuth();
  initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator
    ..registerLazySingleton(() => supabase.client)
    ..registerLazySingleton(() => Hive.box(name: "blogs"))
    ..registerFactory(() => InternetConnection())

    // core cubit
    ..registerLazySingleton(() => AppUserCubit())
    ..registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(serviceLocator()));
}
