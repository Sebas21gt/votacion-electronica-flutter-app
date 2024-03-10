import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primary = Color(0xFF173753);
const secondary = Color(0xFFE3EBFF);
const backgroundColor = Color(0xFFF5F5F5);

const textPrimary = Color(0xFFE3EBFF);
const textSecondary = Color(0xFF757575); // Colors.grey[600]

const fieldColor = Color(0xFFF1F1F1);
const labelColor = Color(0xFFB2B2B2);

final textTheme = GoogleFonts.quicksand();

MaterialStateProperty<TextStyle?> get textStyleButton {
  return MaterialStatePropertyAll(
    TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      fontFamily: textTheme.fontFamily,
    ),
  );
}

const bottomNavigationBarIconSize = 28.0;
