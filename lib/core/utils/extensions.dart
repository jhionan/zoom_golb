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

extension StringEx on String {
  bool validEmail() {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return emailRegExp.hasMatch(this);
  }
}
