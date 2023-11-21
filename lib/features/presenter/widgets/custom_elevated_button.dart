import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.text,
    this.buttonColor,
    this.iconData,
    this.iconColor,
    this.onPressed,
    this.textStyle,
  });

  final VoidCallback? onPressed;
  final String? text;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final IconData? iconData;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          children: [
            iconData != null
                ? Icon(
                    iconData,
                    color: iconColor,
                  )
                : Container(),
            SizedBox(
              width: 10,
            ),
            Text(
              text ?? "",
              style: textStyle,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            )),
      ),
    );
  }
}
