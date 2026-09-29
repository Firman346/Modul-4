class KrsCourse {
  final String code;
  final String name;
  final String lecturer;
  final int sks;
  final String description;

  const KrsCourse({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.sks,
    this.description = '',
  });

  static List<KrsCourse> getInitialCourses() {
    return const [
      KrsCourse(
        code: 'TRPL504',
        name: 'Statistika',
        lecturer: 'Siska Aprilio S.Pd, M.Si',
        sks: 3,
        description:
            'Mempelajari konsep dasar statistika, pengolahan data, penyajian data, serta analisis data untuk mendukung pengambilan keputusan.',
      ),
      KrsCourse(
        code: 'TRPL505',
        name: 'Interoperabilitas',
        lecturer: 'Furiansyah Dipraja, S.T, M.Kom',
        sks: 3,
        description:
            'Mempelajari konsep interoperabilitas dan integrasi antar sistem agar dapat saling bertukar data dan informasi.',
      ),
      KrsCourse(
        code: 'TRPL501',
        name: 'Pemrograman Perangkat Bergerak',
        lecturer: 'Sepyan Purnama Kristanto, S.Kom, M.Kom.',
        sks: 3,
        description:
            'Mempelajari pengembangan aplikasi perangkat bergerak menggunakan Flutter.',
      ),
      KrsCourse(
        code: 'TRPL502',
        name: 'Rekayasa Kebutuhan Perangkat Lunak',
        lecturer: 'Eka Mistiko Rini, S.Kom, M.Kom',
        sks: 3,
        description:
            'Mempelajari proses identifikasi, analisis, dan dokumentasi kebutuhan perangkat lunak.',
      ),
      KrsCourse(
        code: 'TRPL503',
        name: 'Basis Data',
        lecturer: 'Dianni Yusuf, S.Kom, M.Kom',
        sks: 3,
        description:
            'Mempelajari konsep basis data, perancangan database, dan pengelolaan data.',
      ),
    ];
  }
}