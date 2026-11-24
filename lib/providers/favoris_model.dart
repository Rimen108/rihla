import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/destination.dart';

class FavorisModel extends ChangeNotifier {
  static const _cle = 'favoris';
  final Map<String, Destination> _favoris = {};
  // estFavori, liste, nombre : inchangés (TP6)
 bool estFavori(Destination d) => _favoris.containsKey(d.id);
 List<Destination> get liste => List.unmodifiable(_favoris.values);
  int get nombre => _favoris.length;

  Future<void> charger() async {
    final prefs = await SharedPreferences.getInstance();
    // TODO 1 : lire la liste de textes (liste vide si rien n'est stocké)
     final textes = prefs.getStringList(_cle) ?? [];
    // TODO 2 : pour chaque texte : jsonDecode puis Destination.fromJson,
    //          ranger la destination dans _favoris avec son id
    for (final t in textes) {
      final d = Destination.fromJson(jsonDecode(t));
      _favoris[d.id] = d;
    }
    notifyListeners();
  }
 
  Future<void> _sauvegarder() async {
    final prefs = await SharedPreferences.getInstance();
    // TODO 3 : transformer chaque destination en texte
    //          (toJson puis jsonEncode) et l'écrire avec setStringList
    final textes = _favoris.values.map((d) => jsonEncode(d.toJson())).toList();
    await prefs.setStringList(_cle, textes);
  }
 
  bool basculer(Destination d) {
    final ajoute = _favoris.remove(d.id) == null;
    if (ajoute) _favoris[d.id] = d;
    notifyListeners();
    _sauvegarder(); // TP7 : recopie sur le disque
    return ajoute;
  }
}
