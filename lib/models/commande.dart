import 'prestataire.dart';
import 'client.dart';

class Commande {
  final int id;
  final int clientId;
  final int? prestataireId;
  final int categorieServiceId;
  final String? titre;
  final String? description;
  final String? adresse;
  final double? latitude;
  final double? longitude;
  final double? montant;
  final String? statut;
  final DateTime? dateIntervention;
  final DateTime? dateAcceptation;
  final DateTime? dateArrivee;
  final DateTime? dateDebut;
  final DateTime? dateFin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Client? client;
  final Prestataire? prestataire;

  Commande({
    required this.id,
    required this.clientId,
    this.prestataireId,
    required this.categorieServiceId,
    this.titre,
    this.description,
    this.adresse,
    this.latitude,
    this.longitude,
    this.montant,
    this.statut,
    this.dateIntervention,
    this.dateAcceptation,
    this.dateArrivee,
    this.dateDebut,
    this.dateFin,
    required this.createdAt,
    required this.updatedAt,
    this.client,
    this.prestataire,
  });

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['id'] as int,
      clientId: json['client_id'] as int,
      prestataireId: json['prestataire_id'] as int?,
      categorieServiceId: json['categorie_service_id'] as int,
      titre: json['titre'] as String?,
      description: json['description'] as String?,
      adresse: json['adresse'] as String?,
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      montant: json['montant'] != null ? (json['montant'] as num).toDouble() : null,
      statut: json['statut'] as String?,
      dateIntervention: json['date_intervention'] != null
          ? DateTime.parse(json['date_intervention'] as String)
          : null,
      dateAcceptation: json['date_acceptation'] != null
          ? DateTime.parse(json['date_acceptation'] as String)
          : null,
      dateArrivee: json['date_arrivee'] != null
          ? DateTime.parse(json['date_arrivee'] as String)
          : null,
      dateDebut: json['date_debut'] != null
          ? DateTime.parse(json['date_debut'] as String)
          : null,
      dateFin: json['date_fin'] != null
          ? DateTime.parse(json['date_fin'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      client: json['client'] != null
          ? Client.fromJson(json['client'] as Map<String, dynamic>)
          : null,
      prestataire: json['prestataire'] != null
          ? Prestataire.fromJson(json['prestataire'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'prestataire_id': prestataireId,
      'categorie_service_id': categorieServiceId,
      'titre': titre,
      'description': description,
      'adresse': adresse,
      'latitude': latitude,
      'longitude': longitude,
      'montant': montant,
      'statut': statut,
      'date_intervention': dateIntervention?.toIso8601String(),
      'date_acceptation': dateAcceptation?.toIso8601String(),
      'date_arrivee': dateArrivee?.toIso8601String(),
      'date_debut': dateDebut?.toIso8601String(),
      'date_fin': dateFin?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

