// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get about => 'About';

  @override
  String get aboutYourself => 'Tell us about yourself';

  @override
  String get accountNumber => 'Account Number';

  @override
  String get activeMatch => 'Active Match';

  @override
  String get actives => 'Actives';

  @override
  String get add => 'Add';

  @override
  String get addToken => 'Add Token';

  @override
  String get and => 'and';

  @override
  String get backToHome => 'Back to home';

  @override
  String get backToChat => 'Back to chat';

  @override
  String get balanceDescription =>
      'Here you will see the balance you earn from referrals with Base Time, which you can use to make Matches';

  @override
  String get balancePriceDescription => 'You currently have a balance of ';

  @override
  String get bank => 'Bank';

  @override
  String get calendar => 'Calendar';

  @override
  String get camera => 'Camera';

  @override
  String get cancel => 'Cancel';

  @override
  String get cancellationMeetAlert =>
      'Your Match has not wanted to continue with the meeting...we hope it will be another time';

  @override
  String get cardData => 'Card Data';

  @override
  String get categories => 'Categories';

  @override
  String get categoriesDescription =>
      'Select your tastes and the profiles you want to find';

  @override
  String get change => 'Change';

  @override
  String get changePhotoConfirm => 'Do you want to change this photo actually?';

  @override
  String get chat => 'Chat';

  @override
  String get checkingAccount => 'Checking Account';

  @override
  String get classifications => 'Classifications';

  @override
  String get completedMeetAlert =>
      'Your Match has ended, go back to the start and keep searching for new people!';

  @override
  String get completeProfile => 'Complete Profile';

  @override
  String confirmMatch(num hours, num amount) {
    final intl.NumberFormat amountNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String amountString = amountNumberFormat.format(amount);

    return 'You are about to match for ${hours}h of service for $amountString cop';
  }

  @override
  String get continueText => 'Continue';

  @override
  String copInFavor(num amount) {
    final intl.NumberFormat amountNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String amountString = amountNumberFormat.format(amount);

    return '\$$amountString cop in favor';
  }

  @override
  String get copyLink => 'Copy link';

  @override
  String get createAccount => 'Create Account';

  @override
  String get credit => 'Credit';

  @override
  String get creditCard => 'Credit Card';

  @override
  String get debitCard => 'Debit Card';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountAlert => 'Are you sure you want to delete account?';

  @override
  String deletedAccountAlert(String account) {
    return 'The account $account has been deleted.';
  }

  @override
  String get description => 'Description';

  @override
  String get discountCoupon => 'Discount Coupon';

  @override
  String get dniBackPhoto => 'Photo behind ID';

  @override
  String get dniFrontPhoto => 'Front photo of ID card';

  @override
  String get dniSelfie => 'Profile photo holding ID';

  @override
  String dollars(num amount) {
    final intl.NumberFormat amountNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String amountString = amountNumberFormat.format(amount);

    return '\$$amountString cop';
  }

  @override
  String dollarsXHour(num amount) {
    final intl.NumberFormat amountNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String amountString = amountNumberFormat.format(amount);

    return '\$$amountString cop x hour';
  }

  @override
  String get dollarsXHourHint => 'COP Per Hour';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get editToken => 'Edit Token';

  @override
  String get email => 'Email';

  @override
  String get emptyFeedMessage => 'For now there are no professionals near you.';

  @override
  String get emptyPaymentAccounts => 'You don\'\'t have payment accounts';

  @override
  String get emptyPaymentMethods => 'You don\'\'t have payment methods';

  @override
  String get emptyReferralsMessage => 'You have not registered referrals yet.';

  @override
  String get emptyTokens => 'You don\'t have tokens';

  @override
  String get emptyTokensMessanger => 'This user does not have profiles.';

  @override
  String get favorites => 'Favorites';

  @override
  String get filters => 'Filters';

  @override
  String get firstname => 'Firstname';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get gallery => 'Gallery';

  @override
  String get geoDescription =>
      'Select the kilometers around you want to search, or activate the global switch to search anywhere in the world';

  @override
  String get geolocation => 'Geolocation';

  @override
  String get globalSearch => 'Global search';

  @override
  String get hereYouWillSeePayments =>
      'Here you will see the balance you earn from referrals with Base Time, which you can use to make Matches';

  @override
  String get home => 'Home';

  @override
  String hours(num amount) {
    return '$amount hours';
  }

  @override
  String hoursMeet(num count) {
    return '$count hours meet';
  }

  @override
  String get iAgreeToHaveRead => 'I agree to have read the';

  @override
  String get id => 'ID';

  @override
  String get inactive => 'Inactive';

  @override
  String get invalidID =>
      'The ID you entered already exists in the system, please rectify that your data is correct and try again';

  @override
  String get invalidPromoterID =>
      'The promoter ID you entered does not exist, please rectify that the data is correct and try again';

  @override
  String get lastname => 'Lastname';

  @override
  String get majorYearsOld => 'I am over 21 years old';

  @override
  String get makePayment => 'Make payment';

  @override
  String get matches => 'Matches';

  @override
  String get matchHours => 'Match hours';

  @override
  String get meet => 'Meet';

  @override
  String get meets => 'Meets';

  @override
  String get meetTime => 'Meet time';

  @override
  String get myAccount => 'My Account';

  @override
  String get myPaymentAccounts => 'My Payment Accounts';

  @override
  String get myPaymentMethods => 'My Payment Methods';

  @override
  String get myReferrals => 'My Referrals';

  @override
  String get newPaymentAccount => 'New Payment Account';

  @override
  String get newPaymentMethod => 'New Payment Method';

  @override
  String get next => 'Next';

  @override
  String get no => 'No';

  @override
  String get notifications => 'Notifications';

  @override
  String get numberOfInstallments => 'Number of installments';

  @override
  String get optional => 'Optional';

  @override
  String get password => 'Password';

  @override
  String get password8length => 'Password must be at least 8 characters';

  @override
  String get passwordHasBeenChanged =>
      'The password has been changed correctly';

  @override
  String get passwordShouldNotPassword => 'Password should not \"password\"';

  @override
  String get passwordVerification =>
      'Your password verification must be the same as your password';

  @override
  String get paymentData => 'Payment Data';

  @override
  String get paymentMethod => 'Payment method';

  @override
  String get paymentRejected =>
      'We couldn\'\'t make your payment, try another method!';

  @override
  String get payments => 'Payments';

  @override
  String get paymentSuccess => 'Your payment has been made successfully!';

  @override
  String get paymentToStartMatch => 'Payment to start match';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get points => 'Points';

  @override
  String get policy =>
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consectetur id massa tincidunt fringilla. Etiam a nunc odio. Mauris nec euismod erat. Ut dignissim nunc a vulputate scelerisque. Nunc suscipit purus odio, tempus feugiat libero pellentesque et. Sed porttitor malesuada sapien, ut aliquam justo iaculis sed. Sed vulputate lacus eget faucibus ornare. Nam suscipit condimentum elementum.\n\nMauris rhoncus nulla ac risus euismod consequat. Fusce massa sapien, aliquam id suscipit ut, semper in nibh. Nulla mauris magna, ornare a ex non, luctus tincidunt nibh. Donec ornare augue ipsum, ac fermentum elit ullamcorper sit amet. Cras sit amet nibh ac lacus dictum laoreet et nec quam. Integer malesuada enim tortor, eget pellentesque sem bibendum non. Ut quis lectus augue. Quisque nec dui cursus, malesuada ipsum nec, tempus neque. Curabitur nisi augue, sodales quis arcu eget, tempor maximus sapien.\n\nMauris mi sapien, commodo semper felis non, congue blandit neque. Vestibulum condimentum magna a fermentum sagittis. Integer nisl magna, vestibulum at erat vel, rutrum ultricies erat. Maecenas faucibus velit eget libero rhoncus, a molestie lectus consectetur. Proin finibus erat ut pulvinar efficitur. Phasellus elementum lorem a erat porttitor gravida. Nullam id mauris eget tortor vestibulum congue vitae sed diam. Fusce eu magna dapibus, auctor ligula id, placerat nunc. Vivamus bibendum aliquet maximus. Aenean enim felis, tristique sed dui ac, laoreet faucibus arcu. Nullam id quam placerat ex venenatis vestibulum eget ut turpis. Nunc consequat, purus ut iaculis eleifend, metus nisl facilisis orci, vitae dignissim tortor quam id sem.\n\nPellentesque molestie suscipit lorem. Nulla facilisi. Donec a feugiat justo, ut placerat ex. Nunc at consequat libero. Aenean fringilla vestibulum nisi, in consequat nisi vestibulum in. Ut tempor convallis lorem. Donec mollis molestie faucibus. Aenean volutpat consequat lacus vehicula porttitor. Aenean id molestie felis, ac volutpat elit. Cras ut ex ac libero consequat dignissim.\n\nSed vestibulum vitae nisl nec aliquam. Sed varius iaculis commodo. Nam quam purus, elementum quis sem et, porttitor maximus lacus. Maecenas sem ex, tristique tristique maximus vel, auctor non magna. Nulla ut ex at tellus placerat aliquam eu eget orci. In semper a augue in congue. Mauris nulla erat, volutpat at iaculis ac, interdum non ipsum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.';

  @override
  String get privacyPolicies => 'privacy policies';

  @override
  String get promoterId => 'Promoter ID';

  @override
  String get redeemCoupon => 'Redeem coupon';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get savingAccount => 'Saving Account';

  @override
  String get search => 'Search';

  @override
  String get selectCategoryDescription =>
      'Select your categories\n(choose one or more options)';

  @override
  String get selectLang => 'Cambiar a Español';

  @override
  String get selectSubCategoryDescription =>
      'select your subcategories\n(choose one or more options)';

  @override
  String get selectYourPaymentMethod => 'Select your payment method';

  @override
  String get sendRecoveryPasswordAlertContent =>
      'We have sent you a link to your email to recover your password.';

  @override
  String get sendRecoveryPasswordCancelText => 'Go back';

  @override
  String get sendRecoveryPasswordConfirmText =>
      'Do you want to access your email?';

  @override
  String get signIn => 'Sign In';

  @override
  String get signInWithFacebook => 'Sign In with Facebook';

  @override
  String get signOut => 'Sign out';

  @override
  String get signOutAlert => 'Are you sure you want to log out?';

  @override
  String get signUpLater => 'Sign Up Later';

  @override
  String get skip => 'Skip';

  @override
  String get skipDisabled =>
      'Thrown if the user corresponding to the given email has been disabled.';

  @override
  String get subCategories => 'Sub Categories';

  @override
  String get sureOrderedNow => 'Are you sure to make your\nordered now?';

  @override
  String get terms =>
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consectetur id massa tincidunt fringilla. Etiam a nunc odio. Mauris nec euismod erat. Ut dignissim nunc a vulputate scelerisque. Nunc suscipit purus odio, tempus feugiat libero pellentesque et. Sed porttitor malesuada sapien, ut aliquam justo iaculis sed. Sed vulputate lacus eget faucibus ornare. Nam suscipit condimentum elementum.\n\nMauris rhoncus nulla ac risus euismod consequat. Fusce massa sapien, aliquam id suscipit ut, semper in nibh. Nulla mauris magna, ornare a ex non, luctus tincidunt nibh. Donec ornare augue ipsum, ac fermentum elit ullamcorper sit amet. Cras sit amet nibh ac lacus dictum laoreet et nec quam. Integer malesuada enim tortor, eget pellentesque sem bibendum non. Ut quis lectus augue. Quisque nec dui cursus, malesuada ipsum nec, tempus neque. Curabitur nisi augue, sodales quis arcu eget, tempor maximus sapien.\n\nMauris mi sapien, commodo semper felis non, congue blandit neque. Vestibulum condimentum magna a fermentum sagittis. Integer nisl magna, vestibulum at erat vel, rutrum ultricies erat. Maecenas faucibus velit eget libero rhoncus, a molestie lectus consectetur. Proin finibus erat ut pulvinar efficitur. Phasellus elementum lorem a erat porttitor gravida. Nullam id mauris eget tortor vestibulum congue vitae sed diam. Fusce eu magna dapibus, auctor ligula id, placerat nunc. Vivamus bibendum aliquet maximus. Aenean enim felis, tristique sed dui ac, laoreet faucibus arcu. Nullam id quam placerat ex venenatis vestibulum eget ut turpis. Nunc consequat, purus ut iaculis eleifend, metus nisl facilisis orci, vitae dignissim tortor quam id sem.\n\nPellentesque molestie suscipit lorem. Nulla facilisi. Donec a feugiat justo, ut placerat ex. Nunc at consequat libero. Aenean fringilla vestibulum nisi, in consequat nisi vestibulum in. Ut tempor convallis lorem. Donec mollis molestie faucibus. Aenean volutpat consequat lacus vehicula porttitor. Aenean id molestie felis, ac volutpat elit. Cras ut ex ac libero consequat dignissim.\n\nSed vestibulum vitae nisl nec aliquam. Sed varius iaculis commodo. Nam quam purus, elementum quis sem et, porttitor maximus lacus. Maecenas sem ex, tristique tristique maximus vel, auctor non magna. Nulla ut ex at tellus placerat aliquam eu eget orci. In semper a augue in congue. Mauris nulla erat, volutpat at iaculis ac, interdum non ipsum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.';

  @override
  String get termsAndConditions => 'terms and conditions';

  @override
  String get thisFieldIsRequired => 'This field is required!';

  @override
  String get thisSectionInConstruction => 'This section is in construction!';

  @override
  String get title => 'Title';

  @override
  String get titleName => 'Holder';

  @override
  String get titularName => 'Titular Name';

  @override
  String get total => 'Total';

  @override
  String get tryAgain => 'Try Again';

  @override
  String unavailableUsername(String username) {
    return 'The username $username is not available';
  }

  @override
  String get uploadDataSuccess => 'Your data has been sent successfully';

  @override
  String get uploadVerifyDataConfirm =>
      'Once you send the photos you will not be able to edit them';

  @override
  String get upToDate => 'You are already up to date';

  @override
  String get useBTP => 'Use BTP';

  @override
  String get userDisabled =>
      'Thrown if the user corresponding to the given email has been disabled';

  @override
  String get username => 'Username';

  @override
  String get validEmail => 'You must enter a valid email!';

  @override
  String get valueHour => 'value \$ hour';

  @override
  String get valueHourDescription => 'Select the price range you want to find';

  @override
  String get varifyAccountGuide =>
      'Then attach the following photos and that\'s it, that\'s it!';

  @override
  String get verifyAccount => 'Verify Account';

  @override
  String get verifyAccountDescription =>
      'In order to make a match you must verify your account first, this will take you a few minutes and in one simple step!';

  @override
  String get verifyAgentNotification =>
      'One of our agents will verify your account and in a moment you will be able to make your first Match!';

  @override
  String get verifyPassword => 'Verify Password';

  @override
  String get verifyYourAccount => 'Verify your Account';

  @override
  String get yes => 'Yes';

  @override
  String get addPaymentMethod => 'Add Payment Method';

  @override
  String get cardNumber => 'Number in the card';

  @override
  String get expirationDate => 'Expiration date';

  @override
  String get youHaveNoNotifications => 'You have no notifications';

  @override
  String get noResultsFound => 'No resuls found';

  @override
  String get skills => 'Skills';

  @override
  String get imageNotSelected => 'You must upload an image';

  @override
  String get categoriesNotSelected => 'You must select at least one category';

  @override
  String get forgotPasswordMessage =>
      'We will send you a recovery link to the following email.';

  @override
  String get emptySaved => 'You haven\'t saved anything yet';

  @override
  String get emptyMeets => 'You don\'t have any pending meets yet';

  @override
  String get emptyMatches => 'You don\'t have matches yet';

  @override
  String get emptyCards => 'This user doesn\'t have skills yet';

  @override
  String get youMustSelectAPaymentMethod => 'You must select a payment method';

  @override
  String get select => 'select';

  @override
  String get requiredLocation => 'Required Location';

  @override
  String get locationDeniedForever => 'Location permission denied permanently.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get qualify => 'Qualify';

  @override
  String get rateYourMatch =>
      'Rate your Match and leave a comment for others to see';

  @override
  String get comment => 'Comment';

  @override
  String get classification => 'Classification';

  @override
  String get finish => 'Finish';

  @override
  String get loading => 'Loading';

  @override
  String accountData(String accountType) {
    return '$accountType data';
  }

  @override
  String get selectABank => 'Select a bank';

  @override
  String get movements => 'Movements';

  @override
  String get notMovements => 'You have no movements yet';

  @override
  String get requestWithdrawal => 'Request withdrawal';

  @override
  String get tenMinutesToFinish => '10 minutes left to finish';
}
