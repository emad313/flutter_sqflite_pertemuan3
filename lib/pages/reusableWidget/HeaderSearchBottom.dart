import 'package:flutter/material.dart';
import 'package:flutter_news/pages/reusableWidget/Buttom_more.dart';
import 'package:flutter_news/pages/reusableWidget/config_responsive.dart';

class HeaderSearchBottom extends StatelessWidget {
  final String namaKiri;
  final String namaKanan;
  HeaderSearchBottom({this.namaKiri, this.namaKanan});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                namaKiri,
                style: ResponsiveUI.judulTextStyle,
              ),
            ),
          ),
          Container(
            child: ButtonMore(namaKanan),
          )
        ],
      ),
    );
  }
}
