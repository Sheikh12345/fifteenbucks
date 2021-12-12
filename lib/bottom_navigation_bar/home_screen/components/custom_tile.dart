import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final bgColor;
  final txtColor;
 final onTap;
  CustomTile(
      {Key? key,
      required this.title,
      this.bgColor,
      this.txtColor,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(25)),
        padding: EdgeInsets.all(10),
        child: Text(
          '$title',
          style:
              GoogleFonts.cabin(color: txtColor, fontSize: size.width * 0.04),
        ),
      ),
    );
  }
}
