import 'package:hive/hive.dart';
import 'package:bizniz_tracker/features/sales/domain/sale.dart';
import 'package:bizniz_tracker/features/sales/domain/sale_repository.dart';

class SaleLocalDataSource {
  final Box<Sale> salesBox;

  SaleLocalDataSource({required this.salesBox});

  Future<Sale> addSale(Sale sale) async {
    await salesBox.put(sale.id, sale);
    return sale;
  }

  Future<List<Sale>> getAllSales() async {
    return salesBox.values.cast<Sale>().toList();
  }

  Future<List<Sale>> getSalesByDate(DateTime date) async {
    final allSales = salesBox.values.cast<Sale>().toList();
    return allSales.where((sale) {
      final saleDate = DateTime(
        sale.saleDate.year,
        sale.saleDate.month,
        sale.saleDate.day,
      );
      final targetDate = DateTime(date.year, date.month, date.day);
      return saleDate == targetDate;
    }).toList();
  }

  Future<List<Sale>> getSalesByDateRange(DateTime start, DateTime end) async {
    final allSales = salesBox.values.cast<Sale>().toList();
    return allSales.where((sale) {
      return sale.saleDate.isAfter(start) &&
          sale.saleDate.isBefore(end.add(Duration(days: 1)));
    }).toList();
  }

  Future<List<Sale>> getSalesByProductId(String productId) async {
    final allSales = salesBox.values.cast<Sale>().toList();
    return allSales.where((sale) => sale.productId == productId).toList();
  }

  Future<bool> deleteSale(String id) async {
    await salesBox.delete(id);
    return true;
  }
}

class SaleRepositoryImpl implements SaleRepository {
  final SaleLocalDataSource local;

  SaleRepositoryImpl({required this.local});

  @override
  Future<Sale> addSale(Sale sale) => local.addSale(sale);

  @override
  Future<List<Sale>> getAllSales() => local.getAllSales();

  @override
  Future<List<Sale>> getSalesByDate(DateTime date) =>
      local.getSalesByDate(date);

  @override
  Future<List<Sale>> getSalesByDateRange(DateTime start, DateTime end) =>
      local.getSalesByDateRange(start, end);

  @override
  Future<List<Sale>> getSalesByProductId(String productId) =>
      local.getSalesByProductId(productId);

  @override
  Future<bool> deleteSale(String id) => local.deleteSale(id);
}
