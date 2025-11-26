import 'user.dart';

class Prestataire {
  final int id;
  final int userId;
  final String? metier;
  final String? description;
  final double? tarifHoraire;
  final double? noteMoyenne;
  final int? nombreAvis;
  final int? nombreInterventions;
  final bool? certifie;
  final String? statutInscription;
  final double? solde;
  final double? scoreConfiance;
  final double? latitude;
  final double? longitude;
  final bool? disponible;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User? user;

  Prestataire({
    required this.id,
    required this.userId,
    this.metier,
    this.description,
    this.tarifHoraire,
    this.noteMoyenne,
    this.nombreAvis,
    this.nombreInterventions,
    this.certifie,
    this.statutInscription,
    this.solde,
    this.scoreConfiance,
    this.latitude,
    this.longitude,
    this.disponible,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory Prestataire.fromJson(Map<String, dynamic> json) {
    return Prestataire(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      metier: json['metier'] as String?,
      description: json['description'] as String?,
      tarifHoraire: json['tarif_horaire'] != null
          ? (json['tarif_horaire'] as num).toDouble()
          : null,
      noteMoyenne: json['note_moyenne'] != null
          ? (json['note_moyenne'] as num).toDouble()
          : null,
      nombreAvis: json['nombre_avis'] as int?,
      nombreInterventions: json['nombre_interventions'] as int?,
      certifie: json['certifie'] as bool? ?? false,
      statutInscription: json['statut_inscription'] as String?,
      solde: json['solde'] != null ? (json['solde'] as num).toDouble() : null,
      scoreConfiance: json['score_confiance'] != null
          ? (json['score_confiance'] as num).toDouble()
          : null,
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      disponible: json['disponible'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'metier': metier,
      'description': description,
      'tarif_horaire': tarifHoraire,
      'note_moyenne': noteMoyenne,
      'nombre_avis': nombreAvis,
      'nombre_interventions': nombreInterventions,
      'certifie': certifie,
      'statut_inscription': statutInscription,
      'solde': solde,
      'score_confiance': scoreConfiance,
      'latitude': latitude,
      'longitude': longitude,
      'disponible': disponible,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user': user?.toJson(),
    };
  }
}

