# 📱 Liggeyalma App - Application Mobile

Application mobile Flutter pour la plateforme Liggeyalma - Mise en relation entre clients et prestataires de services.

## 🎯 Description

Application permettant aux **clients** de rechercher et commander des services (plombier, électricien, mécanicien, etc.) et aux **prestataires** de gérer leurs interventions, avec géolocalisation, paiement et suivi en temps réel.

## 📋 Fonctionnalités Principales

### Pour les Clients
- 🔍 Recherche de prestataires par métier et localisation
- 🗺️ Carte interactive avec prestataires disponibles
- 📝 Commande d'intervention (immédiate ou programmée)
- 💳 Paiement (Mobile Money, Carte bancaire, Cash)
- 📱 Suivi en temps réel de la commande
- 💬 Chat en direct avec le prestataire
- ⭐ Notation et avis après intervention

### Pour les Prestataires
- ✅ Gestion de la disponibilité (ON/OFF)
- 📥 Réception et gestion des demandes
- 🗓️ Calendrier des interventions
- 📍 Suivi GPS des interventions
- 💰 Portefeuille et gestion des revenus
- 📊 Statistiques et performance
- ⭐ Avis reçus

## 🛠️ Technologies

- **Framework** : Flutter 3.10+
- **Langage** : Dart
- **State Management** : Provider / Riverpod
- **Navigation** : GoRouter / AutoRoute
- **HTTP** : Dio + Retrofit
- **Maps** : Google Maps Flutter
- **Notifications** : Firebase Cloud Messaging
- **Local Storage** : SharedPreferences / Hive

## 📦 Installation

### Prérequis
- Flutter SDK 3.10.1 ou supérieur
- Dart SDK
- Android Studio / Xcode (pour iOS)
- Un éditeur de code (VS Code recommandé)

### Étapes

1. **Cloner le projet**
   ```bash
   cd liggueyalma_app
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Configurer les variables d'environnement**
   - Créer un fichier `.env` à la racine
   - Ajouter les clés API nécessaires :
     ```
     API_BASE_URL=https://votre-api.com/api
     GOOGLE_MAPS_API_KEY=votre_cle_google_maps
     FIREBASE_PROJECT_ID=votre_project_id
     ```

4. **Lancer l'application**
   ```bash
   flutter run
   ```

## 📁 Structure du Projet

```
lib/
├── main.dart                 # Point d'entrée
├── app/                     # Configuration de l'app
│   ├── app.dart
│   └── routes.dart
├── core/                    # Code partagé
│   ├── constants/           # Constantes
│   ├── theme/              # Thème de l'app
│   ├── utils/              # Utilitaires
│   └── services/           # Services (API, Auth, etc.)
├── models/                  # Modèles de données
├── screens/                 # Écrans de l'application
│   ├── auth/               # Authentification
│   ├── client/             # Écrans client
│   ├── prestataire/        # Écrans prestataire
│   └── shared/             # Écrans partagés
├── widgets/                 # Widgets réutilisables
├── providers/              # State management
└── repositories/           # Repositories (accès données)
```

## 🚀 Développement

### Commandes Utiles

```bash
# Lancer l'app en mode debug
flutter run

# Lancer sur un appareil spécifique
flutter run -d <device_id>

# Build pour Android
flutter build apk

# Build pour iOS
flutter build ios

# Tests
flutter test

# Analyser le code
flutter analyze

# Formater le code
flutter format .
```

### Architecture

L'application suit une architecture **Clean Architecture** avec :
- **Screens** : Interface utilisateur
- **Providers** : Gestion d'état
- **Repositories** : Accès aux données
- **Services** : Services externes (API, GPS, etc.)
- **Models** : Modèles de données

## 📱 Plateformes Supportées

- ✅ Android (API 21+)
- ✅ iOS (iOS 12+)
- ⚠️ Web (optionnel)
- ⚠️ Desktop (optionnel)

## 🔐 Sécurité

- ✅ Chiffrement des données sensibles
- ✅ Validation des données côté client
- ✅ Authentification sécurisée
- ✅ Gestion sécurisée des tokens
- ✅ Protection contre les attaques

## 📝 Documentation

Pour plus de détails sur les fonctionnalités, voir :
- `FONCTIONNALITES_MOBILE.md` - Liste complète des fonctionnalités

## 🤝 Contribution

1. Créer une branche pour votre fonctionnalité
2. Commiter vos changements
3. Pousser vers la branche
4. Ouvrir une Pull Request

## 📄 Licence

Ce projet est privé et propriétaire.

## 👥 Équipe

Développé pour Liggeyalma Platform

---

**Version** : 1.0.0
**Dernière mise à jour** : 2024
# depannema-app
