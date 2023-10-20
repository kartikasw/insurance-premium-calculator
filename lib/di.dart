import 'package:get_it/get_it.dart';
import 'package:insurance_challenge/core/data/repository_impl.dart';
import 'package:insurance_challenge/core/domain/repository/repository.dart';
import 'package:insurance_challenge/core/domain/use_case/get_history_list.dart';
import 'package:insurance_challenge/core/domain/use_case/login.dart';
import 'package:insurance_challenge/presentation/bloc/form/form_bloc.dart';
import 'package:insurance_challenge/presentation/bloc/history/history_bloc.dart';

final locator = GetIt.instance;

void setUpDependencies() {
  locator.registerLazySingleton<Repository>(() => RepositoryImpl());

  locator.registerLazySingleton(() => GetHistoryList(locator()));
  locator.registerLazySingleton(() => Login(locator()));

  locator.registerFactory(() => FormBloc(locator()));
  locator.registerFactory(() => HistoryBloc(locator()));
}