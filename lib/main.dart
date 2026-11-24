import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart'; 
import 'data/destinations.dart';   
import 'package:provider/provider.dart';
import 'providers/favoris_model.dart'; 
import 'providers/reglages_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavorisModel()..charger()),
        ChangeNotifierProvider(create: (_) => ReglagesModel()..charger()),
      ],
      child: const RihlaApp(),
    ),
  );
}

class RihlaApp extends StatelessWidget {
  const RihlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final reglages = context.watch<ReglagesModel>();
    return MaterialApp(
      title: 'Rihla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E7C86)),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0E7C86),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: reglages.sombre ? ThemeMode.dark : ThemeMode.light,
       home: const HomeScreen(),
      //home: DetailScreen(destination: destinations[1]),
    );
  }
}