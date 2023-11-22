import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/shared/shared.dart';

class MineCell extends StatefulWidget {
  final IconData? icon;
  final String? svgIcon;
  final String title;
  final Widget trailing;
  final Widget subview;
  final Function()? onPressed;
  final bool isTrailing;
  const MineCell(
      {Key? key,
      this.icon,
      required this.title,
      this.trailing = const Icon(
        Icons.chevron_right,
        color: Colors.white,
        // color: Color(0xFF3D5AFE),
        size: 24,
      ),
      this.subview = const SizedBox(),
      this.onPressed,
      this.svgIcon,
      this.isTrailing = true})
      : super(key: key);

  @override
  _MineCellState createState() => _MineCellState();
}

class _MineCellState extends State<MineCell> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue,
      onTap: widget.onPressed,
      child: Container(
        height: 50,
        // ignore: unnecessary_null_comparison
        padding: EdgeInsets.only(
            left: 0,
            right: widget.trailing != null ? 0 : 16,
            top: 16,
            bottom: 16),
        child: Row(
          children: [
            widget.icon != null
                ? Icon(
                    widget.icon,
                    color: ColorConstants.secondaryDarkAppColor,
                    size: 36,
                  )
                : SizedBox(),
            widget.svgIcon != null
                ? SvgPicture.asset(
                    widget.svgIcon!,
                    color: Colors.white,
                  )
                : SizedBox(),
            widget.icon != null || widget.svgIcon != null
                ? const SizedBox(
                    width: 16,
                  )
                : const SizedBox(),
            Expanded(
                child: Text(
              widget.title,
              style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            )),
            widget.subview,
            SizedBox(
              width: widget.isTrailing ? 24 : 0,
            ),
            widget.isTrailing ? widget.trailing : SizedBox()
          ],
        ),
        // decoration: BoxDecoration(
        //     border: Border(bottom: BorderSide(color: Colors.white24, width: 0.5))
        // ),
      ),
    );
  }
}
