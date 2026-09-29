import 'package:flutter/material.dart';

import 'screens/announcement_list_screen.dart';
import 'services/announcement_api.dart';

const bool kModeSimulasi = bool.fromEnvironment('SIMULASI');

class Modul04App extends StatelessWidget {
  const Modul04App({super.key});

  @override
  Widget build(BuildContext context) {
    const warnaUtama = Color(0xFF0284C7);
    const warnaSekunder = Color(0xFF06B6D4);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: warnaUtama,
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portal Pengumuman TRPL',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,

        scaffoldBackgroundColor: const Color(0xFFF0F9FF),

        appBarTheme: const AppBarTheme(
          backgroundColor: warnaUtama,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),

        chipTheme: ChipThemeData(
          selectedColor: warnaUtama,
          backgroundColor: Colors.white,
          side: BorderSide(
            color: Color(0xFFBAE6FD),
          ),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          secondaryLabelStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: warnaUtama,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: warnaSekunder,
        ),
      ),
      home: AnnouncementListScreen(
        api: AnnouncementApi(
          modeSimulasi: kModeSimulasi,
        ),
      ),
    );
  }
}