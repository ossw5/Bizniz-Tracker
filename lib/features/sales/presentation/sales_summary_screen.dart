import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizniz_tracker/core/formatters.dart';
import 'package:bizniz_tracker/core/theme.dart';
import 'package:bizniz_tracker/core/csv_export.dart';
import 'package:bizniz_tracker/features/products/presentation/providers.dart';

class SalesSummaryScreen extends StatefulWidget {
  final Function(int) onNavigate;

  const SalesSummaryScreen({required this.onNavigate, super.key});

  @override
  State<SalesSummaryScreen> createState() => _SalesSummaryScreenState();
}

class _SalesSummaryScreenState extends State<SalesSummaryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Summary'),
        actions: [
          IconButton(
            tooltip: 'Export sales CSV',
            onPressed: () async {
              try {
                final ref = ProviderScope.containerOf(context);
                final box = ref.read(salesBoxProvider);
                final sales = box.values.toList();
                final csv = CsvExport.salesToCsv(sales.cast());
                final fname =
                    'sales_${DateTime.now().toIso8601String().replaceAll(':', '-')}.csv';
                final path = await CsvExport.saveCsvFile(fname, csv);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Saved CSV to: $path')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Export failed: ${e.toString()}')),
                  );
                }
              }
            },
            icon: const Icon(Icons.download),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Daily'),
            Tab(text: 'Weekly'),
            Tab(text: 'Monthly'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _SummaryTab(period: 'Daily'),
          _SummaryTab(period: 'Weekly'),
          _SummaryTab(period: 'Monthly'),
        ],
      ),
    );
  }
}

class _SummaryTab extends StatelessWidget {
  final String period;

  const _SummaryTab({required this.period});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Text(
            '$period Summary',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SummaryCard(label: 'Sales', value: '0', color: kTealDark),
              _SummaryCard(
                label: 'Revenue',
                value: formatCurrency(0),
                color: kTeal,
              ),
              _SummaryCard(
                label: 'Profit',
                value: formatCurrency(0),
                color: kBrown,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Cost Breakdown
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cost Breakdown',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text('Total Revenue: ${formatCurrency(0)}'),
                Text('Total Cost: ${formatCurrency(0)}'),
                Text(
                  'Net Profit: ${formatCurrency(0)}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: kTeal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Placeholder
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'Sales summary for $period coming soon.\nStart adding sales to see analytics.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(
          (color.r * 255).round(),
          (color.g * 255).round(),
          (color.b * 255).round(),
          0.06,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontSize: 16, color: color),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 12,
              color: Theme.of(context).hintColor,
            ),
          ),
        ],
      ),
    );
  }
}
