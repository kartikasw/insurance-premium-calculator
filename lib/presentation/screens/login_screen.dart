import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_challenge/presentation/bloc/form/form_bloc.dart';
import 'package:insurance_challenge/presentation/common_widgets/state.dart';
import 'package:insurance_challenge/presentation/common_widgets/text_filed.dart';
import 'package:insurance_challenge/resource/assets.gen.dart';
import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/extensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = true;

  LoadingState? _loading;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormBloc, KbFormState>(
      listener: _onFormBlocListener,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(right: 25, left: 25, top: 40),
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
                  labelText: context.tr(StringRes.email.name),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
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
                  obscureText: _passwordVisible,
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
      ),
    );
  }

  void _onLoginClick() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<FormBloc>(context).add(
        FormEventLogin(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  void _onFormBlocListener(BuildContext context, KbFormState state) {
    if (state is KbFormStateLoading) {
      _loading ??= LoadingState(context);
      _loading?.show();
    } else if (state is KbFormStateSuccess) {
      _loading?.dismiss();
      Navigator.pop(context, true);
    } else if (state is KbFormStateError) {
      _loading?.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errMessage),
          action: SnackBarAction(label: 'dismiss', onPressed: () {}),
        ),
      );
    }
  }
}
