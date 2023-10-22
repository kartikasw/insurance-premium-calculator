import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_challenge/presentation/common_widgets/icon.dart';
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
  }

  void show() {
    showDialog(
      barrierDismissible: false,
      context: _context!,
      builder: (context) {
        return _widget!;
      },
    );
  }

  void dismiss() {
    Navigator.pop(_context!);
  }
}

class ErrorState extends StatelessWidget {
  const ErrorState(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              color: context.colorScheme.error,
              child: Column(
                children: [
                  WrappedIcon(
                    icon: Icons.error_outline_rounded,
                    size: context.mediaQuery.size.height * 0.1,
                    color: context.colorScheme.onError,
                    margin: const EdgeInsets.only(bottom: 12),
                  ),
                  Text(
                    'Error',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.onError,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Text(
                    message,
                    style: context.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: context.mediaQuery.size.width * 0.4,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.error,
                        foregroundColor: context.colorScheme.onError
                      ),
                      child: const Text('OK'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
