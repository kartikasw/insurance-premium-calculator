import 'package:flutter/material.dart';
import 'package:insurance_challenge/resource/colors.gen.dart';

class WrappedIcon extends StatelessWidget {
  const WrappedIcon({
    required this.icon,
    this.color = ColorName.black,
    this.margin = const EdgeInsets.only(right: 12),
    this.padding,
    this.decoration,
    this.size,
    this.onTap,
    super.key,
  });

  final Color? color;
  final IconData icon;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final double? size;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: decoration,
        child: Icon(icon, color: color, size: size),
      ),
    );
  }
}
