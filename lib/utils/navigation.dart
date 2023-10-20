import 'dart:async';

import 'package:flutter/material.dart';

class Navigation {
  static FutureOr<dynamic> slideToLeft(
      BuildContext context,
      Widget widget,
      ) async {
    return await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

  static FutureOr<dynamic> slideToTop(
      BuildContext context, Widget widget) async {
    return await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }
}
