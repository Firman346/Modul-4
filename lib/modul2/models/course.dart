// Model data untuk mata kuliah
class Course {
  final String code;
  final String name;
  final String lecturer;
  final int sks;
  final double progress;
  final String room;

  const Course({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.sks,
    required this.progress,
    this.room = 'Lab Pemrogaman 1',
  });

  // Data dummy untuk bahan praktikum & testing
  static List<Course> getSampleCourses() {
    return const [
      Course(
        code: 'TRPL501',
        name: 'Pemrograman Perangkat Bergerak',
        lecturer: 'Sepyan Purnama Kristanto, S.Kom, M.Kom',
        sks: 2,
        progress: 0.25,
        room: 'Lab Pemrograman 1',
      ),
      Course(
        code: 'TRPL502',
        name: 'Interoperabilitas',
        lecturer: 'Furiansyah Dipraja, S.T, M.Kom',
        sks: 2,
        progress: 0.40,
        room: 'Lab Multi Media',
      ),
      Course(
        code: 'TRPL503',
        name: 'Basis Data Lanjut',
        lecturer: 'Dianni Yusuf, S.Kom, M.Kom',
        sks: 2,
        progress: 0.60,
        room: 'Lab TUK 1',
      ),
      Course(
        code: 'TRPL504',
        name: 'Web Lanjut',
        lecturer: 'Devit Suwardiyanto S.Si, M.T',
        sks: 2,
        progress: 0.15,
        room: 'Lab Pemrogaman 2',
      ),
    ];
  }
}