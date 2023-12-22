import 'package:flutter/material.dart';
import 'package:tixcash/shared/shared.dart';

class SARoundedButton extends StatelessWidget {
  final Widget child;
  final double height;
  final double? width;
  final Color? color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Function() onPressed;
  const SARoundedButton(
      {Key? key,
      required this.child,
      this.height = 50.0,
      this.width,
      this.color,
      this.padding,
      this.margin,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding ?? const EdgeInsets.all(8),
        margin: margin ?? const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color ?? ColorConstants.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
