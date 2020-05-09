import 'package:app/features/sign_up/data/datasource/auth_data_source.dart';
import 'package:app/features/sign_up/data/repositories/register_user_repository_imp.dart';
import 'package:app/features/sign_up/domain/repositories/register_user_repository.dart';
import 'package:app/features/sign_up/domain/usercases/register_user.dart';
import 'package:app/features/sign_up/presentation/bloc/sign_up_page_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => SignUpBloc(registerUser: sl()));

  // Use Cases
  sl.registerLazySingleton(() => RegisterUser(sl()));

  // Repositories
  sl.registerLazySingleton<RegisterUserRepository>(
      () => RegisterUserRepositoryImp(authDataSource: sl()));

  // Data source
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImp());
}
