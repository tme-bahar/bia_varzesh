persianAndArabicToEnglish(String value) {
  var newValue = "";
  for (var i = 0; i < value.length; i++) {
    var ch = value.codeUnitAt(i);
    if (ch >= 1776 && ch <= 1785) // For Persian digits.
        {
      var newChar = ch - 1728;
      newValue = newValue + String.fromCharCode(newChar);
    }
    else
    if (ch >= 1632 && ch <= 1641) // For Arabic & Unix digits.
        {
      var newChar = ch - 1584;
      newValue = newValue + String.fromCharCode(newChar);
    }
    else
      newValue = newValue + String.fromCharCode(ch);
  }
  print(newValue);
  return newValue;
}

bool phoneNumberValidator(String value) {
  String pattern =
  "^(\u06F0|0|\u0660)(\u06F9|9|\u0669)([\u0660-\u0669\u06F0-\u06F90-9]{9})";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return false;
  else
    return true;
}

bool nationalCodeValidator(String value) {
  String pattern =
      "^([\u0660-\u0669\u06F0-\u06F90-9]{10})";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return false;
  else
    return true;
}

bool emailValidator(String value) {
  String pattern =
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return false;
  else
    return true;
}

bool postValidator(String value) {
  String pattern =
      "^([\u0660-\u0669\u06F0-\u06F90-9]{10})";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return false;
  else
    return true;
}

bool basicPriceValidator(String value) {
  String pattern =
      "^([\u0660-\u0669\u06F0-\u06F90-9]{1,10})";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return false;
  else
    return true;
}

bool priceValidator(String value) {
  String pattern =
      "([\u0660-\u0669\u06F0-\u06F90-9]+)";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return false;
  else
    return true;
}

