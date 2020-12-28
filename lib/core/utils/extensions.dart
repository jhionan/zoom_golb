import 'package:intl/intl.dart';

extension DateTimeEx on DateTime {
  String toBrazilian() {
    try {
      DateFormat _dateFormat = DateFormat('dd/MM/yy HH:mm');
      return _dateFormat.format(this.toLocal());
    } catch (e) {
      return '';
    }
  }
}
