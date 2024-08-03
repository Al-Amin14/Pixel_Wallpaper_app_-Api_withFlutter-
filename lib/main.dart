import 'package:flutter/material.dart';
import 'package:wallpaper_app_api/wallpaper.dart';

void main() {
  runApp(const MyWallpaperApp());
}

class MyWallpaperApp extends StatelessWidget {
  const MyWallpaperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: wallpaperApp(),
    );
  }
}