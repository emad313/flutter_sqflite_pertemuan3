class BeritaAll {
  final int idBerita;
  final int idWartawan;
  final int idKategori;
  final String judulBerita;
  final String isiBerita;
  final String gambarBerita;
  final String tanggalBerita;
  final String statusBerita;
  final String namaKategori;
  final String namaWartawan;

  BeritaAll({
    this.idBerita,
    this.idWartawan,
    this.idKategori,
    this.judulBerita,
    this.isiBerita,
    this.gambarBerita,
    this.tanggalBerita,
    this.statusBerita,
    this.namaKategori,
    this.namaWartawan,
  });
  factory BeritaAll.fromJson(Map<String, dynamic> json) {
    return BeritaAll(
        idBerita: int.tryParse(json['id_berita']),
        idWartawan: int.tryParse(json['id_wartawan']),
        idKategori: int.tryParse(json['id_kategori']),
        judulBerita: json['judul_berita'],
        isiBerita: json['isi_berita'],
        gambarBerita: json['gambar_berita'],
        tanggalBerita: json['tanggal_berita'],
        statusBerita: json['status_berita'],
        namaKategori: json['nama_kategori'],
        namaWartawan: json['nama_wartawan']);
  }
}
