class KategoriBerita {
  final int idKategori;
  final String namaKategori;
  final String gambarKategori;
  final int jumlahBerita;
  final String ketKategori;
  KategoriBerita({
    this.idKategori,
    this.namaKategori,
    this.gambarKategori,
    this.jumlahBerita,
    this.ketKategori,
  });
  factory KategoriBerita.fromJson(Map<String, dynamic> json) {
    return KategoriBerita(
      idKategori: int.tryParse(json['id_kategori']),
      namaKategori: json['nama_kategori'],
      gambarKategori: json['gambar_kategori'],
      jumlahBerita: int.tryParse(json['jumlah_berita']),
      ketKategori: json['ket_kategori'],
    );
  }
}
