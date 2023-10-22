import 'package:easy_localization/easy_localization.dart';

final currencyFormat = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp',
  decimalDigits: 0,
);

final currencyWithoutSymbolFormat = NumberFormat.currency(
  locale: 'id_ID',
  symbol: '',
  decimalDigits: 0,
);

final dateTimeFormat = DateFormat('dd/MM/yyyy, HH:mm');
final dateFormat = DateFormat('dd/MM/yyyy');
