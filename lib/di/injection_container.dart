import 'package:app/features/sign_up/data/datasource/user_data_source.dart';
import 'package:app/features/sign_up/data/repositories/user_repository_imp.dart';
import 'package:app/features/sign_up/domain/usecases/sign_up_user.dart';
import 'package:app/features/sign_up/domain/user_repository.dart';
import 'package:app/features/sign_up/presentation/bloc/bloc.dart';

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
