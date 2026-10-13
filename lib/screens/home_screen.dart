import 'package:flutter/material.dart';
import '../data/destinations.dart';
import '../widgets/home_header.dart';
import '../widgets/search_box.dart';
import '../widgets/hero_banner.dart';
 
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
           HomeHeader(prenom: 'rimen'),
            SizedBox(height: 20),
            SearchBox(),
             const SizedBox(height: 20),
            HeroBanner(destination: destinations.first),
          ],
        ),
      ),
    );
  }
}
