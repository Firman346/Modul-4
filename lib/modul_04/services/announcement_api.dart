import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/announcement.dart';

class AnnouncementApi {
  AnnouncementApi({
    http.Client? client,
    this.modeSimulasi = false,
  })  : _client = client ?? http.Client(),
        _milikSendiri = client == null;

  final http.Client _client;
  final bool _milikSendiri;
  final bool modeSimulasi;

  static const String baseUrl =
      'https://jsonplaceholder.typicode.com';

  static const Duration batasWaktu = Duration(seconds: 10);

  static const List<String> daftarKategori = [
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  Future<List<Announcement>> ambilPengumuman() async {
    if (modeSimulasi) {
      await Future<void>.delayed(const Duration(seconds: 1));

      final judulSimulasi = [
        'Jadwal Pengisian KRS Semester Ganjil',
        'Informasi Beasiswa Mahasiswa Poliwangi',
        'Seminar Teknologi dan Pengembangan Web',
        'Pengumuman Prestasi Mahasiswa TRPL',
        'Jadwal Ujian Tengah Semester',
        'Pendaftaran Kegiatan Organisasi Mahasiswa',
        'Workshop Flutter dan Mobile Development',
        'Informasi Pelaksanaan Praktikum TRPL',
        'Pembukaan Pendaftaran Program Magang',
        'Pengumuman Jadwal Presentasi Proyek',
      ];

      final isiSimulasi = [
        'Mahasiswa TRPL diharapkan memperhatikan jadwal pengisian KRS semester ganjil dan melakukan pengisian sesuai jadwal yang telah ditentukan.',
        'Informasi mengenai program beasiswa telah tersedia. Mahasiswa yang memenuhi persyaratan dapat mempersiapkan dokumen dan melakukan pendaftaran sesuai ketentuan.',
        'Program studi akan menyelenggarakan seminar teknologi yang membahas perkembangan web dan teknologi perangkat lunak. Mahasiswa dipersilakan mengikuti kegiatan tersebut.',
        'Selamat kepada mahasiswa TRPL yang berhasil meraih prestasi dalam kegiatan akademik maupun nonakademik. Semoga pencapaian ini dapat menjadi motivasi bagi mahasiswa lainnya.',
        'Jadwal pelaksanaan Ujian Tengah Semester telah ditetapkan. Mahasiswa diharapkan mempersiapkan diri dan memperhatikan jadwal masing-masing mata kuliah.',
        'Pendaftaran kegiatan organisasi mahasiswa telah dibuka. Mahasiswa yang berminat dapat mengikuti kegiatan sesuai dengan informasi dan jadwal yang telah ditentukan.',
        'Workshop Flutter dan Mobile Development akan dilaksanakan untuk meningkatkan kemampuan mahasiswa dalam membangun aplikasi mobile menggunakan Flutter.',
        'Mahasiswa TRPL dimohon memperhatikan jadwal praktikum dan mempersiapkan kebutuhan praktikum sebelum kegiatan dimulai.',
        'Program magang telah membuka pendaftaran bagi mahasiswa yang memenuhi persyaratan. Informasi lebih lanjut dapat diperoleh melalui bagian akademik.',
        'Jadwal presentasi proyek telah ditentukan. Setiap kelompok diharapkan mempersiapkan materi presentasi dan melakukan presentasi sesuai jadwal.',
      ];

      return List.generate(
        10,
        (index) {
          final nomor = index + 1;

          return Announcement(
            id: nomor,
            title: judulSimulasi[index],
            content: isiSimulasi[index],
            author: 'Bagian Akademik Poliwangi',
            category: daftarKategori[index % daftarKategori.length],
            date:
                '2026-09-${(index % 28 + 1).toString().padLeft(2, '0')}',
            readCount: nomor * 37,
          );
        },
      );
    }

    late http.Response response;

    try {
      response = await _client
          .get(
            Uri.parse('$baseUrl/posts?_limit=10'),
          )
          .timeout(batasWaktu);
    } on TimeoutException {
      throw Exception(
        'Koneksi ke server timeout. Periksa sambungan internet Anda.',
      );
    } on http.ClientException {
      throw Exception(
        'Gagal terhubung ke server. Periksa koneksi data atau Wi-Fi Anda.',
      );
    }

    if (response.statusCode != 200) {
      throw Exception(
        'Server merespons dengan status ${response.statusCode}.',
      );
    }

    dynamic data;

    try {
      data = jsonDecode(response.body);
    } on FormatException {
      throw Exception(
        'Respons server bukan JSON yang valid.',
      );
    }

    if (data is! List) {
      throw Exception(
        'Format data dari server tidak sesuai.',
      );
    }

    final judulPengumuman = [
      'Jadwal Pengisian KRS Semester Ganjil',
      'Informasi Beasiswa Mahasiswa Poliwangi',
      'Seminar Teknologi dan Pengembangan Web',
      'Pengumuman Prestasi Mahasiswa TRPL',
      'Jadwal Ujian Tengah Semester',
      'Pendaftaran Kegiatan Organisasi Mahasiswa',
      'Workshop Flutter dan Mobile Development',
      'Informasi Pelaksanaan Praktikum TRPL',
      'Pembukaan Pendaftaran Program Magang',
      'Pengumuman Jadwal Presentasi Proyek',
    ];

    final isiPengumuman = [
      'Mahasiswa TRPL diharapkan memperhatikan jadwal pengisian KRS semester ganjil dan melakukan pengisian sesuai jadwal yang telah ditentukan.',
      'Informasi mengenai program beasiswa telah tersedia. Mahasiswa yang memenuhi persyaratan dapat mempersiapkan dokumen dan melakukan pendaftaran sesuai ketentuan.',
      'Program studi akan menyelenggarakan seminar teknologi yang membahas perkembangan web dan teknologi perangkat lunak. Mahasiswa dipersilakan mengikuti kegiatan tersebut.',
      'Selamat kepada mahasiswa TRPL yang berhasil meraih prestasi dalam kegiatan akademik maupun nonakademik. Semoga pencapaian ini dapat menjadi motivasi bagi mahasiswa lainnya.',
      'Jadwal pelaksanaan Ujian Tengah Semester telah ditetapkan. Mahasiswa diharapkan mempersiapkan diri dan memperhatikan jadwal masing-masing mata kuliah.',
      'Pendaftaran kegiatan organisasi mahasiswa telah dibuka. Mahasiswa yang berminat dapat mengikuti kegiatan sesuai dengan informasi dan jadwal yang telah ditentukan.',
      'Workshop Flutter dan Mobile Development akan dilaksanakan untuk meningkatkan kemampuan mahasiswa dalam membangun aplikasi mobile menggunakan Flutter.',
      'Mahasiswa TRPL dimohon memperhatikan jadwal praktikum dan mempersiapkan kebutuhan praktikum sebelum kegiatan dimulai.',
      'Program magang telah membuka pendaftaran bagi mahasiswa yang memenuhi persyaratan. Informasi lebih lanjut dapat diperoleh melalui bagian akademik.',
      'Jadwal presentasi proyek telah ditentukan. Setiap kelompok diharapkan mempersiapkan materi presentasi dan melakukan presentasi sesuai jadwal.',
    ];

    return List<Announcement>.generate(
      data.length,
      (index) {
        final mentah = data[index] as Map<String, dynamic>;

        return Announcement.fromJson({
          'id': mentah['id'],
          'title': judulPengumuman[index % judulPengumuman.length],
          'content': isiPengumuman[index % isiPengumuman.length],
          'author': 'Bagian Akademik Poliwangi',
          'category':
              daftarKategori[index % daftarKategori.length],
          'date':
              '2026-09-${(index % 28 + 1).toString().padLeft(2, '0')}',
          'readCount': (index + 1) * 37,
        });
      },
    );
  }

  void tutup() {
    if (_milikSendiri) {
      _client.close();
    }
  }
}