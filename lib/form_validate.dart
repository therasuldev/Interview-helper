class FormValidate {
  static String? emailFieldIsValidate(String? value) {
    if (value!.isEmpty) {
      return 'Email field is required.';
    } else {
      final emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
      if (!emailPattern.hasMatch(value)) {
        return 'Invalid email format.';
      }
    }
    return null;
  }

  static String? feedbackFieldIsValidate(String? value) {
    if (value!.isEmpty) {
      return 'Email field is required.';
    }
    return null;
  }
}
