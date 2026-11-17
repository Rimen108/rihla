import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favoris_model.dart';
import '../widgets/destination_card.dart';

class FavorisScreen extends StatelessWidget {
  const FavorisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoris = context.watch<FavorisModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(title: const Text('Mes favoris'), elevation: 0),
      body: favoris.liste.isEmpty
          ? const Center(child: Text('Touchez ♥ sur une destination pour l\'ajouter'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoris.liste.length,
              itemBuilder: (context, index) {
                return DestinationCard(destination: favoris.liste[index]);
              },
            ),
    );
  }
}