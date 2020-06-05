
import 'package:app/features/register/data/datasource/user_data_source.dart';
import 'package:app/features/register/data/repositories/user_repository_imp.dart';
import 'package:app/features/register/domain/usecases/register_user.dart';
import 'package:app/features/register/domain/user_repository.dart';
import 'package:app/features/register/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => RegisterBloc(registerUser: sl()));

  // Use Cases
  sl.registerLazySingleton(() => RegisterUser(repository: sl()));

  // Repositories
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImp(userDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImp());
}
