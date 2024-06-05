import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';

class FormCustom extends StatelessWidget {
  const FormCustom({
    required this.labelText,
    super.key,
    this.width = 310,
    this.height = 80,
    this.required = false,
    this.iconsuffixRequired = false,
    this.iconprefixRequired = false,
    this.iconprefix,
    this.iconsuffix,
    this.obscureText = false,
    this.onSuffixIconTap,
    this.controller,
  });

  final String labelText;
  final double width;
  final double height;
  final bool required;
  final bool iconsuffixRequired;
  final bool iconprefixRequired;
  final IconData? iconprefix;
  final IconData? iconsuffix;
  final bool obscureText;
  final VoidCallback? onSuffixIconTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          floatingLabelStyle: TextStyle(
            color: primary,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: textTheme,
          ),
          prefixIcon: iconprefixRequired
              ? Icon(
                  iconprefix,
                  color: primary,
                )
              : null,
          suffixIcon: iconsuffixRequired
              ? GestureDetector(
                  onTap: onSuffixIconTap,
                  child: Icon(
                    iconsuffix,
                    color: primary,
                  ),
                )
              : null,
          helperText: required ? 'Obligatorio' : '',
          helperStyle: TextStyle(
            color: primary,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: textTheme,
          ),
          labelText: labelText,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: primary,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}
