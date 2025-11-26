import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';
import '../../core/constants/api_constants.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final ApiService _apiService = ApiService();
  double _solde = 0.0;
  List<Map<String, dynamic>> _transactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWalletData();
  }

  Future<void> _loadWalletData() async {
    setState(() => _isLoading = true);

    try {
      // Load solde from prestataire profile
      final profileResponse = await _apiService.get(ApiConstants.prestataireProfile);
      if (profileResponse['data'] != null) {
        final data = profileResponse['data'] as Map<String, dynamic>;
        setState(() {
          _solde = (data['solde'] as num?)?.toDouble() ?? 0.0;
        });
      }

      // Load transactions
      final transactionsResponse = await _apiService.get(ApiConstants.transactions);
      if (transactionsResponse['data'] != null) {
        setState(() {
          _transactions = List<Map<String, dynamic>>.from(
            transactionsResponse['data'] as List,
          );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portefeuille'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadWalletData,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Solde Card
                    Card(
                      color: Theme.of(context).colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            const Text(
                              'Solde disponible',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${_solde.toStringAsFixed(0)} FCFA',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // TODO: Navigate to retrait screen
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Theme.of(context).colorScheme.primary,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text('Demander un retrait'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Transactions
                    const Text(
                      'Historique des transactions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _transactions.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: Text('Aucune transaction'),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = _transactions[index];
                              final montant = (transaction['montant'] as num?)?.toDouble() ?? 0.0;
                              final type = transaction['type'] as String? ?? '';
                              final isCredit = type == 'paiement' || type == 'commission';

                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: isCredit ? Colors.green : Colors.red,
                                    child: Icon(
                                      isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(transaction['description'] ?? 'Transaction'),
                                  subtitle: Text(
                                    transaction['created_at'] != null
                                        ? DateTime.parse(transaction['created_at'] as String)
                                            .toString()
                                            .substring(0, 10)
                                        : '',
                                  ),
                                  trailing: Text(
                                    '${isCredit ? '+' : '-'}${montant.toStringAsFixed(0)} FCFA',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isCredit ? Colors.green : Colors.red,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}

