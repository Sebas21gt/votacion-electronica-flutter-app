import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    required this.text,
    super.key,
    this.icon,
    this.width = 150,
    this.height = 48,
    this.onPressed,
    this.outlined = false,
  });

  final String text;
  final IconData? icon;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    if (!outlined) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // padding: const EdgeInsets.only(
          //   left: spacing2Xl,
          //   right: spacing2Xl,
          //   top: spacingMd,
          //   bottom: spacingMd,
          // ),
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: primary),
          ),
          maximumSize: Size(width, height),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textPrimary,
                fontSize: 14,
                fontFamily: textTheme,
              ),
            ),
            if (icon != null) const SizedBox(width: 10),
            if (icon != null) Icon(icon, color: secondary, size: 20),
          ],
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // padding: const EdgeInsets.only(
          //   left: spacing2Xl,
          //   right: spacing2Xl,
          //   top: spacingMd,
          //   bottom: spacingMd,
          // ),
          backgroundColor: secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: primary),
          ),
          maximumSize: Size(width, height),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: textTheme,
              ),
            ),
            if (icon != null) const Spacer(),
            if (icon != null) Icon(icon, color: primary, size: 20),
          ],
        ),
      );
    }
  }
}
