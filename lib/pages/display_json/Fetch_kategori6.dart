import 'package:flutter/material.dart';
import 'package:flutter_news/api/Api_news.dart';
import 'package:flutter_news/pages/detail/Kategori_detail.dart';
import 'package:flutter_news/pages/reusableWidget/config_responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FetchKategori6 extends StatefulWidget {
  final int idKategori;
  final String namaKategori;
  final String gambarKategori;
  final int jumlahBerita;
  final String ketKategori;
  FetchKategori6({
    this.idKategori,
    this.namaKategori,
    this.gambarKategori,
    this.jumlahBerita,
    this.ketKategori,
  });
  @override
  _FetchKategori6State createState() => _FetchKategori6State();
}

class _FetchKategori6State extends State<FetchKategori6> {
  @override
  Widget build(BuildContext context) {
    ResponsiveUI.config(context);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KategoriDetail(
            idKategori: widget.idKategori,
            namaKategori: widget.namaKategori,
            gambarKategori: widget.gambarKategori,
            jumlahBerita: widget.jumlahBerita,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(4),
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    "${Urls.BASE_API_IMAGE}/category/${widget.gambarKategori}"),
              ),
            ),
          ),
          footer: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.black.withOpacity(.5),
            child: Text(
              widget.namaKategori,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
