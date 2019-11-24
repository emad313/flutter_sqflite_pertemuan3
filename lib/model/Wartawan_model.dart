class WartawanBerita {
  final int idWartawan;
  final String namaWartawan;
  final String genderWartawan;
  final String ttlWartawan;
  final int umurWartawan;
  final String teleponWartawan;
  final String alamatWartawan;
  final String gambarWartawan;
  final String mottoWartawan;
  final String status;
  final int jumlahBerita;
  final String awalBekerja;
  WartawanBerita({
    this.idWartawan,
    this.namaWartawan,
    this.genderWartawan,
    this.ttlWartawan,
    this.umurWartawan,
    this.teleponWartawan,
    this.alamatWartawan,
    this.gambarWartawan,
    this.mottoWartawan,
    this.status,
    this.jumlahBerita,
    this.awalBekerja,
  });
  factory WartawanBerita.fromJson(Map<String, dynamic> json) {
    return WartawanBerita(
      idWartawan: int.tryParse(json['id_wartawan']),
      namaWartawan: json['nama_wartawan'],
      genderWartawan: json['gender_wartawan'],
      ttlWartawan: json['ttl_wartawan'],
      umurWartawan: int.tryParse(json['umur_wartawan']),
      teleponWartawan: json['telepon_wartawan'],
      alamatWartawan: json['alamat_wartawan'],
      gambarWartawan: json['gambar_wartawan'],
      mottoWartawan: json['motto_wartawan'],
      status: json['status'],
      jumlahBerita: int.tryParse(json['jumlah_berita']),
      awalBekerja: json['awal_bekerja'],
    );
  }
}
