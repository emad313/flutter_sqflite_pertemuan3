import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_news/model/Kategori_model.dart';
import 'package:flutter_news/model/Wartawan_model.dart';
import 'package:flutter_news/model/Berita_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Urls {
  static const BASE_API_URL =
      "http://192.168.43.159/flutter-news/flutter_api/news";
  static const BASE_API_IMAGE = "http://192.168.43.159/flutter-news/images";

  //IP Adress Perpustakaan Nasional
  // static const BASE_API_URL =
  //     "http://172.10.58.105/flutter-news/flutter_api/news";
  // static const BASE_API_IMAGE = "http://172.10.58.105/flutter-news/images";
}

class CrudComponent {
  static final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
}

class ApiHelper {
  var baseURL = Urls.BASE_API_URL;
  var baseURLimage = Urls.BASE_API_IMAGE;

  Future<List<BeritaAll>> getAllBerita() async {
    try {
      var apiRespon = await http.get("$baseURL");
      var apiResponJson = json.decode(apiRespon.body);
      return (apiResponJson["data"] as List)
          .map((json) => BeritaAll.fromJson(json))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<BeritaAll>> getBeritaHeadline() async {
    try {
      var apiRespon = await http.get("$baseURL/newsheadline/");
      final apiResponJson = json.decode(apiRespon.body);
      return (apiResponJson["data"] as List)
          .map((json) => BeritaAll.fromJson(json))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<BeritaAll>> getBeritaByKeyword(String keyword) async {
    try {
      var apiRespon = await http.get('$baseURL/searching?keyword=$keyword');
      final apiResponJson = json.decode(apiRespon.body);
      return (apiResponJson['data'] as List)
          .map((json) => BeritaAll.fromJson(json))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<BeritaAll>> getBeritaByWartawan(int idwartawan) async {
    try {
      var apiRespon =
          await http.get("$baseURL/newsByWartawan?id_wartawan=$idwartawan");
      final apiResponJson = json.decode(apiRespon.body);
      return (apiResponJson["data"] as List)
          .map((json) => BeritaAll.fromJson(json))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<BeritaAll>> getBeritaByKategori(int idkategori) async {
    try {
      var apiRespon =
          await http.get('$baseURL/newsByKategory?id_kategori=$idkategori');
      final apiResponjson = json.decode(apiRespon.body);
      return (apiResponjson["data"] as List)
          .map((json) => BeritaAll.fromJson(json))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<KategoriBerita>> getAllKategori() async {
    try {
      var apiRespon = await http.get("$baseURL/kategori/");
      final apiResponJson = json.decode(apiRespon.body);
      return (apiResponJson["data"] as List)
          .map((json) => KategoriBerita.fromJson(json))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<KategoriBerita>> getKategori6() async {
    try {
      var apiRespon = await http.get("$baseURL/kategori6/");
      final apiResponJson = json.decode(apiRespon.body);
      return (apiResponJson["data"] as List)
          .map((json) => KategoriBerita.fromJson(json))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<WartawanBerita>> getWartawan6() async {
    try {
      var apiRespon = await http.get("$baseURL/wartawan6/");
      final apiResponJson = json.decode(apiRespon.body);
      return (apiResponJson["data"] as List)
          .map((json) => WartawanBerita.fromJson(json))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future savedPref(String judulBerita, int idBerita) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("$idBerita", judulBerita);
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future removePref(String judulBerita, int idBerita) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove("$idBerita");
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
