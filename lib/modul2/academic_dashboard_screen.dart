import 'package:flutter/material.dart';

import 'models/course.dart';
import 'widgets/course_card.dart';
import 'widgets/header_banner.dart';

class AcademicDashboardScreen extends StatefulWidget {
  const AcademicDashboardScreen({super.key});

  @override
  State<AcademicDashboardScreen> createState() =>
      _AcademicDashboardScreenState();
}

class _AcademicDashboardScreenState
    extends State<AcademicDashboardScreen> {
  final List<Course> courses = Course.getSampleCourses();

  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // TEMA LIGHT / DARK MODE
      theme: ThemeData(
        useMaterial3: true,
        brightness:
            _isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: const Color(0xFF0284C7),
      ),

      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard Akademik TRPL',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          // Tombol Dark Mode
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                },
                icon: Icon(
                  _isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                label: Text(
                  _isDarkMode
                      ? 'Mode Terang'
                      : 'Mode Gelap',
                ),
              ),
            ),
          ],
        ),

        // RESPONSIVE LAYOUT
        body: LayoutBuilder(
          builder: (context, constraints) {
            // MOBILE
            if (constraints.maxWidth < 600) {
              return _buildMobileLayout();
            }

            // TABLET / DESKTOP
            return _buildDesktopLayout();
          },
        ),
      ),
    );
  }

  // TAMPILAN MOBILE
  Widget _buildMobileLayout() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const HeaderBanner(),

        const SizedBox(height: 16),

        _buildCourseTitle(),

        const SizedBox(height: 12),

        ...courses.map(
          (course) => CourseCard(
            course: course,
          ),
        ),
      ],
    );
  }

  // TAMPILAN TABLET / DESKTOP
  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // BANNER SEBELAH KIRI
          const Expanded(
            flex: 1,
            child: HeaderBanner(),
          ),

          const SizedBox(width: 24),

          // DAFTAR MATA KULIAH
          Expanded(
            flex: 2,
            child: ListView(
              children: [
                _buildCourseTitle(),

                const SizedBox(height: 12),

                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.3,
                  ),
                  itemBuilder: (context, index) {
                    return CourseCard(
                      course: courses[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // JUDUL MATA KULIAH
  Widget _buildCourseTitle() {
    return Text(
      'Mata Kuliah Semester 3 (${courses.length} Terdaftar)',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}