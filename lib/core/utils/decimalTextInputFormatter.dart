/*
* Got from: https://stackoverflow.com/a/57680550/4851073
* */

import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {

  DecimalTextInputFormatter({int decimalRange, bool signed})
      : assert(decimalRange == null || decimalRange >= 0,
  'DecimalTextInputFormatter declaretion error') {
    String dp = (decimalRange != null && decimalRange > 0) ? "([.][0-9]{0,$decimalRange}){0,1}" : "";
    String num = "[0-9]*$dp";

    if(signed) {
      _exp = new RegExp("^((((-){0,1})|((-){0,1}[0-9]$num))){0,1}\$");
    }
    else {
      _exp = new RegExp("^($num){0,1}\$");
    }
  }

  RegExp _exp;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if(_exp.hasMatch(newValue.text)){
      return newValue;
    }
    return oldValue;
  }
}