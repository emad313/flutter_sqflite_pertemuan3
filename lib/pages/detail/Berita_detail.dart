import 'package:flutter/material.dart';
import 'package:flutter_news/api/Api_news.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_news/pages/reusableWidget/config_responsive.dart';

class BeritaDetail extends StatefulWidget {
  final int idBerita;
  final String judulBerita;
  final String gambarBerita;
  final String isiBerita;
  final String namaKategori;
  final String namaWartawan;
  final String tanggalBerita;
  BeritaDetail({
    this.idBerita,
    this.judulBerita,
    this.gambarBerita,
    this.isiBerita,
    this.namaKategori,
    this.namaWartawan,
    this.tanggalBerita,
  });

  @override
  _BeritaDetailState createState() => _BeritaDetailState();
}

class _BeritaDetailState extends State<BeritaDetail> {
  @override
  Widget build(BuildContext context) {
    ResponsiveUI.config(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () => "",
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          _judulBerita(),
          _gambarBerita(),
          _infoBerita(),
          _isiBerita(),
          _beritaTerkait(),
        ],
      ),
    );
  }

  Widget _judulBerita() {
    return Container(
      padding: EdgeInsets.all(16),
      child:
          Text(widget.judulBerita, style: ResponsiveUI.judulHeadlineTextStyle),
    );
  }

  Widget _gambarBerita() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              "${Urls.BASE_API_IMAGE}/berita/${widget.gambarBerita}"),
        ),
      ),
    );
  }

  Widget _infoBerita() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text('Oleh : ${widget.namaWartawan}',
                        style: ResponsiveUI.infoTextStyle),
                  ),
                  Container(
                    child: Text(widget.namaKategori,
                        style: ResponsiveUI.infoTextStyle),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child:
                Text(widget.tanggalBerita, style: ResponsiveUI.infoTextStyle),
          )
        ],
      ),
    );
  }

  Widget _isiBerita() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
      child: Html(
        data: widget.isiBerita,
      ),
    );
  }

  Widget _beritaTerkait() {
    ThemeData localTheme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              'Berita Terkait',
              style: localTheme.textTheme.display1,
            ),
          ),
          // Container(
          //   child: ListView.builder(
          //       shrinkWrap: true,
          //       physics: NeverScrollableScrollPhysics(),
          //       itemCount: beritas.length,
          //       itemBuilder: newsBuilderHome),
          // ),
        ],
      ),
    );
  }
}
