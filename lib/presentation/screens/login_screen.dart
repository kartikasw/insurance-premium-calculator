import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_challenge/presentation/common_widgets/text_filed.dart';
import 'package:insurance_challenge/resource/assets.gen.dart';
import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/app_router.dart';
import 'package:insurance_challenge/utils/extensions.dart';
import 'package:insurance_challenge/utils/navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _numberController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.iconsOrnamentLogin.path,
                height: context.mediaQuery.size.height * 0.3,
                fit: BoxFit.fill,
              ),
              Text(
                context.tr(StringRes.loginWelcome.name),
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 30),
                child: Text(
                  context.tr(StringRes.loginDescription.name),
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              KbTextFormField(
                labelText: context.tr(StringRes.username.name),
                keyboardType: TextInputType.text,
                controller: _numberController,
                prefixIcon: Icons.person_rounded,
              ),
              KbTextFormField(
                labelText: context.tr(StringRes.password.name),
                keyboardType: TextInputType.text,
                controller: _passwordController,
                prefixIcon: Icons.lock_rounded,
                suffixIcon: _passwordVisible
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                onSuffixIconTap: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                obscureText: !_passwordVisible,
                marginBottom: 40,
              ),
              ElevatedButton(
                onPressed: _onLoginClick,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginClick() {
    Navigation.slideToLeft(context, AppRouter.home());
  }
}
