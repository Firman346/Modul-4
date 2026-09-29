import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/modul3/app.dart';
import 'package:flutter_application_1/modul3/screen/add_krs_screen.dart';
import 'package:flutter_application_1/modul3/screen/course_detail_screen.dart';

void main() {
  testWidgets(
    'Daftar KRS menampilkan 5 mata kuliah',
    (WidgetTester tester) async {
      await tester.pumpWidget(const Modul03App());

      expect(find.text('Statistika'), findsOneWidget);
      expect(find.text('Interoperabilitas'), findsOneWidget);
      expect(
        find.text('Pemrograman Perangkat Bergerak'),
        findsOneWidget,
      );
      expect(
        find.text('Rekayasa Kebutuhan Perangkat Lunak'),
        findsOneWidget,
      );
      expect(find.text('Basis Data'), findsOneWidget);
    },
  );

  testWidgets(
    'Klik mata kuliah membuka halaman detail',
    (WidgetTester tester) async {
      await tester.pumpWidget(const Modul03App());

      await tester.tap(find.text('Statistika'));
      await tester.pumpAndSettle();

      expect(find.byType(CourseDetailScreen), findsOneWidget);
      expect(find.text('TRPL504'), findsNWidgets(2));
      expect(find.text('Statistika'), findsOneWidget);
      expect(find.text('Siska Aprilio S.Pd, M.Si'), findsOneWidget);
      expect(find.text('3 SKS'), findsOneWidget);
    },
  );

  testWidgets(
    'Tombol Tambah KRS membuka form',
    (WidgetTester tester) async {
      await tester.pumpWidget(const Modul03App());

      await tester.tap(find.text('Tambah KRS'));
      await tester.pumpAndSettle();

      expect(find.byType(AddKrsScreen), findsOneWidget);
      expect(find.text('Tambah Mata Kuliah'), findsOneWidget);
      expect(find.text('Kode Mata Kuliah'), findsOneWidget);
      expect(find.text('Nama Mata Kuliah'), findsOneWidget);
      expect(find.text('Dosen Pengampu'), findsOneWidget);
      expect(find.text('Jumlah SKS'), findsOneWidget);
      expect(find.text('Deskripsi'), findsOneWidget);
    },
  );

  testWidgets(
    'Form kosong menampilkan validasi',
    (WidgetTester tester) async {
      await tester.pumpWidget(const Modul03App());

      await tester.tap(find.text('Tambah KRS'));
      await tester.pumpAndSettle();

      final listView = find.byType(ListView).last;

      await tester.drag(
        listView,
        const Offset(0, -600),
      );

      await tester.pumpAndSettle();

      expect(find.text('Simpan KRS'), findsOneWidget);

      await tester.tap(find.text('Simpan KRS'));
      await tester.pumpAndSettle();

      expect(
        find.text('Kode mata kuliah wajib diisi.'),
        findsOneWidget,
      );

      expect(
        find.text('Nama mata kuliah wajib diisi.'),
        findsOneWidget,
      );

      expect(
        find.text('Nama dosen wajib diisi.'),
        findsOneWidget,
      );
    },
  );
}