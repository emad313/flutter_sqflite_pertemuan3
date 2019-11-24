import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: CircularProgressIndicator(
        backgroundColor: Colors.pink,
      ),
      alignment: Alignment.bottomCenter,
    );
  }
}
