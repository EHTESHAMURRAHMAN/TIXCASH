import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tixcash/models/models.dart';
import 'package:tixcash/shared/shared.dart';
import '../shared.dart';
import 'sh_textfield.dart';
// enum VALIDATE {USER, EMAIL, PASSWORD, PHONE, ADDRESS, DOB, CIVIL, OTP, PNUMBER}

class TextFieldIcon extends StatefulWidget {
  final SuffixWidget? suffix;
  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final Function(FieldData)? onChanged;
  final Function()? onPressed;
  final VALIDATE validate;
  final bool obscureText;
  final TextInputType textInputType;
  const TextFieldIcon({
    Key? key,
    this.suffix,
    this.onChanged,
    this.validate = VALIDATE.USER,
    this.obscureText = false,
    this.hintText = '',
    this.controller,
    this.labelText = '',
    this.onPressed,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  _TextFieldIconState createState() => _TextFieldIconState();
}

class _TextFieldIconState extends State<TextFieldIcon> {
  bool _showPass = true;
  bool _isValid = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
            color: ColorConstants.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
                child: AppTextField(
              labelText: widget.labelText,
              textInputType: widget.textInputType,
              hintText: widget.hintText,
              validate: widget.validate,
              onChanged: (val) {
                if (widget.onChanged != null) {
                  widget.onChanged!(val);
                }
                if (_isValid != val.valid) {
                  if (mounted) setState(() => _isValid = val.valid);
                }
              },
              obscureText: widget.obscureText ? _showPass : false,
              controller: widget.controller,
            )),
            widget.suffix != null
                ? GestureDetector(
                    child: _showPass
                        ? widget.suffix?.primary
                        : widget.suffix?.secondary,
                    onTap: () {
                      if (widget.onPressed != null) {
                        widget.onPressed!();
                      }
                      if (mounted) {
                        setState(() {
                          _showPass = !_showPass;
                          print('object => $_showPass');
                        });
                      }
                    },
                  )
                : Icon(
                    Icons.check,
                    color: _isValid
                        ? ColorConstants.secondaryDarkAppColor
                        : Colors.white12,
                  )
          ],
        ));
  }
}

// class FieldData{
//   final String data;
//   final bool valid;
//   FieldData({required this.data, required this.valid});
// }