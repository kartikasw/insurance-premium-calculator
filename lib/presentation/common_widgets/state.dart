import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/extensions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingState {
  BuildContext? _context;
  Widget? _widget;

  LoadingState(BuildContext context) {
    _context = context;
    _widget = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            LoadingAnimationWidget.threeArchedCircle(
              color: context.colorScheme.primary,
              size: 30,
            ),
            const SizedBox(width: 16),
            Text(
              context.tr(StringRes.loading.name),
              style: context.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
    debugPrint('create loading state, ${_context == null}');
  }

  void show() {
    showDialog(
      barrierDismissible: false,
      context: _context!,
      builder: (context) => _widget!,
    );
  }

  void dismiss() {
    Navigator.pop(_context!);
  }

  void close() {
    _context = null;
    _widget = null;
  }
}
