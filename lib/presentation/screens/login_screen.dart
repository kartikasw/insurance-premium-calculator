import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: Image.asset('')),
        Column(
          children: <Widget>[
            Text(''),
            Text(''),
            ElevatedButton(onPressed: (){}, child: Text())
          ],
        )
      ],
    );
  }
}