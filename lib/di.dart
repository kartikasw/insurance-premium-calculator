import 'package:get_it/get_it.dart';
import 'package:insurance_challenge/core/data/repository_impl.dart';
import 'package:insurance_challenge/core/domain/repository/repository.dart';
import 'package:insurance_challenge/core/domain/use_case/add_premium_calculation.dart';
import 'package:insurance_challenge/core/domain/use_case/get_history_list.dart';
import 'package:insurance_challenge/core/domain/use_case/login.dart';
import 'package:insurance_challenge/core/domain/use_case/logout.dart';
import 'package:insurance_challenge/presentation/bloc/form/form_bloc.dart';
import 'package:insurance_challenge/presentation/bloc/history/history_bloc.dart';
import 'package:insurance_challenge/presentation/bloc/result/result_bloc.dart';

final locator = GetIt.instance;

void setUpDependencies() {
  locator.registerLazySingleton<Repository>(() => RepositoryImpl());

  locator.registerLazySingleton(() => AddPremiumCalculation(locator()));
  locator.registerLazySingleton(() => GetHistoryList(locator()));
  locator.registerLazySingleton(() => Login(locator()));
  locator.registerLazySingleton(() => Logout(locator()));

  locator.registerFactory(() => FormBloc(locator(), locator(), locator()));
  locator.registerFactory(() => HistoryBloc(locator()));
  locator.registerFactory(() => ResultBloc());
}