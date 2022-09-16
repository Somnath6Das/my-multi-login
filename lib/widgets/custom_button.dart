import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const CustomButton(
      {super.key, required this.text, required this.onTap, required this.color,});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      color: color,
      onPressed: onTap,
      child: Text(text, style:const TextStyle(color: Colors.white, fontSize: 12),),);
  }
}
