import 'package:flutter/material.dart';
import '../Model/ModelBerita.dart'; // Pastikan path ini sesuai dengan lokasi ModelBerita Anda

class DetailBeritaPage extends StatelessWidget {
  final Datum? berita; // Menggunakan tipe Datum dari ModelBerita

  const DetailBeritaPage(this.berita, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(berita?.judul ?? "Detail Berita"),
      ),
      body: SingleChildScrollView( // Gunakan SingleChildScrollView untuk menghindari overflow pada layar kecil atau konten yang panjang
        child: Column(
          children: [
            if (berita?.gambar != null) // Tampilkan gambar jika URL tersedia
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'http://192.168.43.124/edukasi_server/gambar_berita/${berita!.gambar}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                berita?.judul ?? "",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                berita?.berita ?? "",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
