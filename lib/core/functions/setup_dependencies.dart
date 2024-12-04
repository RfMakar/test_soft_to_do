import 'package:get_it/get_it.dart';
import 'package:test_soft_to_do/data/data_soures/sqflite.dart';
import 'package:test_soft_to_do/data/repositories_impl/to_do_imp.dart';
import 'package:test_soft_to_do/domain/repositories/to_do.dart';
import 'package:test_soft_to_do/presentation/screens/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  //sqflite
  sl.registerLazySingleton<SqfliteClientApp>(
    () => SqfliteClientApp(),
  );
  //repositories
  sl.registerLazySingleton<ToDoRepository>(
    () => ToDoRepositoryImpl(
      sqfliteClientApp: sl(),
    ),
  );
  //bloc screen
  sl.registerFactory(() => HomeBloc(sl()));
}
