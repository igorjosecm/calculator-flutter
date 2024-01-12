import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color? overlayColor;
  final double buttonHeight;
  final double buttonWidth;
  final double? fontSize;

  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.color,
    this.overlayColor,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 6,
          offset: const Offset(0, 0),
        ),
      ]),
      child: TextButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(
            Size(buttonWidth, buttonHeight),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => color,
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return overlayColor;
              }
              return null;
            },
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
