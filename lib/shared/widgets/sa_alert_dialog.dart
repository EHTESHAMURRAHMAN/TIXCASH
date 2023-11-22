import 'package:flutter/material.dart';

class SAAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancel;
  final String confirm;
  final Function()? onCancel;
  final Function() onConfirm;
  const SAAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      this.onCancel,
      required this.onConfirm,
      this.cancel = 'Cancel',
      this.confirm = 'Confirm'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(content),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                TextButton(
                  onPressed: onCancel,
                  child: Text(cancel),
                ),
                TextButton(
                  onPressed: onConfirm,
                  child: Text(confirm),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
