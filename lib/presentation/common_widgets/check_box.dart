import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_challenge/resource/colors.gen.dart';
import 'package:insurance_challenge/utils/extensions.dart';

class KbCheckBox extends StatefulWidget {
  const KbCheckBox({
    required this.title,
    required this.items,
    required this.item,
    required this.selectedItems,
    super.key,
  });

  final String title;
  final List<dynamic> items;
  final Widget Function(dynamic) item;
  final Function(List<dynamic>) selectedItems;

  @override
  State<StatefulWidget> createState() => _KbCheckBoxState();
}

class _KbCheckBoxState extends State<KbCheckBox> {
  final List<dynamic> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          context.tr(widget.title),
          style: context.textTheme.bodyLarge?.copyWith(
            color: ColorName.yellow700,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 8, bottom: 25),
          itemCount: widget.items.length,
          itemBuilder: (context, index) => CheckboxListTile(
            value: _selectedItems.firstWhere((e) => e == widget.items[index],
                    orElse: () => null) !=
                null,
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  if (value) {
                    _selectedItems.add(widget.items[index]);
                  } else {
                    _selectedItems.remove(widget.items[index]);
                  }
                }
                widget.selectedItems(_selectedItems);
              });
            },
            title: widget.item(widget.items[index]),
          ),
        )
      ],
    );
  }
}
