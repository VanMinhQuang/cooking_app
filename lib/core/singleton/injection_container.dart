import 'package:cooking_project/domain/repositories/auth_repo/login_auth_repo.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/login_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async{
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImplement());
}