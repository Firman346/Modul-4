import 'package:flutter/material.dart';
import 'screen/krs_list_screen.dart';

class Modul03App extends StatefulWidget {
  const Modul03App({super.key});

  @override
  State<Modul03App> createState() => _Modul03AppState();
}

class _Modul03AppState extends State<Modul03App> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF0284C7);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 03 - Navigasi Dasar & Form',
      themeMode: _themeMode,

      // LIGHT MODE
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
      ),

      // DARK MODE
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
      ),

      home: KrsListScreen(
        onToggleTheme: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}