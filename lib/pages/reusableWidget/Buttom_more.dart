import 'package:flutter/material.dart';

class ButtonMore extends StatelessWidget {
  final String name;
  ButtonMore(this.name);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => "",
      child: Chip(
        labelStyle: TextStyle(color: Colors.white),
        label: Text(name),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
