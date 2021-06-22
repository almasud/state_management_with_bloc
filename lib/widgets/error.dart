import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;
  ErrorText({Key? key, required this.message, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 20,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
