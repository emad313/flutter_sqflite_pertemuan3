import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter_news/api/Api_news.dart';
import 'package:flutter_news/database/Database_helper.dart';
import 'package:flutter_news/model/Bookmark_model.dart';
import 'package:flutter_news/pages/detail/Berita_detail.dart';
import 'package:flutter_news/pages/reusableWidget/config_responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_news/app/App_string.dart';

class FetchBeritaHeadline extends StatefulWidget {
  final int idBerita;
  final String judulBerita;
  final String isiBerita;
  final String namaKategori;
  final String namaWartawan;
  final String tanggalBerita;
  final String gambarBerita;
  FetchBeritaHeadline({
    this.idBerita,
    this.judulBerita,
    this.isiBerita,
    this.namaKategori,
    this.namaWartawan,
    this.tanggalBerita,
    this.gambarBerita,
  });
  @override
  _FetchBeritaHeadlineState createState() => _FetchBeritaHeadlineState();
}

class _FetchBeritaHeadlineState extends State<FetchBeritaHeadline> {
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
      padding: EdgeInsets.all(8),
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
        child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text(tokenBookmark == null ? "Null" : tokenBookmark),

              Container(
                height: ScreenUtil.getInstance().setHeight(300),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        "${Urls.BASE_API_IMAGE}/berita/${widget.gambarBerita}"),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  widget.judulBerita,
                  style: ResponsiveUI.judulHeadlineTextStyle,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.namaKategori,
                            style: ResponsiveUI.infoTextStyle,
                          ),
                          Text(
                            widget.namaWartawan,
                            style: ResponsiveUI.infoTextStyle,
                          ),
                          Text(
                            widget.tanggalBerita,
                            style: ResponsiveUI.infoTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Wrap(
                        children: <Widget>[
                          tokenBookmark == null
                              ? IconButton(
                                  icon: Icon(Icons.bookmark_border),
                                  onPressed: () => _addBookmark(
                                    widget.gambarBerita,
                                    widget.judulBerita,
                                    widget.idBerita,
                                  ),
                                )
                              : IconButton(
                                  icon: Icon(Icons.bookmark),
                                  onPressed: () => _removeBookmarkSQLite(
                                    widget.idBerita,
                                    widget.judulBerita,
                                  ),
                                ),
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () =>
                                Share.share("${widget.judulBerita}\n"
                                    "Ini Dishare dari App Flutter \n"
                                    "Oleh ${widget.namaWartawan}\n"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _savePrefBookmark(String judulBerita, int idBerita) async {
    bool savePref = await api.savedPref(judulBerita, idBerita);
    if (savePref) {
      _loadPrefBookmark(idBerita);
    } else {
      _loadPrefBookmark(idBerita);
    }
  }

  _loadPrefBookmark(int idBerita) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    tokenBookmark = pref.getString("$idBerita");
    setState(() {});
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
      print(AppString.successAddBookmark);
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
