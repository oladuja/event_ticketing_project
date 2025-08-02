import 'package:intl/intl.dart';
 
 String formatDate(DateTime date) {
    return DateFormat.yMMMMEEEEd().add_jm().format(date);
  }