import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/api/Api_news.dart';
import 'package:flutter_news/app/App_string.dart';
import 'package:flutter_news/database/Database_helper.dart';
import 'package:flutter_news/model/Bookmark_model.dart';
import 'package:flutter_news/pages/reusableWidget/config_responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchNewsByKeyword extends StatefulWidget {
  final int idBerita;
  final String judulBerita;
  final String isiBerita;
  final String namaKategori;
  final String namaWartawan;
  final String gambarBerita;
  final String tanggalBerita;
  FetchNewsByKeyword(
      {this.idBerita,
      this.judulBerita,
      this.isiBerita,
      this.namaKategori,
      this.namaWartawan,
      this.gambarBerita,
      this.tanggalBerita});
  @override
  _FetchNewsByKeywordState createState() => _FetchNewsByKeywordState();
}

class _FetchNewsByKeywordState extends State<FetchNewsByKeyword> {
  ApiHelper api = ApiHelper();
  String tokenBookmark;
  @override
  void initState() {
    super.initState();
    _loadPrefBookmark(widget.idBerita);
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUI.config(context);
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: CachedNetworkImageProvider(
              "${Urls.BASE_API_IMAGE}/berita/${widget.gambarBerita}"),
        ),
        title: Text(
          widget.judulBerita,
          style: ResponsiveUI.judulTextStyle,
        ),
        subtitle: Align(
          heightFactor: 2.5,
          alignment: Alignment.centerRight,
          child: Text(widget.tanggalBerita, style: ResponsiveUI.infoTextStyle),
        ),
        trailing: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.deepOrange,
          child: tokenBookmark == null
              ? IconButton(
                  icon: Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                    size: 15,
                  ),
                  onPressed: () => _addBookmark(
                      widget.gambarBerita, widget.judulBerita, widget.idBerita),
                )
              : IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: Colors.white,
                    size: 15,
                  ),
                  onPressed: () => _removeBookmarkSQLite(
                      widget.idBerita, widget.judulBerita),
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

  void _savePrefBookmark(String judulBerita, int idBerita) async {
    bool savePref = await api.savedPref(judulBerita, idBerita);
    if (savePref) {
      _loadPrefBookmark(idBerita);
    } else {
      _loadPrefBookmark(idBerita);
    }
  }

  void _removePrefBookmark(String judulBerita, int idBerita) async {
    bool removePref = await api.removePref(judulBerita, idBerita);
    if (removePref) {
      _loadPrefBookmark(idBerita);
    } else {}
  }

  void _addBookmark(String imagUrl, String judulBerita, int idBerita) async {
    int bookmark = await DBProvider.db.addBookmark(
      Bookmark(
        idBerita: widget.idBerita,
        judulBerita: widget.judulBerita,
        isiBerita: widget.isiBerita,
        gambarBerita: widget.gambarBerita,
        namaKategori: widget.namaKategori,
        namaWartawan: widget.namaWartawan,
        tanggalBerita: widget.tanggalBerita,
      ),
    );
    if (bookmark != 0) {
      _savePrefBookmark(judulBerita, idBerita);
      _showSnackBar(context, AppString.successAddBookmark, Colors.green);
    } else {
      _showSnackBar(context, AppString.failedAddBookmark, Colors.red);
    }
  }

  void _removeBookmarkSQLite(int idBerita, String judulBerita) async {
    int removeBookmarkSQLite = await DBProvider.db.removeBookmarkById(idBerita);
    if (removeBookmarkSQLite != 0) {
      _removePrefBookmark(judulBerita, idBerita);
      _showSnackBar(context, AppString.successRemoveBookmark, Colors.orange);
    } else {
      _showSnackBar(context, AppString.failedRemoveBookmark, Colors.red);
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
