
import 'package:app/features/user/data/datasource/user_data_source.dart';
import 'package:app/features/user/data/repositories/user_repository_imp.dart';
import 'package:app/features/user/domain/user_repository.dart';
import 'package:app/features/user/domain/usecases/register_user.dart';
import 'package:app/features/register/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => RegisterBloc(registerUser: sl()));

  // Use Cases
  sl.registerLazySingleton(() => RegisterUser(repository: sl()));

  // Repositories
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImp(userDataSource: sl()));

  // Data source
  sl.registerLazySingleton<UserDataSource>(
      () => RegisterUserDataSourceImp());
}
