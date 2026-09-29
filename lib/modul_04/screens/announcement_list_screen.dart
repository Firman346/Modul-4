import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../services/announcement_api.dart';
import '../widgets/announcement_card.dart';
import 'announcement_detail_screen.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({
    super.key,
    this.api,
  });

  final AnnouncementApi? api;

  @override
  State<AnnouncementListScreen> createState() =>
      _AnnouncementListScreenState();
}

class _AnnouncementListScreenState
    extends State<AnnouncementListScreen> {
  late final AnnouncementApi _api;
  late Future<List<Announcement>> _futurePengumuman;

  String _kategoriTerpilih = 'Semua';

  static const List<String> _daftarKategori = [
    'Semua',
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  @override
  void initState() {
    super.initState();

    _api = widget.api ?? AnnouncementApi();
    _futurePengumuman = _api.ambilPengumuman();
  }

  @override
  void dispose() {
    _api.tutup();
    super.dispose();
  }

  Future<void> _muatUlang() async {
    setState(() {
      _futurePengumuman = _api.ambilPengumuman();
    });

    try {
      await _futurePengumuman;
    } catch (_) {
      // Error akan ditampilkan oleh FutureBuilder.
    }
  }

  void _pilihKategori(String kategori) {
    setState(() {
      _kategoriTerpilih = kategori;
    });
  }

  void _bukaDetail(Announcement announcement) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AnnouncementDetailScreen(
          announcement: announcement,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Pengumuman TRPL'),
        actions: [
          IconButton(
            tooltip: 'Muat ulang',
            onPressed: _muatUlang,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterKategori(),
          const Divider(height: 1),
          Expanded(
            child: FutureBuilder<List<Announcement>>(
              future: _futurePengumuman,
              builder: (context, snapshot) {
                // 1. LOADING
                if (snapshot.connectionState != ConnectionState.done) {
                  return _buildMemuat();
                }

                // 2. ERROR
                if (snapshot.hasError) {
                  return _buildGagal(snapshot.error!);
                }

                final data = snapshot.data ?? <Announcement>[];

                // Filter dilakukan di sisi aplikasi.
                // Tidak membuat request baru ke server.
                final tampil = _kategoriTerpilih == 'Semua'
                    ? data
                    : data
                        .where(
                          (announcement) =>
                              announcement.category ==
                              _kategoriTerpilih,
                        )
                        .toList();

                // 3. EMPTY
                if (tampil.isEmpty) {
                  return _buildKosong();
                }

                // 4. SUCCESS
                return _buildDaftar(tampil);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterKategori() {
    return SizedBox(
      height: 58,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: _daftarKategori.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final kategori = _daftarKategori[index];
          final terpilih = kategori == _kategoriTerpilih;

          return ChoiceChip(
            label: Text(kategori),
            selected: terpilih,
            onSelected: (_) => _pilihKategori(kategori),
          );
        },
      ),
    );
  }

  Widget _buildMemuat() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Sedang memuat pengumuman...'),
        ],
      ),
    );
  }

  Widget _buildGagal(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_outlined,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Gagal memuat pengumuman',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _muatUlang,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKosong() {
    final kategori = _kategoriTerpilih == 'Semua'
        ? 'pengumuman'
        : 'pengumuman kategori $_kategoriTerpilih';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inbox_outlined,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada $kategori.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaftar(List<Announcement> pengumuman) {
    return RefreshIndicator(
      onRefresh: _muatUlang,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: pengumuman.length,
        itemBuilder: (context, index) {
          final announcement = pengumuman[index];

          return AnnouncementCard(
            announcement: announcement,
            onTap: () => _bukaDetail(announcement),
          );
        },
      ),
    );
  }
}