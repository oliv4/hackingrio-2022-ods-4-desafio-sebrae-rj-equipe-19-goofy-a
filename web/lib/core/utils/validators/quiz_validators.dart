import 'package:validators/validators.dart' as validators;

bool isEmail(String str) {
  return validators.isEmail(str);
}

bool isPassword(String str) {
  return validators.isLength(str, 2);
}

bool isNotEmpty(String str) {
  return !(str == '');
}

bool noValidate(String str) {
  return true;
}

bool isNullOrEmpty(String str) {
  if (validators.isNull(str)) {
    return true;
  }

  if (str == '') {
    return true;
  }

  return false;
}