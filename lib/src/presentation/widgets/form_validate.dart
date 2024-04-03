import 'package:easy_localization/easy_localization.dart';

class FormValidate {
  static String? emailFieldIsValidate(String? value) {
    if (value!.isEmpty) {
      return 'contactUs.emailRequired'.tr();
    } else {
      final emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
      if (!emailPattern.hasMatch(value)) {
        return 'contactUs.invalidEmailFormat'.tr();
      }
    }
    return null;
  }

  static String? feedbackFieldIsValidate(String? value) {
    if (value!.isEmpty) {
      return 'contactUs.feedbackRequired'.tr();
    }
    return null;
  }
}
