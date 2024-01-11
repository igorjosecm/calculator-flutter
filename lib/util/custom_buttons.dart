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

class DoubleButton extends StatelessWidget {
  final String number;
  final double buttonHeight;
  final double buttonWidth;
  final Function() fun;
  final double? fontSize;

  const DoubleButton({
    required this.number,
    required this.fun,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      child: TextButton(
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
          minimumSize: MaterialStateProperty.all<Size>(
            Size((buttonWidth * 2 + 12), buttonHeight),
          ),
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => Colors.grey[800] as Color,
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return const Color.fromARGB(90, 255, 255, 255);
              }
              return null;
            },
          ),
        ),
        onPressed: fun,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
