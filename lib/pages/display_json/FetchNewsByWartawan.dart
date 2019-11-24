import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/api/Api_news.dart';
import 'package:flutter_news/app/App_string.dart';
import 'package:flutter_news/database/Database_helper.dart';
import 'package:flutter_news/model/Bookmark_model.dart';
import 'package:flutter_news/pages/detail/Berita_detail.dart';
import 'package:flutter_news/pages/reusableWidget/config_responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchNewsByWartawan extends StatefulWidget {
  final int idBerita;
  final String judulBerita;
  final String isiBerita;
  final String namaKategori;
  final String namaWartawan;
  final String tanggalBerita;
  final String gambarBerita;
  FetchNewsByWartawan({
    this.idBerita,
    this.judulBerita,
    this.isiBerita,
    this.namaKategori,
    this.namaWartawan,
    this.tanggalBerita,
    this.gambarBerita,
  });
  @override
  _FetchNewsByWartawanState createState() => _FetchNewsByWartawanState();
}

class _FetchNewsByWartawanState extends State<FetchNewsByWartawan> {
  ApiHelper api = ApiHelper();
  String tokenBookmark;
  @override
  void initState() {
    _loadPrefBookmark(widget.idBerita);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUI.config(context);
    return Container(
      height: ScreenUtil.getInstance().setHeight(80),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BeritaDetail(
              idBerita: widget.idBerita,
              judulBerita: widget.judulBerita,
              isiBerita: widget.isiBerita,
              tanggalBerita: widget.tanggalBerita,
              namaKategori: widget.namaKategori,
              namaWartawan: widget.namaWartawan,
              gambarBerita: widget.gambarBerita,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text(
                          widget.judulBerita,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: ResponsiveUI.judulTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                widget.namaKategori,
                                style: ResponsiveUI.infoTextStyle,
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 20,
                            alignment: WrapAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () =>
                                    Share.share("${widget.judulBerita} \n"
                                        "Ini Dishare dari App Flutter  \n"
                                        "Oleh ${widget.namaWartawan}   \n"),
                                child: Icon(
                                  Icons.share,
                                  size: ResponsiveUI.fontIcon,
                                ),
                              ),
                              tokenBookmark == null
                                  ? GestureDetector(
                                      onTap: () => _addBookmark(
                                        widget.gambarBerita,
                                        widget.judulBerita,
                                        widget.idBerita,
                                      ),
                                      child: Icon(
                                        Icons.bookmark_border,
                                        size: ResponsiveUI.fontIcon,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () => _removeBookmarkSQLite(
                                        widget.idBerita,
                                        widget.judulBerita,
                                      ),
                                      child: Icon(
                                        Icons.bookmark,
                                        size: ResponsiveUI.fontIcon,
                                      ),
                                    ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.green,
              width: ScreenUtil.getInstance().setWidth(100),
              height: ScreenUtil.getInstance().height,
              child: CachedNetworkImage(
                imageUrl:
                    "${Urls.BASE_API_IMAGE}/berita/${widget.gambarBerita}",
                fit: BoxFit.fill,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ],
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
      print("${AppString.successAddBookmark} : $idBerita");
      _loadPrefBookmark(idBerita);
    } else {
      print("${AppString.failedAddBookmark} : $idBerita");
    }
  }

  void _removePrefBookmark(String judulBerita, int idBerita) async {
    bool removePref = await api.removePref(judulBerita, idBerita);
    if (removePref) {
      print("${AppString.successRemoveBookmark} : $idBerita");
      _loadPrefBookmark(idBerita);
    } else {
      print("${AppString.successRemoveBookmark} : $idBerita");
    }
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
