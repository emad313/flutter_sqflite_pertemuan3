import 'package:flutter/material.dart';
import 'package:flutter_news/api/Api_news.dart';
import 'package:flutter_news/database/Database_helper.dart';
import 'package:flutter_news/pages/display_json/Fetch_bookmark.dart';
import 'package:flutter_news/pages/reusableWidget/DataNotFound.dart';
import 'package:flutter_news/pages/reusableWidget/LoadingIndicator.dart';

class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  String tokenBookmark;
  ApiHelper api = ApiHelper();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: DBProvider.db.getAllBookmark(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return DataNotFound();
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return LoadingIndicator();
              break;
            default:
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FetchBookmark(
                      idBerita: snapshot.data[index].idBerita,
                      judulBerita: snapshot.data[index].judulBerita,
                      tanggalBerita: snapshot.data[index].tanggalBerita,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error');
              } else {
                return Text('Null');
              }
          }

          /*
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FetchBookmark(
                      idBerita: snapshot.data[index].idBerita,
                      judulBerita: snapshot.data[index].judulBerita,
                      tanggalBerita: snapshot.data[index].tanggalBerita,
                    );
                  },
                );
               */
        },
      ),
    );
  }
}
