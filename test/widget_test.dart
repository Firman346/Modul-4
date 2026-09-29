import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/modul2/academic_dashboard_screen.dart';

void main() {
  testWidgets(
    'Academic Dashboard tampil dengan benar',
    (WidgetTester tester) async {
      // Atur ukuran layar agar cukup untuk layout desktop
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const AcademicDashboardScreen(),
      );

      expect(
        find.text('Dashboard Akademik TRPL'),
        findsOneWidget,
      );

      expect(
        find.text('Mata Kuliah Semester 3 (4 Terdaftar)'),
        findsOneWidget,
      );

      expect(
        find.text('Pemrograman Perangkat Bergerak'),
        findsOneWidget,
      );

      expect(
        find.text('Interoperabilitas'),
        findsOneWidget,
      );

      // Kembalikan ukuran layar setelah test
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    },
  );
}