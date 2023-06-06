bool checkRequired(String? value) {
  return value != null && value.isNotEmpty && value != '';
}

bool checkCpfValid(String value) {
  String pattern = r"^(\d{3})(\.)?(\d{3})(\.)?(\d{3})([\-\/])?(\d{2})$";
  RegExp regExp = RegExp(pattern);

  return regExp.hasMatch(value);
}

bool checkCpfCnpjValid(String value) {
  String pattern =
      r"([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool checkExpirationDate(String value) {
  String pattern = r"^[0-9]{2}/[0-9]{2}$";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool checkEmailValid(String value) {
  String pattern =
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
  RegExp regExp = RegExp(pattern);

  return regExp.hasMatch(value);
}

bool checkPassWord(String value) {
  String pattern =
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool checkPassLowerCases(String value) {
  String pattern = r"(?=.*[a-z])[a-z]*";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool checkPassUpperCases(String value) {
  String pattern = r"(?=.*[A-Z])[A-Z]*";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool checkPassNumbers(String value) {
  String pattern = r"(?=.*\d)[\d]*";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool chekcDigit(String value) {
  String pattern = r"\d";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool checkPassSpecialChars(String value) {
  String pattern = r"(?=.*[@$!%*#?&])[@$!%*#?&]*";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool checkPassNumberOfChars(String value) {
  String pattern = r"[A-Za-z\d@$!%*#?&]{8,}";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool checkConfirmPassWord(String value, String pass) {
  return value == pass;
}

String? validateRequired(String? value, [bool serverError = false]) {
  if (serverError || value == null || value == '') {
    return "Campo obrigatório";
  }
  return null;
}

String? validateCpf(String? value, [bool serverError = false]) {
  if (serverError || value == null || value == '') {
    return "CPF incorreto";
  } else if (!checkCpfValid(value)) {
    return "CPF incorreto";
  }
  return null;
}

String? validateCpfCnpj(String? value, [bool serverError = false]) {
  if (serverError || value == null || value == '') {
    return "CPF ou CNPJ incorreto";
  } else if (!checkCpfCnpjValid(value)) {
    return "CPF ou CNPJ incorreto";
  }
  return null;
}

String? validateExpirationDate(String? value, [bool serverError = false]) {
  if (serverError || value == null || value == '') {
    return "Data de validade incorreta";
  } else if (!checkExpirationDate(value)) {
    return "Data de validade incorreta";
  }
  return null;
}

String? validateEmail(String? value, [bool serverError = false]) {
  if (serverError || value == null || value == '') {
    return "Email incorreto";
  } else if (!checkEmailValid(value)) {
    return "Email incorreto";
  }
  return null;
}

String? validatePassword(String? value, [bool serverError = false]) {
  if (serverError || value == null || value == '') {
    return "Senha incorreta";
  } else if (!checkPassWord(value)) {
    return "Senha incorreta";
  }
  return null;
}

String? validateDigit(String? value, [bool serverError = false]) {
  if (serverError || value == null || value == '') {
    return "";
  } else if (!chekcDigit(value)) {
    return "";
  }
  return null;
}

String? confirmPassword(String? value, String pass,
    [bool serverError = false]) {
  if (serverError || value == null || value == '') {
    return "Senha incorreta";
  } else if (!checkConfirmPassWord(value, pass)) {
    return "Senha incorreta";
  }
  return null;
}
