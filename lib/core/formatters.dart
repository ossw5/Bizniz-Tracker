import 'package:intl/intl.dart';

final NumberFormat _phpFormat = NumberFormat.currency(
  locale: 'en_PH',
  symbol: '₱',
  decimalDigits: 2,
);

String formatCurrency(double value) => _phpFormat.format(value);
