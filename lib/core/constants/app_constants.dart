class AppConstants {
  // App Info
  static const String appName = 'Liggeyalma';
  static const String appVersion = '1.0.0';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String userTypeKey = 'user_type'; // 'client' or 'prestataire'
  static const String rememberMeKey = 'remember_me';
  
  // Default Values
  static const double defaultRadius = 10.0; // km
  static const int defaultPageSize = 20;
  static const int otpLength = 6;
  static const int otpTimeout = 300; // seconds (5 minutes)
  
  // Status
  static const String statusActive = 'active';
  static const String statusInactive = 'inactive';
  static const String statusPending = 'en_attente';
  static const String statusValidated = 'valide';
  
  // Commande Status
  static const String commandeEnAttente = 'en_attente';
  static const String commandeAcceptee = 'acceptee';
  static const String commandeEnRoute = 'en_route';
  static const String commandeArrivee = 'arrivee';
  static const String commandeEnCours = 'en_cours';
  static const String commandeTerminee = 'terminee';
  static const String commandeAnnulee = 'annulee';
  
  // Payment Methods
  static const String paymentMobileMoney = 'mobile_money';
  static const String paymentCarte = 'carte_bancaire';
  static const String paymentCash = 'cash';
  
  // Error Messages
  static const String errorNetwork = 'Erreur de connexion. Vérifiez votre connexion internet.';
  static const String errorServer = 'Erreur serveur. Veuillez réessayer plus tard.';
  static const String errorUnauthorized = 'Session expirée. Veuillez vous reconnecter.';
  static const String errorNotFound = 'Ressource non trouvée.';
  static const String errorUnknown = 'Une erreur inattendue s\'est produite.';
}

