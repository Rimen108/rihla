import 'package:flutter/material.dart';
import '../models/reservation.dart';
import '../services/api_service.dart';

class MesReservationsScreen extends StatefulWidget {
  const MesReservationsScreen({super.key});
  @override
  State<MesReservationsScreen> createState() => _MesReservationsScreenState();
}

class _MesReservationsScreenState extends State<MesReservationsScreen> {
  late Future<List<Reservation>> _futurReservations;
  
 
  List<Reservation>? _reservations;

  @override
  void initState() {
    super.initState();
    _futurReservations = ApiService.getReservations();
  }

  Future<void> _recharger() async {
    final futur = ApiService.getReservations();
    setState(() {
      _futurReservations = futur;
      _reservations = null;
    });
    try {
      await futur;
    } catch (_) {}
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(title: const Text('Mes voyages'), elevation: 0),
      body: FutureBuilder<List<Reservation>>(
        future: _futurReservations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.cloud_off,
                      color: Theme.of(context).colorScheme.error, size: 64),
                  const SizedBox(height: 16),
                  const Text('Impossible de charger vos voyages.'),
                  const SizedBox(height: 16),
                  FilledButton.tonalIcon(
                    onPressed: _recharger,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          
          _reservations ??= snapshot.data!;

          if (_reservations!.isEmpty) {
            return const Center(
                child: Text('Aucune réservation pour le moment'));
          }

          return RefreshIndicator(
            onRefresh: _recharger,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: _reservations!.length, 
              itemBuilder: (context, index) {
                final r = _reservations![index]; 

                return Dismissible(
                  key: ValueKey(r.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) async {
                  
                    setState(() {
                      _reservations!.removeAt(index);
                    });
                  
                    try {
                      await ApiService.supprimerReservation(r.id!);
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Suppression impossible')),
                        );
                      }
                    }
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          r.destination.image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(r.destination.nom,
                          style:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Départ le ${_formatDate(r.dateDepart)}\n${r.voyageurs} voyageur(s) • ${r.formule}'),
                      trailing: Text('${r.total.toStringAsFixed(0)} DT',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}