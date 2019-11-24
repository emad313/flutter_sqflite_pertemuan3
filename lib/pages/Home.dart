import 'package:flutter/material.dart';
import 'package:flutter_news/model/Berita_model.dart';
import 'package:flutter_news/pages/display_json/Fetch_all_berita.dart';
import 'package:flutter_news/pages/display_json/Fetch_berita_headline.dart';
import 'package:flutter_news/api/Api_news.dart';
import 'package:flutter_news/pages/reusableWidget/DataNotFound.dart';
import 'package:flutter_news/pages/reusableWidget/LoadingIndicator.dart';
import 'package:flutter_news/pages/reusableWidget/config_responsive.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiHelper api = ApiHelper();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _getBeritaHeadline(),
        _getAllBerita(),
      ],
    );
  }

  Widget _getBeritaHeadline() {
    ResponsiveUI.config(context);
    return FutureBuilder<List<BeritaAll>>(
      future: api.getBeritaHeadline(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return LoadingIndicator();
            break;
          default:
            if (!snapshot.hasData) {
              return DataNotFound();
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return FetchBeritaHeadline(
                    idBerita: snapshot.data[index].idBerita,
                    judulBerita: snapshot.data[index].judulBerita,
                    isiBerita: snapshot.data[index].isiBerita,
                    namaKategori: snapshot.data[index].namaKategori,
                    namaWartawan: snapshot.data[index].namaWartawan,
                    tanggalBerita: snapshot.data[index].tanggalBerita,
                    gambarBerita: snapshot.data[index].gambarBerita,
                  );
                },
              );
            }
        }
      },
    );
  }

  Widget _getAllBerita() {
    return FutureBuilder<List<BeritaAll>>(
      future: api.getAllBerita(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return LoadingIndicator();
            break;
          default:
            if (!snapshot.hasData) {
              return DataNotFound();
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return FetchAllBerita(
                    idBerita: snapshot.data[index].idBerita ?? "",
                    judulBerita: snapshot.data[index].judulBerita ?? "",
                    isiBerita: snapshot.data[index].isiBerita ?? "",
                    namaKategori: snapshot.data[index].namaKategori ?? "",
                    namaWartawan: snapshot.data[index].namaWartawan ?? "",
                    tanggalBerita: snapshot.data[index].tanggalBerita ?? "",
                    gambarBerita: snapshot.data[index].gambarBerita ?? "",
                  );
                },
              );
            }
        }
      },
    );
  }
}
