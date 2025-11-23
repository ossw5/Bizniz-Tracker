import 'package:hive/hive.dart';

part 'sale.g.dart';

@HiveType(typeId: 1)
class Sale extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String productId;

  @HiveField(2)
  final int quantitySold;

  @HiveField(3)
  final double sellingPrice; // price at time of sale

  @HiveField(4)
  final DateTime saleDate;

  @HiveField(5)
  final double totalRevenue; // quantitySold * sellingPrice

  Sale({
    required this.id,
    required this.productId,
    required this.quantitySold,
    required this.sellingPrice,
    required this.saleDate,
    required this.totalRevenue,
  });

  // Helper to calculate total revenue
  static double calculateRevenue(int quantity, double price) {
    return quantity * price;
  }

  Sale copyWith({
    String? id,
    String? productId,
    int? quantitySold,
    double? sellingPrice,
    DateTime? saleDate,
    double? totalRevenue,
  }) {
    return Sale(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantitySold: quantitySold ?? this.quantitySold,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      saleDate: saleDate ?? this.saleDate,
      totalRevenue: totalRevenue ?? this.totalRevenue,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sale &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          productId == other.productId &&
          quantitySold == other.quantitySold &&
          sellingPrice == other.sellingPrice &&
          saleDate == other.saleDate &&
          totalRevenue == other.totalRevenue;

  @override
  int get hashCode =>
      id.hashCode ^
      productId.hashCode ^
      quantitySold.hashCode ^
      sellingPrice.hashCode ^
      saleDate.hashCode ^
      totalRevenue.hashCode;
}
