// import 'package:date_format/date_format.dart';
// import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';

var doubleformat = NumberFormat("#,##0.00;-#,##0.00;0.00.", "en_US");
var intformat = NumberFormat("#,##0;-#,##0;0", "en_US");
var doubleFourDigitFormat = NumberFormat("#,###.####", "en_US");

dynamic DateTime(String dateTime) {
  dynamic date_time = DateFormat("yyyy-MM-DDTH:mm:ss").parse(dateTime);
  String dateFormat = DateFormat.yMd().add_jm().format(date_time);
  return dateFormat;
}
/* 
double roundDown(double value, int precision) {
  final isNegative = value.isNegative;
  final mod = pow(10.0, precision);
  final roundDown = (((value.abs() * mod).floor()) / mod);
  return isNegative ? -roundDown : roundDown;
}

String doubletoStr(dynamic value) {
  if (value is String) value = double.tryParse(value) ?? 0.0;
  return doubleformat.format(value);
}

double strtoDouble(String value) {
  try {
    if (value != null && value.contains(",")) {
      value = value.replaceAll(',', '.');
    }

    value ??= "0";
    var val = double.tryParse(value) ?? 0.0;
    return val;
  } catch (e) {
    return 0.0;
  }
}

String datetimeFromMis(value) {
  try {
    var date = DateTime.fromMillisecondsSinceEpoch(value);
    return datetoStr(date);
  } catch (e) {
    return "-";
  }
}

String dayFromMillisecond(value) {
  try {
    var data = DateTime.fromMillisecondsSinceEpoch(value);
    if (data is String) data = DateTime.parse(data.toString());
    return formatDate(data, [dd]);
  } catch (e) {
    return "";
  }
}

String monthFromMillisecond(value) {
  try {
    var data = DateTime.fromMillisecondsSinceEpoch(value);
    if (data is String) data = DateTime.parse(data.toString());
    return formatDate(data, [MM]);
  } catch (e) {
    return "";
  }
}

String convertTimeStampToDateTime(value) {
  try {
    var date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
    return datetoStr(date);
  } catch (e) {
    return "-";
  }
}

String inttoStr(dynamic value) {
  try {
    if (value is String) value = num.tryParse(value) ?? 0;
    return intformat.format(value);
  } catch (e) {
    return value;
  }
}

num strtoInt(String value) {
  try {
    var val = num.tryParse(value) ?? 0;
    return val;
  } catch (e) {
    return 0;
  }
}

String datetoStr(dynamic value) {
  try {
    if (value is String) value = DateTime.parse(value);
    return formatDate(value, [dd, '-', mm, '-', yyyy]);
  } catch (e) {
    return "-";
  }
}

String dateFiltertoStr(dynamic value) {
  try {
    if (value is String) value = DateTime.parse(value);
    return formatDate(value, [mm, '/', dd, '/', yyyy]);
  } catch (e) {
    return "-";
  }
}

String fulllDateFiltertoStr(dynamic value) {
  try {
    if (value is String) value = DateTime.parse(value);
    return formatDate(value, [mm, '/', dd, '/', yyyy]);
  } catch (e) {
    return "-";
  }
}

String datetoFXStr(dynamic value) {
  try {
    if (value is String) value = DateTime.parse(value);
    return formatDate(value, [yyyy, '-', mm, '-', dd]);
  } catch (e) {
    return "-";
  }
}

String datetimetoStr(dynamic value) {
  if (value is String) value = DateTime.parse(value).toLocal();
  try {
    return formatDate(
      value,
      [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am],
    );
  } catch (e) {
    return "-";
  }
}

String datetimetoStr2(dynamic value) {
  if (value is String) value = DateTime.parse(value).toLocal();
  try {
    return formatDate(
      value,
      [yyyy, '-', mm, '-', dd, 'T', hh, ':', nn, ':', ss],
    );
  } catch (e) {
    return "-";
  }
}

DateTime strtoDateTime(dynamic value) {
  if (value != null) {
    return DateTime.parse(value).toLocal();
  } else {
    return value;
  }
}

DateTime strtoDate(String value) {
  return DateTime.tryParse(value);
}

strtoFormatDateTime(String value) {
  return DateFormat("MM/dd/yyyy").parse(value);
}

String formatDateTime(int myvalue) {
  try {
    final df = DateFormat('dd-MM-yyyy hh:mm a');
    return df.format(DateTime.fromMillisecondsSinceEpoch(myvalue));
  } catch (e) {
    return myvalue.toString();
  }
}

String formaTimeAMPM(int myvalue) {
  try {
    final df = DateFormat('hh:mm a');
    return df.format(DateTime.fromMillisecondsSinceEpoch(myvalue));
  } catch (e) {
    return "";
  }
}

String formatEcommerceDate(String v) {
  try {
    var date = DateFormat('dd/MM/yyyy').parse(v);
    return datetimetoStr(date);
  } catch (e) {
    return v;
  }
}

bool strtoBool(String val) {
  try {
    return val.toLowerCase() == 'true';
  } catch (e) {
    return false;
  }
}

String enumTostr(value) {
  return describeEnum(value);
}

String distanceFormatter(value) {
  NumberFormat df = NumberFormat("#,###.##");
  var newString = df.format(value);
  return newString;
}

String currencyFormatter(value) {
  if (value is Double) {
    value = value.toStringAsFixed(2);
  } else if (value is String) {
    value = strtoDouble(value).toStringAsFixed(2);
  } else {
    value = value?.toStringAsFixed(2);
  }
  return toCurrencyString(
    value.toString(),
    mantissaLength: 2,
    leadingSymbol: MoneySymbols.DOLLAR_SIGN,
  ); //
}

String khmerCurrency(value) {
  return toCurrencyString(
    value.toString(),
    mantissaLength: 2,
  ); //
}

// ignore: missing_return
String phoeMask(String text) {
  try {
    if (text.length > 10) {
      var formatter = StringMask('+000 00 000 000');
      if (text.length == 12) {
        formatter = StringMask('+000 00 000 0000');
      }
      if (text.length == 13) {
        formatter = StringMask('+000 00 0000 0000');
      }

      String restult = formatter.apply(text);
      return restult ?? "########";
    } else {
      if (text.length == 10) {
        var formatter = StringMask('000 000 0000');
        String restult = formatter.apply(text);
        return restult ?? text;
      }
      if (text.length == 9) {
        var formatter = StringMask('000 000 000');
        String restult = formatter.apply(text);
        return restult ?? text;
      }
      if (text.length < 9) {
        return text.isEmpty && text.isEmpty ? '-' : text;
      }
    }
  } catch (e) {
    return '-';
  }
}

String currencyFormatter0(value) {
  return toCurrencyString(
    value.toString(),
    leadingSymbol: MoneySymbols.DOLLAR_SIGN,
  ); //
}

String datetimewithzonetoStr(dynamic value) {
  if (value is String) value = DateTime.parse(value).toLocal();
  try {
    return formatDate(
      value,
      [yyyy, '-', mm, '-', dd, 'T', hh, ':', nn, ':', ss, z],
    );
  } catch (e) {
    return "-";
  }
}

String toTimeZone(value) {
  try {
    return formatDate(
      value,
      [yyyy, '-', mm, '-', dd, 'T', HH, ':', nn, ':', ss, z],
    );
  } catch (e) {
    return "-";
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight = newValue.text.length - 10;
      final f = NumberFormat("#,###");
      int num = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(num);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}

String readTimestamp(int timestamp) {
  try {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = date.difference(now);
    var time = '';
    //var format = DateFormat.yMMMd().format(date);
    var format = DateFormat.Hm().format(date);
    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format; // Doesn't get called when it should be
    } else {
      time =
          diff.inDays.toString() + 'DAYS AGO'; // Gets call and it's wrong date
    }

    return time ?? '-';
  } catch (e) {
    return '-';
  }
}

String phoneNumberValidator(String value) {
  value = value.replaceAll(' ', '');
  Pattern pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  RegExp regex = RegExp(pattern);
  if (value.length == 4) {
    return StringUtil.phoneEmpty;
  }
  if (value.length < 9) {
    return 'Phone number is to short';
  }
  if (value.length > 15) {
    return 'Phone number is to long';
  }
  if (!regex.hasMatch(value)) {
    return 'Enter Valid Phone Number';
  } else {
    return null;
  }
}

Color colorFromHex(String stringColor) {
  try {
    var hex = stringColor
        .replaceAll('Color(', '')
        .replaceAll(')', '')
        .replaceAll('0x', '');

    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException("Invalid hexadecimal value");
      }
    }
    return Color(val);
  } catch (e) {
    return Colors.transparent;
  }
}

String validateStringRequired(value) {
  if (value.length == 0) {
    return StringUtil.valueIsrequired;
  } else {
    return '';
  }
}
*/
