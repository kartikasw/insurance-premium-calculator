import 'dart:async';

import 'package:flutter/material.dart';

class Navigation {
  static _slideToLeft(Animation<double> animation, Widget child) => SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(animation),
    child: child,
  );

  static FutureOr<dynamic> push(
    BuildContext context,
    Widget widget,
  ) async {
    return await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return _slideToLeft(animation, child);
        },
      ),
    );
  }

  static FutureOr<dynamic> pushReplacement(
      BuildContext context,
      Widget widget,
      ) async {
    return await Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return _slideToLeft(animation, child);
        },
      ),
    );
  }
}
