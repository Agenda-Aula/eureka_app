import 'package:app/features/authentication/data/data_source/user_data_source.dart';
import 'package:app/features/authentication/data/repositories/user_repository_imp.dart';
import 'package:app/features/authentication/domain/usecases/sign_up_user.dart';
import 'package:app/features/authentication/domain/user_repository.dart';
import 'package:app/features/authentication/presentation/bloc/sign_up/bloc.dart';

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
  sl.registerLazySingleton<UserDataSource>(() => UserDataSourceImp());
}
