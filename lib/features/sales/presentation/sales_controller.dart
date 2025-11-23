import 'package:bizniz_tracker/features/products/domain/product.dart';
import 'package:bizniz_tracker/features/products/presentation/controllers.dart';
import 'package:bizniz_tracker/features/sales/data/sale_repository_impl.dart';

class DailySummary {
  final double totalRevenue;
  final double totalCost;
  final double totalProfit;
  final int totalSalesCount;
  final List<ProductModel> lowStockItems;

  DailySummary({
    required this.totalRevenue,
    required this.totalCost,
    required this.totalProfit,
    required this.totalSalesCount,
    required this.lowStockItems,
  });
}

class SalesController {
  final SaleRepositoryImpl saleRepository;
  final ProductController productController;

  SalesController({
    required this.saleRepository,
    required this.productController,
  });

  Future<DailySummary> getDailySummary() async {
    final today = DateTime.now();
    final sales = await saleRepository.getSalesByDate(today);
    final products = productController.state.products;

    double totalRevenue = 0;
    double totalCost = 0;

    // Calculate totals from sales
    for (final sale in sales) {
      totalRevenue += sale.totalRevenue;
      // Find product to calculate cost
      try {
        final product = products.firstWhere((p) => p.id == sale.productId);
        totalCost += (sale.quantitySold * product.costPrice);
      } catch (e) {
        // Product not found
      }
    }

    final totalProfit = totalRevenue - totalCost;

    // Find low stock items
    final lowStockItems = products
        .where((product) => product.quantity < product.minStock)
        .toList();

    return DailySummary(
      totalRevenue: totalRevenue,
      totalCost: totalCost,
      totalProfit: totalProfit,
      totalSalesCount: sales.length,
      lowStockItems: lowStockItems,
    );
  }
}
