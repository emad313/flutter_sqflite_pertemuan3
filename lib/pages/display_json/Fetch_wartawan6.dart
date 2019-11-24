import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/api/Api_news.dart';
import 'package:flutter_news/pages/detail/Wartawan_detail.dart';

class FetchWartawan6 extends StatefulWidget {
  final int idWartawan;
  final String namaWartawan;
  final String gambarWartawan;
  final int jumlahBerita;
  FetchWartawan6({
    this.idWartawan,
    this.namaWartawan,
    this.gambarWartawan,
    this.jumlahBerita,
  });
  @override
  _FetchWartawan6State createState() => _FetchWartawan6State();
}

class _FetchWartawan6State extends State<FetchWartawan6> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WartawanDetail(
            idWartawan: widget.idWartawan,
            namaWartawan: widget.namaWartawan,
            gambarWartawan: widget.gambarWartawan,
            jumlahBerita: widget.jumlahBerita,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        child: GridTile(
          child: Container(
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 50,
              backgroundImage: CachedNetworkImageProvider(
                  "${Urls.BASE_API_IMAGE}/wartawan/${widget.gambarWartawan}"),
            ),
          ),
        ),
      ),
    );
  }
}
