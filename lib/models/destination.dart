class Destination {
  final String id;
  final String nom;
  final String region;
  final String categorie; 
  final String image; 
  final double note; 
  final int prix; 
  final String duree;
  final String description;

  const Destination({
    required this.id,
    required this.nom,
    required this.region,
    required this.categorie,
    required this.image,
    required this.note,
    required this.prix,
    required this.duree,
    required this.description,
  });
  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'].toString(),
      nom: json['nom'] as String,
      // TODO 1 : region, categorie, image, duree, description (as String)
      region: json['region'] as String,
      categorie: json['categorie'] as String,
      image: json['image'] as String,
       duree: json['duree'] as String,
      description: json['description'] as String,
      // TODO 2 : note -> double. Attention : 5 arrive en int, 4.8 en double
      note: (json['note'] as num).toDouble(),
      // TODO 3 : prix -> int
      prix: (json['prix'] as num).toInt(),

    );
  }

}
