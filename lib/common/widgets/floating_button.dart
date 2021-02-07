import 'package:flutter/material.dart';

// This widget should always be used inside a Stack, else will result in exception
class FloatingButton extends StatelessWidget {
  final VoidCallback onTap;
  final double width;
  final double height;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final Color shadowColor;
  final double elevation;

  const FloatingButton({
    this.onTap,
    this.width,
    this.height = 50.0,
    this.buttonText,
    this.buttonColor,
    this.textColor,
    this.shadowColor = Colors.black,
    this.elevation = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        height: this.height,
        width: this.width,
        decoration: BoxDecoration(
          color: this.buttonColor,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: this.shadowColor,
              offset: Offset(0.0, 1.0),
              blurRadius: elevation,
            ),
          ],
        ),
        child: Center(
          child: Text(
            this.buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: this.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
