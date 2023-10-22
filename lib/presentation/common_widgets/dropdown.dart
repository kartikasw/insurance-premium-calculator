import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_challenge/resource/colors.gen.dart';
import 'package:insurance_challenge/utils/extensions.dart';

class KbDropdown extends StatelessWidget {
  final dynamic selectedItem;
  final String? title;
  final List<DropdownMenuItem<dynamic>>? items;
  final void Function(dynamic) onChanged;

  const KbDropdown({
    this.selectedItem,
    this.title,
    this.items,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = DropdownButtonFormField(
      items: items,
      value: selectedItem,
      onChanged: onChanged,
      elevation: 0,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.colorScheme.surface,
      ),
    );

    if (title != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            context.tr(title!),
            style: context.textTheme.bodyLarge?.copyWith(
              color: ColorName.yellow700,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 25),
            child: mainWidget,
          ),
        ],
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: mainWidget,
      );
    }
  }
}
