import 'dart:convert';
 
import 'package:http/http.dart' as http;
 
import '../config/api_config.dart';
import '../models/destination.dart';
import '../models/reservation.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
 
class ApiService {
  static const _cacheDestinations = 'cache_destinations';
  static bool depuisCache = false;
  static Uri _url(String chemin) => Uri.parse('${ApiConfig.baseUrl}$chemin');
 
  static Future<List<Destination>> getDestinations() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      
      final reponse = await http
          .get(_url('/destinations'))
          .timeout(ApiConfig.timeout);

      if (reponse.statusCode != 200) throw Exception('Erreur ${reponse.statusCode}');

      final corps = utf8.decode(reponse.bodyBytes);

      await prefs.setString(_cacheDestinations, corps);
      depuisCache = false;

      return _decoder(corps);

    } catch (e) {
   
      final cache = prefs.getString(_cacheDestinations);

      if (cache == null) rethrow; 

      depuisCache = true;
      return _decoder(cache);
    }
  }

  
  static List<Destination> _decoder(String texte) {
    final List<dynamic> liste = jsonDecode(texte);
    return liste.map((e) => Destination.fromJson(e)).toList();
  }
 
static Future<String> creerReservation(Reservation reservation) async {
  final reponse = await http
      .post(
        _url('/reservations'),
        headers: {'Content-Type': 'application/json'},
        body: // TODO 3 : encoder reservation.toJson() en texte JSON
        jsonEncode(reservation.toJson()),
      )
      .timeout(ApiConfig.timeout);
 
  // TODO 4 : si le code n'est pas 201, lancer une Exception
  if (reponse.statusCode != 201) {
      throw Exception('Échec de création : code ${reponse.statusCode}');
    }
 
  final Map<String, dynamic> creee = jsonDecode(utf8.decode(reponse.bodyBytes));
  return creee['id'].toString();   // l'id attribué par le serveur
}
static Future<List<Reservation>> getReservations() async {
    final reponse = await http
        .get(_url('/reservations?_embed=destination'))
        .timeout(ApiConfig.timeout);

    if (reponse.statusCode != 200) {
      throw Exception('Erreur serveur : code ${reponse.statusCode}');
    }

    final List<dynamic> liste = jsonDecode(utf8.decode(reponse.bodyBytes));
    return liste.map((e) => Reservation.fromJson(e)).toList();
  }
  static Future<void> supprimerReservation(String id) async {
  final reponse = await http
      .delete(_url('/reservations/$id'))
      .timeout(ApiConfig.timeout);

  if (reponse.statusCode != 200) {
    throw Exception('Erreur suppression : ${reponse.statusCode}');
  }
}

}
