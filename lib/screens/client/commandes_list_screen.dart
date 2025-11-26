import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';
import '../../core/constants/api_constants.dart';
import '../../models/commande.dart';

class CommandesListScreen extends StatefulWidget {
  const CommandesListScreen({super.key});

  @override
  State<CommandesListScreen> createState() => _CommandesListScreenState();
}

class _CommandesListScreenState extends State<CommandesListScreen> {
  final ApiService _apiService = ApiService();
  List<Commande> _commandes = [];
  bool _isLoading = true;
  String _filter = 'Toutes';

  @override
  void initState() {
    super.initState();
    _loadCommandes();
  }

  Future<void> _loadCommandes() async {
    setState(() => _isLoading = true);

    try {
      final response = await _apiService.get(ApiConstants.commandes);
      if (response['data'] != null) {
        setState(() {
          _commandes = (response['data'] as List)
              .map((json) => Commande.fromJson(json as Map<String, dynamic>))
              .toList();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  List<Commande> get _filteredCommandes {
    if (_filter == 'Toutes') return _commandes;
    return _commandes.where((c) => c.statut == _filter).toList();
  }

  Color _getStatusColor(String? statut) {
    switch (statut) {
      case 'terminee':
        return Colors.green;
      case 'annulee':
        return Colors.red;
      case 'en_attente':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes commandes'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() => _filter = value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Toutes', child: Text('Toutes')),
              const PopupMenuItem(
                value: 'en_attente',
                child: Text('En attente'),
              ),
              const PopupMenuItem(
                value: 'acceptee',
                child: Text('Acceptée'),
              ),
              const PopupMenuItem(
                value: 'en_cours',
                child: Text('En cours'),
              ),
              const PopupMenuItem(
                value: 'terminee',
                child: Text('Terminée'),
              ),
              const PopupMenuItem(
                value: 'annulee',
                child: Text('Annulée'),
              ),
            ],
            child: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadCommandes,
              child: _filteredCommandes.isEmpty
                  ? const Center(
                      child: Text('Aucune commande trouvée'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredCommandes.length,
                      itemBuilder: (context, index) {
                        final commande = _filteredCommandes[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getStatusColor(commande.statut),
                              child: const Icon(Icons.assignment, color: Colors.white),
                            ),
                            title: Text(commande.titre ?? 'Commande'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text('Statut: ${commande.statut ?? 'N/A'}'),
                                if (commande.montant != null)
                                  Text(
                                    'Montant: ${commande.montant!.toStringAsFixed(0)} FCFA',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              // TODO: Navigate to commande detail
                            },
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}

