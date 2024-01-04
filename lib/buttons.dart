import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({super.key, this.color, this.textColor, required this.buttonText, this.buttonTapped});
  final color;
  final textColor;
  final buttonTapped;
  final String buttonText;
  final myTextStyle = TextStyle(fontSize: 18, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 25,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
