import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';

String toMoneyFormat(num number) {
  numberFormatSymbols['money'] = const NumberSymbols(
    NAME: "money",
    DECIMAL_SEP: ',',
    GROUP_SEP: '\u00A0',
    PERCENT: '%',
    ZERO_DIGIT: '0',
    PLUS_SIGN: '+',
    MINUS_SIGN: '-',
    EXP_SYMBOL: 'e',
    PERMILL: '\u2030',
    INFINITY: '\u221E',
    NAN: 'NaN',
    DECIMAL_PATTERN: '#,##0.###',
    SCIENTIFIC_PATTERN: '#E0',
    PERCENT_PATTERN: '#,##0%',
    CURRENCY_PATTERN: '#,##0.00',
    DEF_CURRENCY_CODE: 'RUB',
  );
  final f = NumberFormat.simpleCurrency(locale: 'money');
  return f.format(number / 100);
}
