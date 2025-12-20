import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/data/resume_data.dart';
import 'src/ui/screens/cv_home_screen.dart';

void main() {
  runApp(const CVWebsite());
}

class CVWebsite extends StatefulWidget {
  const CVWebsite({super.key});

  @override
  State<CVWebsite> createState() => _CVWebsiteState();
}

class _CVWebsiteState extends State<CVWebsite> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.system) {
        // Get current system brightness to toggle correctly from system mode
        final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        _themeMode = brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
      } else {
        _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      }
    });
  }

  ThemeData get _darkTheme => ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF00FFC8), // More vibrant teal
        scaffoldBackgroundColor: const Color(0xFF0A192F), // Deep Navy
        cardColor: const Color(0xFF112240), // Lighter Navy
        textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme).apply(
          bodyColor: const Color(0xFF94A3B8), // Brighter gray-blue
          displayColor: const Color(0xFFE2E8F0), // Brighter white
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFC8), // More vibrant teal
          secondary: Color(0xFF00FFC8),
          surface: Color(0xFF112240),
        ),
        useMaterial3: true,
      );

  ThemeData get _lightTheme => ThemeData.light().copyWith(
        primaryColor: const Color(0xFF0891E5), // More vibrant blue
        scaffoldBackgroundColor: const Color(0xFFF5F7FA), // Light gray
        cardColor: Colors.white,
        textTheme: GoogleFonts.robotoTextTheme(ThemeData.light().textTheme).apply(
          bodyColor: const Color(0xFF475569), // Slightly brighter
          displayColor: const Color(0xFF0F172A),
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0891E5), // More vibrant blue
          secondary: Color(0xFF0891E5),
          surface: Colors.white,
        ),
        useMaterial3: true,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${ResumeData.profile.name} - ${ResumeData.profile.title}',
      debugShowCheckedModeBanner: false,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: _themeMode,
      home: Banner(
        message: 'BETA',
        location: BannerLocation.topStart,
        color: const Color(0xFFFF4081),
        textStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        child: SelectionArea(
          child: CVHomePage(onThemeToggle: _toggleTheme, currentThemeMode: _themeMode),
        ),
      ),
    );
  }
}
