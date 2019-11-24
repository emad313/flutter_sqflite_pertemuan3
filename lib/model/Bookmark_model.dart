class Bookmark {
  final int idBerita;
  final String judulBerita;
  final String isiBerita;
  final String gambarBerita;
  final String namaKategori;
  final String namaWartawan;
  final String tanggalBerita;
  Bookmark({
    this.idBerita,
    this.judulBerita,
    this.isiBerita,
    this.gambarBerita,
    this.namaKategori,
    this.namaWartawan,
    this.tanggalBerita,
  });
  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      idBerita: int.tryParse(json['id_berita']),
      judulBerita: json['judul_berita'].toString(),
      isiBerita: json['isi_berita'].toString(),
      gambarBerita: json['gambar_berita'].toString(),
      namaKategori: json['nama_kategori'].toString(),
      namaWartawan: json['nama_wartawan'].toString(),
      tanggalBerita: json['tanggal_berita'].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['id_berita'] = idBerita;
    map['judul_berita'] = judulBerita;
    map['isi_berita'] = isiBerita;
    map['gambar_berita'] = gambarBerita;
    map['nama_kategori'] = namaKategori;
    map['nama_wartawan'] = namaWartawan;
    map['tanggal_berita'] = tanggalBerita;
    return map;
  }
}
