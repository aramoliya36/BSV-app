class Utility {
  static String backIcon = 'assets/svg/back_icon.svg';
  static String appIcon = 'assets/svg/app_icon.svg';

  static String privacyPolicyLink = "";
  static String termsConditionsLink = "";
  static String refundPolicyLink = "";
  static String faqLink = "";
  static String helpLink = "";
  static int perPageSize = 15;
  static String isMultiFilter = "yes";

  static String emailAddressValidationPattern = r"([a-zA-Z0-9_@.])";
  static String password = r"[a-zA-Z0-9#!_@$%^&*-]";
  static String emailText = "email";
  static String addressText = "address";
  static String passwordText = "password";
  static String nameEmptyValidation = "Name is required";
  static String lastNameEmptyValidation = "Last Name is required";
  static String emailEmptyValidation = "Email is required";
  static String stateEmptyValidation = "state is required";
  static String pincodeEmptyValidation = "Pincode is required";
  static String cityEmptyValidation = "city is required";
  static String addressEmptyValidation = "Address is required";
  static String kUserNameEmptyValidation = 'Please Enter Valid Email';
  static String kPasswordEmptyValidation = 'Please Enter Password';
  static String kPasswordLengthValidation = 'Must be more than 6 Characters';
  static String kPasswordInValidValidation = 'Password Invalid';
  static String mobileNumberInValidValidation = "Mobile Number is required";
  static String alphabetValidationPattern = r"[a-zA-Z]";
  static String alphabetSpaceValidationPattern = r"[a-zA-Z ]";
  static String alphabetDigitsValidationPattern = r"[a-zA-Z0-9]";
  static String alphabetDigitsSpaceValidationPattern = r"[a-zA-Z0-9 ]";

  static String alphabetDigitsSpacePlusValidationPattern = r"[a-zA-Z0-9+ ]";

  static String alphabetDigitsSpecialValidationPattern = r"[a-zA-Z0-9#&$%_@. ]";

  static String alphabetDigitsDashValidationPattern = r"[a-zA-Z0-9- ]";
  static String addressValidationPattern = r"[a-zA-Z0-9-@#&*, ]";
  static String digitsValidationPattern = r"[0-9]";
  static String allSportPattern = r'^\[:\.\]$';

  static String passwordNotMatch =
      "Password and Conform password does not match!";
  static String termsConditions = "Terms & Conditions";
  static String termsConditionsMessage = "Please check Term Condition!";
  static String uploadingTitle = "Uploading Message";
  static String downloadingTitle = "Download Message";
  static String loginError = "Login Error";
  static String invalidPasswordMessage =
      "The password is invalid or the user does not have a password.";
  static String userNotExist = "User Not Exist!";

  static int kPasswordLength = 6;
}
