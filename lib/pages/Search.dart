import 'package:flutter/material.dart';
import 'package:flutter_news/api/Api_news.dart';
import 'package:flutter_news/model/Berita_model.dart';
import 'package:flutter_news/pages/display_json/FetchNewsByKeyword.dart';
import 'package:flutter_news/pages/display_json/Fetch_kategori6.dart';
import 'package:flutter_news/pages/reusableWidget/DataNotFound.dart';
import 'package:flutter_news/pages/reusableWidget/HeaderSearchBottom.dart';
import 'package:flutter_news/pages/reusableWidget/LoadingIndicator.dart';
import 'package:flutter_news/pages/reusableWidget/No_connection.dart';
import 'package:flutter_news/pages/reusableWidget/TextFormFieldSearch.dart';
import 'package:flutter_news/pages/reusableWidget/config_responsive.dart';

import 'display_json/Fetch_wartawan6.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ApiHelper api = ApiHelper();
  TextEditingController _txtSearch = TextEditingController();
  bool _isSearch = true;
  String _searchText = "";
  _SearchState() {
    _txtSearch.addListener(() {
      if (_txtSearch.text.length < 3) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _txtSearch.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUI.config(context);
    return ListView(
      children: <Widget>[
        _searchBox(),
        _isSearch ? _showMenuSearch() : _showNewsByKeyword(),
      ],
    );
  }

  Widget _searchBox() {
    return TextFormFieldSearch(
      suffixIcon: Icon(Icons.search),
      txtController: _txtSearch,
    );
  }

  Widget _showMenuSearch() {
    return Column(
      children: <Widget>[
        _showKategori(),
        _showWartawan(),
      ],
    );
  }

  Widget _showNewsByKeyword() {
    return Container(
      child: FutureBuilder<List<BeritaAll>>(
        future: api.getBeritaByKeyword(_searchText),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return NoConnection();
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
                  itemBuilder: (context, index) {
                    return FetchNewsByKeyword(
                      idBerita: snapshot.data[index].idBerita,
                      judulBerita: snapshot.data[index].judulBerita,
                      isiBerita: snapshot.data[index].isiBerita,
                      namaKategori: snapshot.data[index].namaKategori,
                      namaWartawan: snapshot.data[index].namaWartawan,
                      gambarBerita: snapshot.data[index].gambarBerita,
                      tanggalBerita: snapshot.data[index].tanggalBerita,
                    );
                  },
                );
              } else {
                return DataNotFound();
              }
          }
        },
      ),
    );
  }

  Widget _showKategori() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          HeaderSearchBottom(
            namaKiri: "Kategori",
            namaKanan: "Detail",
          ),
          Container(
            child: FutureBuilder(
              future: api.getKategori6(),
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
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return FetchKategori6(
                            idKategori: snapshot.data[index].idKategori ?? "",
                            namaKategori:
                                snapshot.data[index].namaKategori ?? "",
                            gambarKategori:
                                snapshot.data[index].gambarKategori ?? "",
                            jumlahBerita:
                                snapshot.data[index].jumlahBerita ?? "",
                            ketKategori: snapshot.data[index].ketKategori ?? "",
                          );
                        },
                      );
                    }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _showWartawan() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderSearchBottom(
            namaKiri: "Wartawan",
            namaKanan: "Detail",
          ),
          Container(
            child: FutureBuilder(
              future: api.getWartawan6(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return FetchWartawan6(
                        idWartawan: snapshot.data[index].idWartawan ?? "",
                        namaWartawan: snapshot.data[index].namaWartawan ?? "",
                        gambarWartawan:
                            snapshot.data[index].gambarWartawan ?? "",
                        jumlahBerita: snapshot.data[index].jumlahBerita ?? "",
                      );
                    },
                  );
                } else {
                  return DataNotFound();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
