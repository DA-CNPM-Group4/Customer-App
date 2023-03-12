import 'package:flutter/material.dart';

class FakeSearch extends StatelessWidget {
  IconData? prefixIcon;
  IconData? suffixIcon;
  String hint;
  Color? prefixIconColor;
  Color? suffixIconColor;
  TextStyle? hintStyle;
  Function()? onTap;
  Color? borderColor;
  Color? backgroundColor;

  FakeSearch(
      {Key? key,
      this.prefixIcon,
      this.suffixIcon,
      required this.hint,
      this.prefixIconColor,
      this.suffixIconColor,
      this.hintStyle,
        this.onTap,
        this.borderColor,
        this.backgroundColor
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor ?? Colors.white,
          border: Border.all(color: borderColor ?? Colors.white)

      ),
      child: ListTile(
        leading:Icon(prefixIcon, color: prefixIconColor,),
        title: Text(hint, style: hintStyle,),
        trailing: Icon(suffixIcon, color: suffixIconColor,),
        dense: true,
        horizontalTitleGap: 0,
        visualDensity: const VisualDensity(vertical: -3),
        onTap: onTap,// to expand
      ),
    );
  }
}
