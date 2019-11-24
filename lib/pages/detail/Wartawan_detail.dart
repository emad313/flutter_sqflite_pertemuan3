import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/api/Api_news.dart';
import 'package:flutter_news/pages/display_json/FetchNewsByWartawan.dart';
import 'package:flutter_news/pages/reusableWidget/DataNotFound.dart';
import 'package:flutter_news/pages/reusableWidget/LoadingIndicator.dart';
import 'package:flutter_news/pages/reusableWidget/config_responsive.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class WartawanDetail extends StatefulWidget {
  final int idWartawan;
  final String gambarWartawan;
  final String namaWartawan;
  final int jumlahBerita;
  WartawanDetail({
    this.idWartawan,
    this.gambarWartawan,
    this.namaWartawan,
    this.jumlahBerita,
  });
  @override
  _WartawanDetailState createState() => _WartawanDetailState();
}

class _WartawanDetailState extends State<WartawanDetail> {
  ApiHelper api = ApiHelper();

  double message2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _sliverAppBar(),
            _sliverList(),
          ],
        ),
      ),
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      floating: false,
      pinned: true,
      expandedHeight: ScreenUtil.getInstance().setHeight(250),
      leading: Container(
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraint) {
          message2 = constraint.maxHeight;
          return FlexibleSpaceBar(
            title: Container(
              width: ScreenUtil.getInstance().setWidth(250),
              child: message2 <= 56
                  ? Text(
                      widget.namaWartawan,
                      style: ResponsiveUI.textNamaWartawanStylWhite,
                    )
                  : Text(
                      widget.namaWartawan,
                      style: ResponsiveUI.textNamaWartawanStylWhite,
                    ),
            ),
            background: Container(
              height: ScreenUtil.getInstance().height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        "${Urls.BASE_API_IMAGE}/wartawan/${widget.gambarWartawan}"),
                    fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.25),
                ),
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        Container(
          child: IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () => "",
          ),
        ),
      ],
    );
  }

  SliverList _sliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            padding: EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  style: ResponsiveUI.infoTextStyle,
                  children: [
                    TextSpan(text: "Ditemukan "),
                    TextSpan(
                      text: "${widget.jumlahBerita} ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    TextSpan(text: "Berita")
                  ],
                ),
              ),
            ),
          ),
          _fetchNewsByWartawan(),
        ],
      ),
    );
  }

  Widget _fetchNewsByWartawan() {
    return Container(
      child: FutureBuilder(
        future: api.getBeritaByWartawan(widget.idWartawan),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                    return FetchNewsByWartawan(
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
      ),
    );
  }
}
