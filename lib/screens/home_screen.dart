import 'package:flutter/material.dart';
import '../data/destinations.dart';
import '../widgets/home_header.dart';
import '../widgets/search_box.dart';
import '../widgets/hero_banner.dart';
import '../widgets/section_title.dart';
import '../widgets/destination_card.dart';
import '../models/destination.dart';
import '../services/api_service.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    String _categorie = 'Tout';
    int _onglet = 0;

    late Future<List<Destination>> _futurDestinations;
 
  @override
  void initState() {
    super.initState();
    // TODO 1 : lancer la requête et stocker le Future
 _futurDestinations = ApiService.getDestinations();
  }
  
  Future<void> _recharger() async {
    final futur = ApiService.getDestinations();
    setState(() {
      _futurDestinations = futur;
    });
    try {
      await futur;
    } catch (_) {}
  }
  List<Destination> _filtrer(List<Destination> toutes) =>
      _categorie == 'Tout'
          ? toutes
          : toutes.where((d) => d.categorie == _categorie).toList();
 Widget _construireExplorer() {
    return FutureBuilder<List<Destination>>(
      future: _futurDestinations,
      builder: (context, snapshot) {
        // TODO 2 : en attente (waiting) et pas encore de données
        //          -> CircularProgressIndicator centré
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // TODO 3 : erreur (snapshot.hasError) -> ErreurReseau(...)
        if (snapshot.hasError) {
          return ErreurReseau(
            message: 'Impossible de charger les destinations.',
            onReessayer: _recharger,
          );
        }

        final destinations = snapshot.data!;
        return _construireAccueil(destinations);
      },
    );
  }

   Widget _construireAccueil(List<Destination> destinations) {
    final filtrees = _filtrer(destinations);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
           HomeHeader(prenom: 'rimen'),
            SizedBox(height: 20),
            SearchBox(),
             const SizedBox(height: 20),
            HeroBanner(destination: destinations.first),
              const SizedBox(height: 20),
              const SectionTitle(titre: 'Catégories'),
            const SizedBox(height: 12),
                SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final c in categories)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(c),
                        selected: _categorie == c,
                        onSelected: (_) {
                          setState(() {
                            _categorie = c;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
             const SectionTitle(titre: 'Populaires', action: 'Voir tout'),
             const SizedBox(height: 20),
            for (final d in filtrees)
             DestinationCard(
                key: ValueKey(d.id), 
                destination: d,
              ),
        ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _onglet == 0
            ? _construireExplorer()
            : const Center(child: Text('Bientôt disponible')),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _onglet,
        onDestinationSelected: (index) {
          setState(() {
            _onglet = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explorer',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
class ErreurReseau extends StatelessWidget {
  final String message;
  final VoidCallback onReessayer;

  const ErreurReseau({super.key, required this.message, required this.onReessayer});

  @override
  Widget build(BuildContext context) {
     // TODO 4 : Column centrée : Icon(Icons.cloud_off) en couleur d'erreur,
    //          le message, « Vérifiez que json-server est lancé. »,
    //          et un FilledButton.tonalIcon « Réessayer » qui appelle onReessayer
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off,
                color: Theme.of(context).colorScheme.error, size: 64),
            const SizedBox(height: 16),
            Text(message,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Vérifiez que json-server est lancé.',
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            FilledButton.tonalIcon(
              onPressed: onReessayer,
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }
}
