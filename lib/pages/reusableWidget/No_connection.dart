import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(
          "images/illustration/no_connection.png",
          fit: BoxFit.cover,
          width: ScreenUtil.getInstance().width,
        ),
      ),
    );
  }
}
