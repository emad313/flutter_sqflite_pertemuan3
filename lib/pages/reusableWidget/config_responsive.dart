import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveUI {
  ResponsiveUI.config(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    ScreenUtil.instance = ScreenUtil(
        width: screenWidth, height: screenHeight, allowFontScaling: true)
      ..init(context);
  }
  static final double fontInfo = ScreenUtil(allowFontScaling: true).setSp(9);

  static final double fontJudul = ScreenUtil(allowFontScaling: true).setSp(14);

  static final double fontJudulHeadline =
      ScreenUtil(allowFontScaling: true).setSp(20);

  static final double fontIcon = ScreenUtil(allowFontScaling: true).setSp(14);

  static final double fontJudulSearchKeyword =
      ScreenUtil(allowFontScaling: true).setSp(14);

  static final judulHeadlineTextStyle = TextStyle(
    fontFamily: 'Signika',
    fontSize: fontJudulHeadline,
    letterSpacing: 1.5,
  );

  static final judulTextStyle = TextStyle(
    letterSpacing: 1.25,
    fontSize: fontJudul,
    color: Colors.grey[800],
    fontFamily: 'Signika',
  );

  static final infoTextStyle = TextStyle(
      fontSize: fontInfo,
      fontFamily: 'Exo',
      letterSpacing: 1.25,
      color: Colors.grey[800]);

  static final textChipStyle = TextStyle(
    fontFamily: 'Exo',
    color: Colors.white,
    fontSize: ScreenUtil(allowFontScaling: true).setSp(9),
    fontWeight: FontWeight.bold,
  );
  static final textNamaWartawanStyle = TextStyle(
    fontFamily: 'Exo',
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    fontSize: ScreenUtil(allowFontScaling: true).setSp(20),
  );
  static final textNamaWartawanStylWhite = TextStyle(
    fontFamily: 'Exo',
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: ScreenUtil(allowFontScaling: true).setSp(20),
  );
}
