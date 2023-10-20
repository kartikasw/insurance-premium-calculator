import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insurance_challenge/resource/colors.gen.dart';
import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/extensions.dart';

class KbTextFormField extends StatelessWidget {
  const KbTextFormField({
    this.required = true,
    this.enabled = true,
    this.formTitle,
    this.controller,
    this.labelText,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onSuffixIconTap,
    this.obscureText = false,
    this.marginBottom = 25,
    this.inputFormatters,
    super.key,
  });

  final bool required;
  final bool enabled;
  final String? formTitle;
  final String? initialValue;
  final TextEditingController? controller;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final void Function()? onSuffixIconTap;
  final bool obscureText;
  final double marginBottom;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = TextFormField(
      enabled: enabled,
      initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      validator: (value) {
        if (required) {
          if (value == null || value.isEmpty) {
            return context.tr(StringRes.errorEmpty.name);
          }
        }
        return null;
      },
      inputFormatters: inputFormatters,
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: context.colorScheme.surface,
        labelText: labelText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: context.colorScheme.onPrimary)
            : null,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixIconTap,
                child: Icon(suffixIcon, color: context.colorScheme.onPrimary),
              )
            : null,
      ),
      scrollPadding: EdgeInsets.only(
        bottom: context.mediaQuery.viewInsets.bottom,
      ),
    );

    if (formTitle != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr(formTitle!),
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorName.yellow700,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0, bottom: marginBottom),
            child: mainWidget,
          )
        ],
      );
    } else {
      return Container(
        margin: EdgeInsets.only(bottom: marginBottom),
        child: mainWidget,
      );
    }
  }
}
