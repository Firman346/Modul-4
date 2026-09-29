import 'package:flutter/material.dart';

import '../models/krs_course.dart';
import 'add_krs_screen.dart';
import 'course_detail_screen.dart';
import '../widgets/krs_course_tile.dart';

class KrsListScreen extends StatefulWidget {
  const KrsListScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  @override
  State<KrsListScreen> createState() => _KrsListScreenState();
}

class _KrsListScreenState extends State<KrsListScreen> {
  late List<KrsCourse> _courses;

  static const int batasSksSemester = 24;
  static const int ambangPeringatanSks = 21;

  @override
  void initState() {
    super.initState();

    _courses = List<KrsCourse>.of(
      KrsCourse.getInitialCourses(),
    );
  }

  int get _totalSks {
    return _courses.fold<int>(
      0,
      (total, course) => total + course.sks,
    );
  }

  Future<void> _bukaDetail(KrsCourse course) async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CourseDetailScreen(course: course);
        },
      ),
    );
  }

  Future<void> _tambahKrs() async {
    final KrsCourse? courseBaru =
        await Navigator.push<KrsCourse>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const AddKrsScreen();
        },
      ),
    );

    if (!mounted || courseBaru == null) {
      return;
    }

    final bool kodeSudahAda = _courses.any(
      (course) =>
          course.code.toLowerCase() ==
          courseBaru.code.toLowerCase(),
    );

    if (kodeSudahAda) {
      _tampilkanPesan(
        'Kode ${courseBaru.code} sudah ada di KRS.',
      );
      return;
    }

    if (_totalSks + courseBaru.sks > batasSksSemester) {
      _tampilkanPesan(
        'Penambahan ditolak. Maksimal '
        '$batasSksSemester SKS per semester.',
      );
      return;
    }

    setState(() {
      _courses.add(courseBaru);
    });

    _tampilkanPesan(
      '${courseBaru.code} berhasil ditambahkan ke KRS.',
    );
  }

  Future<void> _hapusKrs(KrsCourse course) async {
    final bool? dikonfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Mata Kuliah?'),
          content: Text(
            'Yakin ingin menghapus ${course.name} '
            '(${course.code}) dari KRS?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (!mounted || dikonfirmasi != true) {
      return;
    }

    setState(() {
      _courses.remove(course);
    });

    _tampilkanPesan(
      '${course.code} berhasil dihapus dari KRS.',
    );
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool mendekatiBatas =
        _totalSks >= ambangPeringatanSks;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KRS Mahasiswa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            tooltip: widget.isDarkMode
                ? 'Mode terang'
                : 'Mode gelap',
            icon: Icon(
              widget.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(mendekatiBatas),
          Expanded(
            child: _courses.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _courses.length,
                    itemBuilder: (context, index) {
                      final KrsCourse course =
                          _courses[index];

                      return KrsCourseTile(
                        course: course,
                        onTap: () {
                          _bukaDetail(course);
                        },
                        onDelete: () {
                          _hapusKrs(course);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahKrs,
        icon: const Icon(Icons.add),
        label: const Text('Tambah KRS'),
      ),
    );
  }

  Widget _buildHeader(bool mendekatiBatas) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.school_rounded,
              color: Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total SKS Semester Ini',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$_totalSks / $batasSksSemester SKS',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium,
                ),
              ],
            ),
          ),
          if (mendekatiBatas)
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_outlined,
            size: 64,
          ),
          SizedBox(height: 12),
          Text(
            'Belum ada mata kuliah.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Tekan tombol Tambah KRS untuk menambahkan.',
          ),
        ],
      ),
    );
  }
}