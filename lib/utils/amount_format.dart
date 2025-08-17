import 'package:intl/intl.dart';

String formatCurrency(num amount) {
  return NumberFormat.currency(
    locale: 'en_NG',
    symbol: '₦',
    decimalDigits: 2,
  ).format(amount);
}
