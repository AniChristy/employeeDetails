import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextAlign ? textAlign;
  final TextOverflow? textOverflow; 
  final int? maxLines;
  final double? height;

  const CustomText({Key? key,this.maxLines ,this.textOverflow ,this.text, this.size, this.color, this.weight, this.textAlign,this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign ?? TextAlign.start,
      overflow: textOverflow,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: size ?? 16,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
        height: height
      ),
    );
  }
}