import 'package:bizniz_tracker/features/sales/domain/sale.dart';

abstract class SaleRepository {
  Future<Sale> addSale(Sale sale);
  Future<List<Sale>> getAllSales();
  Future<List<Sale>> getSalesByDate(DateTime date);
  Future<List<Sale>> getSalesByDateRange(DateTime start, DateTime end);
  Future<List<Sale>> getSalesByProductId(String productId);
  Future<bool> deleteSale(String id);
}
