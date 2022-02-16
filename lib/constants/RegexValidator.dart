String? usernameValidator(value) {
  if (value.isEmpty) {
    return "Please Enter Text";
  }
}

String? passwordValidator(value) {

  if (value.isEmpty) {
    return 'Please Enter Text';
  } else if (value.length <= 7) {
    return 'Password Must Be Atleast 8 Characters Long';
  }
}

String? emailChecker(value) {
  String pattern = r'.+@.+[.].+';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    return 'Please Enter Text';
  } else if (!regex.hasMatch(value)) {
    return "Please Enter A Valid Email";
  }
}