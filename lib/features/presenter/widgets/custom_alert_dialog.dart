import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAlertDialog {
  showCustomAlertDialog(
      {Icon? icon,
      required String title,
      String? content,
      Widget? contentWidget,
      List<Widget>? actions}) {
    return AlertDialog(
      backgroundColor: Colors.white,
      icon: icon,
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: contentWidget ?? Text(content ?? ''),
      actions: actions,
    );
  }
}
