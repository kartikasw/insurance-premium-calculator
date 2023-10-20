import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_challenge/di.dart';
import 'package:insurance_challenge/presentation/screens/landing_screen.dart';
import 'package:insurance_challenge/resource/colors.gen.dart';
import 'package:insurance_challenge/utils/extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setUpDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('id')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insurance Challenge',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorName.purple50,
        fontFamily: 'PlusJakartaSans',
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: ColorName.yellow400,
          onPrimary: ColorName.black,
          secondary: ColorName.yellow400,
          onSecondary: ColorName.black,
          error: ColorName.red500,
          onError: ColorName.white,
          background: ColorName.purple50,
          onBackground: ColorName.black,
          surface: ColorName.white,
          onSurface: ColorName.black,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          foregroundColor: ColorName.black,
          backgroundColor: ColorName.yellow400,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorName.yellow400,
            foregroundColor: ColorName.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            textStyle: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'PlusJakartaSans',
            ),
            minimumSize: const Size.fromHeight(48),
          ),
        ),
      ),
      home: const LandingScreen(),
    );
  }
}
