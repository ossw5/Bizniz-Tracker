import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bizniz_tracker/features/products/domain/product.dart';
import 'package:bizniz_tracker/features/sales/domain/sale.dart';

class CsvExport {
  static String _escape(String v) {
    if (v.contains(',') || v.contains('\n') || v.contains('"')) {
      final escaped = v.replaceAll('"', '""');
      return '"$escaped"';
    }
    return v;
  }

  static String productsToCsv(List<ProductModel> products) {
    final sb = StringBuffer();
    sb.writeln('id,name,quantity,cost_price,selling_price,category,min_stock');
    for (final p in products) {
      sb.writeln(
        '${_escape(p.id)},${_escape(p.name)},${p.quantity},${p.costPrice},${p.sellingPrice},${_escape(p.category)},${p.minStock}',
      );
    }
    return sb.toString();
  }

  static String salesToCsv(List<Sale> sales) {
    final sb = StringBuffer();
    sb.writeln(
      'id,product_id,quantity_sold,selling_price,sale_date,total_revenue',
    );
    for (final s in sales) {
      sb.writeln(
        '${_escape(s.id)},${_escape(s.productId)},${s.quantitySold},${s.sellingPrice},${s.saleDate.toIso8601String()},${s.totalRevenue}',
      );
    }
    return sb.toString();
  }

  /// Save CSV to a sensible directory and return the saved file path.
  static Future<String> saveCsvFile(String fileName, String csv) async {
    if (kIsWeb) {
      throw UnsupportedError(
        'CSV download on web is not implemented in this helper.',
      );
    }

    Directory dir;
    try {
      final downloads = await getDownloadsDirectory();
      dir = downloads ?? await getApplicationDocumentsDirectory();
    } catch (e) {
      dir = await getApplicationDocumentsDirectory();
    }

    final file = File('${dir.path}/$fileName');
    await file.writeAsString(csv);
    return file.path;
  }
}
