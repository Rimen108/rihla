import 'package:flutter/foundation.dart';
import '../models/destination.dart';

class FavorisModel extends ChangeNotifier {
  final Map<String, Destination> _favoris = {};

  bool estFavori(Destination d) => _favoris.containsKey(d.id);
  List<Destination> get liste => _favoris.values.toList();
  int get nombre => _favoris.length;

  bool basculer(Destination d) {
    final ajoute = _favoris.remove(d.id) == null;
    if (ajoute) _favoris[d.id] = d;
    notifyListeners();
    return ajoute;
  }

  
  void reinitialiser() {
    _favoris.clear();
    notifyListeners();
  }

  
  void toutSupprimer() {
    _favoris.clear();
    notifyListeners();
  }
}