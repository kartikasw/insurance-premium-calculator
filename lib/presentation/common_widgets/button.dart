import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_challenge/resource/colors.gen.dart';
import 'package:insurance_challenge/utils/extensions.dart';

class KbTextButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  final EdgeInsets? margin;
  final TextAlign? textAlign;
  final Alignment? alignment;

  const KbTextButton(
    this.buttonText, {
    this.onTap,
    this.margin,
    this.textAlign,
    this.alignment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = GestureDetector(
      onTap: onTap,
      child: Text(
        context.tr(buttonText).toLowerCase(),
        textAlign: textAlign,
        style: context.textTheme.bodyMedium?.copyWith(
          color: ColorName.blue400,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

    if (margin == null) {
      return mainWidget;
    } else {
      return Container(alignment: alignment, margin: margin, child: mainWidget);
    }
  }
}
