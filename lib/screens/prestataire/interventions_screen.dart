import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';
import '../../core/constants/api_constants.dart';
import '../../models/commande.dart';

class InterventionsScreen extends StatefulWidget {
  const InterventionsScreen({super.key});

  @override
  State<InterventionsScreen> createState() => _InterventionsScreenState();
}

class _InterventionsScreenState extends State<InterventionsScreen> {
  final ApiService _apiService = ApiService();
  List<Commande> _interventions = [];
  bool _isLoading = true;
  String _filter = 'Toutes';

  @override
  void initState() {
    super.initState();
    _loadInterventions();
  }

  Future<void> _loadInterventions() async {
    setState(() => _isLoading = true);

    try {
      final response = await _apiService.get(ApiConstants.commandes);
      if (response['data'] != null) {
        setState(() {
          _interventions = (response['data'] as List)
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

  List<Commande> get _filteredInterventions {
    if (_filter == 'Toutes') return _interventions;
    return _interventions.where((i) => i.statut == _filter).toList();
  }

  Color _getStatusColor(String? statut) {
    switch (statut) {
      case 'terminee':
        return Colors.green;
      case 'annulee':
        return Colors.red;
      case 'en_attente':
        return Colors.orange;
      case 'acceptee':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes interventions'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() => _filter = value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Toutes', child: Text('Toutes')),
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
            ],
            child: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadInterventions,
              child: _filteredInterventions.isEmpty
                  ? const Center(
                      child: Text('Aucune intervention'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredInterventions.length,
                      itemBuilder: (context, index) {
                        final intervention = _filteredInterventions[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getStatusColor(intervention.statut),
                              child: const Icon(Icons.work, color: Colors.white),
                            ),
                            title: Text(intervention.titre ?? 'Intervention'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text('Client: ${intervention.client?.user?.name ?? 'N/A'}'),
                                Text('Statut: ${intervention.statut ?? 'N/A'}'),
                                if (intervention.montant != null)
                                  Text(
                                    'Montant: ${intervention.montant!.toStringAsFixed(0)} FCFA',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              // TODO: Navigate to intervention detail
                            },
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}

