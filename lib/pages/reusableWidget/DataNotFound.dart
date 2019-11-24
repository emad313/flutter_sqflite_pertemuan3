import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(
          "images/illustration/404.png",
          fit: BoxFit.cover,
          width: ScreenUtil.getInstance().width,
        ),
      ),
    );
  }
}
