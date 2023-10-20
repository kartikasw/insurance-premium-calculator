import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_challenge/di.dart';
import 'package:insurance_challenge/presentation/bloc/form/form_bloc.dart';
import 'package:insurance_challenge/presentation/bloc/history/history_bloc.dart';
import 'package:insurance_challenge/presentation/screens/form_screen.dart';
import 'package:insurance_challenge/presentation/screens/history_screen.dart';
import 'package:insurance_challenge/presentation/screens/home_screen.dart';
import 'package:insurance_challenge/presentation/screens/login_screen.dart';

class AppRouter {
  static Widget login() => BlocProvider(
    create: (context) => locator<FormBloc>(),
    child: const LoginScreen(),
  );

  static Widget home() => BlocProvider(
        create: (context) => locator<HistoryBloc>(),
        child: const HomeScreen(),
      );

  static Widget form() => BlocProvider(
        create: (context) => locator<FormBloc>(),
        child: const FormScreen(),
      );

  static Widget history() => BlocProvider(
    create: (context) => locator<HistoryBloc>(),
    child: const HistoryScreen(),
  );
}
