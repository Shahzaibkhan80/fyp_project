import '../../constant/appStrings/app_string.dart';

class Validators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Appstrings.vEnterName;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Appstrings.vEmailRequired;
    }

    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return Appstrings.validEmail;
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Appstrings.passwordRequired;
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Check for uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for digit
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    // Check for special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? validateContact(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a contact number';
    }

    if (value.length != 11) {
      return 'Contact number must be 11 digits';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Enter a valid contact number';
    }

    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter age';
    }

    if (int.tryParse(value) == null || int.parse(value) <= 0) {
      return 'Enter a valid age';
    }

    return null;
  }

  static String? validateGender(String? gender) {
    if (gender == null || gender.isEmpty) {
      return Appstrings.genderSelect;
    }
    return null;
  }
}
