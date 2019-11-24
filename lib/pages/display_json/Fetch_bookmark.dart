import 'package:flutter/material.dart';
import 'package:flutter_news/api/Api_news.dart';
import 'package:flutter_news/app/App_string.dart';
import 'package:flutter_news/database/Database_helper.dart';
import 'package:flutter_news/pages/reusableWidget/config_responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchBookmark extends StatefulWidget {
  final int idBerita;
  final String judulBerita;
  final String tanggalBerita;
  FetchBookmark({this.idBerita, this.judulBerita, this.tanggalBerita});
  @override
  _FetchBookmarkState createState() => _FetchBookmarkState();
}

class _FetchBookmarkState extends State<FetchBookmark> {
  ApiHelper api = ApiHelper();
  String getFirstLetter;
  String tokenBookmark;
  @override
  void initState() {
    super.initState();
    getFirstLetter = widget.judulBerita.substring(0, 2).toUpperCase();
    _loadPrefBookmark(widget.idBerita);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.green,
          child: Text(
            getFirstLetter,
            style: TextStyle(
                fontSize: ResponsiveUI.fontJudulHeadline, color: Colors.white),
          ),
        ),
        dense: true,
        title: Text(
          widget.judulBerita,
          style: ResponsiveUI.judulTextStyle,
        ),
        subtitle: Align(
          heightFactor: 2.5,
          alignment: Alignment.centerRight,
          child: Text(widget.tanggalBerita, style: ResponsiveUI.infoTextStyle),
        ),
        trailing: GestureDetector(
          onTap: () =>
              _removeBookmarkSQLite(widget.idBerita, widget.judulBerita),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Colors.deepOrange,
            child: Icon(
              Icons.bookmark,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }

  _loadPrefBookmark(int idBerita) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    tokenBookmark = pref.getString("$idBerita");
    setState(() {});
  }

  void _removePrefBookmark(String judulBerita, int idBerita) async {
    bool removePref = await api.removePref(judulBerita, idBerita);
    if (removePref) {
      print("Removed $idBerita from Bookmark");
    } else {
      print("Failed Remove $idBerita from Bookmark");
    }
  }

  void _removeBookmarkSQLite(int idBerita, String judulBerita) async {
    int removeBookmark = await DBProvider.db.removeBookmarkById(idBerita);
    if (removeBookmark != 0) {
      _showSnackBar(
          context, AppString.successRemoveBookmark, Colors.deepOrange);
      _removePrefBookmark(judulBerita, idBerita);
      _loadPrefBookmark(idBerita);
      setState(() {});
    } else {
      _showSnackBar(context, AppString.failedRemoveBookmark, Colors.orange);
      _loadPrefBookmark(idBerita);
    }
  }

  void _showSnackBar(BuildContext context, String message, Color colors) async {
    final snackBar = SnackBar(
        backgroundColor: colors,
        content: Text(message),
        duration: Duration(milliseconds: 500));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
