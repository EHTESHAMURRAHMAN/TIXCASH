import 'package:flutter/material.dart';

import '../shared.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function() onPressed;
  final EdgeInsets margin;
  final Color? color;
  const SubmitButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.isActive = true,
      this.margin = const EdgeInsets.all(0),
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onPressed : null,
      child: Container(
        margin: margin,
        // width: double.infinity,
        height: 50,
        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: color ??
              (isActive ? ColorConstants.white.withOpacity(0.1) : Colors.grey),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
