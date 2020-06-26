import 'package:app/features/authentication/data/data_source/authentication_service.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository_imp.dart';
import 'package:app/features/authentication/domain/usecases/register_with_credentials.dart';
import 'package:app/features/authentication/domain/authentication_repository.dart';
import 'package:app/features/authentication/presentation/bloc/sign_up/bloc.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => RegisterBloc(registerUser: sl()));
  // Use Cases
  sl.registerLazySingleton(() => RegisterWithCredentials(repository: sl()));

  // Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
      () => UserRepositoryImp(authenticationService: sl()));

  // Data sources
  sl.registerLazySingleton<UserDataSource>(() => UserDataSourceImp());
}
