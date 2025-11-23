import 'package:flutter/material.dart';
import 'package:bizniz_tracker/features/sales/presentation/sales_controller.dart';
import 'package:bizniz_tracker/core/formatters.dart';
import 'package:bizniz_tracker/features/products/presentation/controllers.dart';
import 'package:bizniz_tracker/core/theme.dart';

class HomeScreen extends StatefulWidget {
  final ProductController productController;
  final SalesController salesController;
  final Function(int)
  onNavigate; // 0: Home, 1: Inventory, 2: Add Sale, 3: Sales Summary

  const HomeScreen({
    required this.productController,
    required this.salesController,
    required this.onNavigate,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<DailySummary> _summaryFuture;

  @override
  void initState() {
    super.initState();
    _summaryFuture = widget.salesController.getDailySummary();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: FutureBuilder<DailySummary>(
        future: _summaryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final summary = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                // Daily Summary Cards
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Summary',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSummaryCard(
                            label: 'Revenue',
                            value: formatCurrency(summary.totalRevenue),
                            color: kTeal,
                          ),
                          _buildSummaryCard(
                            label: 'Profit',
                            value: formatCurrency(summary.totalProfit),
                            color: kBrown,
                          ),
                          _buildSummaryCard(
                            label: 'Sales',
                            value: '${summary.totalSalesCount}',
                            color: kTealDark,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),

                // Low Stock Alerts
                if (summary.lowStockItems.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Low Stock Alerts',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ...summary.lowStockItems.map((product) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Card(
                              color: Theme.of(context).cardColor,
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(
                                  Icons.inventory_2,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(
                                  product.name,
                                  style: theme.textTheme.bodyMedium,
                                ),
                                subtitle: Text(
                                  'Stock: ${product.quantity} / ${product.minStock} min',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                trailing: Chip(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.error,
                                  label: Text(
                                    'LOW',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onNavigate(2); // Navigate to Add Sale
        },
        tooltip: 'Add Sale',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: 100,
        child: Column(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                color: Theme.of(context).hintColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontSize: 16, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
