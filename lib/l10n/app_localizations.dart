import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutYourself.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get aboutYourself;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @activeMatch.
  ///
  /// In en, this message translates to:
  /// **'Active Match'**
  String get activeMatch;

  /// No description provided for @actives.
  ///
  /// In en, this message translates to:
  /// **'Actives'**
  String get actives;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @addToken.
  ///
  /// In en, this message translates to:
  /// **'Add Token'**
  String get addToken;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @backToChat.
  ///
  /// In en, this message translates to:
  /// **'Back to chat'**
  String get backToChat;

  /// No description provided for @balanceDescription.
  ///
  /// In en, this message translates to:
  /// **'Here you will see the balance you earn from referrals with Base Time, which you can use to make Matches'**
  String get balanceDescription;

  /// No description provided for @balancePriceDescription.
  ///
  /// In en, this message translates to:
  /// **'You currently have a balance of '**
  String get balancePriceDescription;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancellationMeetAlert.
  ///
  /// In en, this message translates to:
  /// **'Your Match has not wanted to continue with the meeting...we hope it will be another time'**
  String get cancellationMeetAlert;

  /// No description provided for @cardData.
  ///
  /// In en, this message translates to:
  /// **'Card Data'**
  String get cardData;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @categoriesDescription.
  ///
  /// In en, this message translates to:
  /// **'Select your tastes and the profiles you want to find'**
  String get categoriesDescription;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @changePhotoConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you want to change this photo actually?'**
  String get changePhotoConfirm;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @checkingAccount.
  ///
  /// In en, this message translates to:
  /// **'Checking Account'**
  String get checkingAccount;

  /// No description provided for @classifications.
  ///
  /// In en, this message translates to:
  /// **'Classifications'**
  String get classifications;

  /// No description provided for @completedMeetAlert.
  ///
  /// In en, this message translates to:
  /// **'Your Match has ended, go back to the start and keep searching for new people!'**
  String get completedMeetAlert;

  /// No description provided for @completeProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile'**
  String get completeProfile;

  /// No description provided for @confirmMatch.
  ///
  /// In en, this message translates to:
  /// **'You are about to match for {hours}h of service for {amount} cop'**
  String confirmMatch(num hours, num amount);

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @copInFavor.
  ///
  /// In en, this message translates to:
  /// **'\${amount} cop in favor'**
  String copInFavor(num amount);

  /// No description provided for @copyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get copyLink;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credit;

  /// No description provided for @creditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get creditCard;

  /// No description provided for @debitCard.
  ///
  /// In en, this message translates to:
  /// **'Debit Card'**
  String get debitCard;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountAlert.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete account?'**
  String get deleteAccountAlert;

  /// No description provided for @deletedAccountAlert.
  ///
  /// In en, this message translates to:
  /// **'The account {account} has been deleted.'**
  String deletedAccountAlert(String account);

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @discountCoupon.
  ///
  /// In en, this message translates to:
  /// **'Discount Coupon'**
  String get discountCoupon;

  /// No description provided for @dniBackPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo behind ID'**
  String get dniBackPhoto;

  /// No description provided for @dniFrontPhoto.
  ///
  /// In en, this message translates to:
  /// **'Front photo of ID card'**
  String get dniFrontPhoto;

  /// No description provided for @dniSelfie.
  ///
  /// In en, this message translates to:
  /// **'Profile photo holding ID'**
  String get dniSelfie;

  /// No description provided for @dollars.
  ///
  /// In en, this message translates to:
  /// **'\${amount} cop'**
  String dollars(num amount);

  /// No description provided for @dollarsXHour.
  ///
  /// In en, this message translates to:
  /// **'\${amount} cop x hour'**
  String dollarsXHour(num amount);

  /// No description provided for @dollarsXHourHint.
  ///
  /// In en, this message translates to:
  /// **'COP Per Hour'**
  String get dollarsXHourHint;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @editToken.
  ///
  /// In en, this message translates to:
  /// **'Edit Token'**
  String get editToken;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emptyFeedMessage.
  ///
  /// In en, this message translates to:
  /// **'For now there are no professionals near you.'**
  String get emptyFeedMessage;

  /// No description provided for @emptyPaymentAccounts.
  ///
  /// In en, this message translates to:
  /// **'You don\'\'t have payment accounts'**
  String get emptyPaymentAccounts;

  /// No description provided for @emptyPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'You don\'\'t have payment methods'**
  String get emptyPaymentMethods;

  /// No description provided for @emptyReferralsMessage.
  ///
  /// In en, this message translates to:
  /// **'You have not registered referrals yet.'**
  String get emptyReferralsMessage;

  /// No description provided for @emptyTokens.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have tokens'**
  String get emptyTokens;

  /// No description provided for @emptyTokensMessanger.
  ///
  /// In en, this message translates to:
  /// **'This user does not have profiles.'**
  String get emptyTokensMessanger;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @firstname.
  ///
  /// In en, this message translates to:
  /// **'Firstname'**
  String get firstname;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @geoDescription.
  ///
  /// In en, this message translates to:
  /// **'Select the kilometers around you want to search, or activate the global switch to search anywhere in the world'**
  String get geoDescription;

  /// No description provided for @geolocation.
  ///
  /// In en, this message translates to:
  /// **'Geolocation'**
  String get geolocation;

  /// No description provided for @globalSearch.
  ///
  /// In en, this message translates to:
  /// **'Global search'**
  String get globalSearch;

  /// No description provided for @hereYouWillSeePayments.
  ///
  /// In en, this message translates to:
  /// **'Here you will see the balance you earn from referrals with Base Time, which you can use to make Matches'**
  String get hereYouWillSeePayments;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'{amount} hours'**
  String hours(num amount);

  /// No description provided for @hoursMeet.
  ///
  /// In en, this message translates to:
  /// **'{count} hours meet'**
  String hoursMeet(num count);

  /// No description provided for @iAgreeToHaveRead.
  ///
  /// In en, this message translates to:
  /// **'I agree to have read the'**
  String get iAgreeToHaveRead;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @invalidID.
  ///
  /// In en, this message translates to:
  /// **'The ID you entered already exists in the system, please rectify that your data is correct and try again'**
  String get invalidID;

  /// No description provided for @invalidPromoterID.
  ///
  /// In en, this message translates to:
  /// **'The promoter ID you entered does not exist, please rectify that the data is correct and try again'**
  String get invalidPromoterID;

  /// No description provided for @lastname.
  ///
  /// In en, this message translates to:
  /// **'Lastname'**
  String get lastname;

  /// No description provided for @majorYearsOld.
  ///
  /// In en, this message translates to:
  /// **'I am over 21 years old'**
  String get majorYearsOld;

  /// No description provided for @makePayment.
  ///
  /// In en, this message translates to:
  /// **'Make payment'**
  String get makePayment;

  /// No description provided for @matches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

  /// No description provided for @matchHours.
  ///
  /// In en, this message translates to:
  /// **'Match hours'**
  String get matchHours;

  /// No description provided for @meet.
  ///
  /// In en, this message translates to:
  /// **'Meet'**
  String get meet;

  /// No description provided for @meets.
  ///
  /// In en, this message translates to:
  /// **'Meets'**
  String get meets;

  /// No description provided for @meetTime.
  ///
  /// In en, this message translates to:
  /// **'Meet time'**
  String get meetTime;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @myPaymentAccounts.
  ///
  /// In en, this message translates to:
  /// **'My Payment Accounts'**
  String get myPaymentAccounts;

  /// No description provided for @myPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'My Payment Methods'**
  String get myPaymentMethods;

  /// No description provided for @myReferrals.
  ///
  /// In en, this message translates to:
  /// **'My Referrals'**
  String get myReferrals;

  /// No description provided for @newPaymentAccount.
  ///
  /// In en, this message translates to:
  /// **'New Payment Account'**
  String get newPaymentAccount;

  /// No description provided for @newPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'New Payment Method'**
  String get newPaymentMethod;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @numberOfInstallments.
  ///
  /// In en, this message translates to:
  /// **'Number of installments'**
  String get numberOfInstallments;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @password8length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get password8length;

  /// No description provided for @passwordHasBeenChanged.
  ///
  /// In en, this message translates to:
  /// **'The password has been changed correctly'**
  String get passwordHasBeenChanged;

  /// No description provided for @passwordShouldNotPassword.
  ///
  /// In en, this message translates to:
  /// **'Password should not \"password\"'**
  String get passwordShouldNotPassword;

  /// No description provided for @passwordVerification.
  ///
  /// In en, this message translates to:
  /// **'Your password verification must be the same as your password'**
  String get passwordVerification;

  /// No description provided for @paymentData.
  ///
  /// In en, this message translates to:
  /// **'Payment Data'**
  String get paymentData;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @paymentRejected.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'\'t make your payment, try another method!'**
  String get paymentRejected;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @paymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your payment has been made successfully!'**
  String get paymentSuccess;

  /// No description provided for @paymentToStartMatch.
  ///
  /// In en, this message translates to:
  /// **'Payment to start match'**
  String get paymentToStartMatch;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @policy.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consectetur id massa tincidunt fringilla. Etiam a nunc odio. Mauris nec euismod erat. Ut dignissim nunc a vulputate scelerisque. Nunc suscipit purus odio, tempus feugiat libero pellentesque et. Sed porttitor malesuada sapien, ut aliquam justo iaculis sed. Sed vulputate lacus eget faucibus ornare. Nam suscipit condimentum elementum.\n\nMauris rhoncus nulla ac risus euismod consequat. Fusce massa sapien, aliquam id suscipit ut, semper in nibh. Nulla mauris magna, ornare a ex non, luctus tincidunt nibh. Donec ornare augue ipsum, ac fermentum elit ullamcorper sit amet. Cras sit amet nibh ac lacus dictum laoreet et nec quam. Integer malesuada enim tortor, eget pellentesque sem bibendum non. Ut quis lectus augue. Quisque nec dui cursus, malesuada ipsum nec, tempus neque. Curabitur nisi augue, sodales quis arcu eget, tempor maximus sapien.\n\nMauris mi sapien, commodo semper felis non, congue blandit neque. Vestibulum condimentum magna a fermentum sagittis. Integer nisl magna, vestibulum at erat vel, rutrum ultricies erat. Maecenas faucibus velit eget libero rhoncus, a molestie lectus consectetur. Proin finibus erat ut pulvinar efficitur. Phasellus elementum lorem a erat porttitor gravida. Nullam id mauris eget tortor vestibulum congue vitae sed diam. Fusce eu magna dapibus, auctor ligula id, placerat nunc. Vivamus bibendum aliquet maximus. Aenean enim felis, tristique sed dui ac, laoreet faucibus arcu. Nullam id quam placerat ex venenatis vestibulum eget ut turpis. Nunc consequat, purus ut iaculis eleifend, metus nisl facilisis orci, vitae dignissim tortor quam id sem.\n\nPellentesque molestie suscipit lorem. Nulla facilisi. Donec a feugiat justo, ut placerat ex. Nunc at consequat libero. Aenean fringilla vestibulum nisi, in consequat nisi vestibulum in. Ut tempor convallis lorem. Donec mollis molestie faucibus. Aenean volutpat consequat lacus vehicula porttitor. Aenean id molestie felis, ac volutpat elit. Cras ut ex ac libero consequat dignissim.\n\nSed vestibulum vitae nisl nec aliquam. Sed varius iaculis commodo. Nam quam purus, elementum quis sem et, porttitor maximus lacus. Maecenas sem ex, tristique tristique maximus vel, auctor non magna. Nulla ut ex at tellus placerat aliquam eu eget orci. In semper a augue in congue. Mauris nulla erat, volutpat at iaculis ac, interdum non ipsum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'**
  String get policy;

  /// No description provided for @privacyPolicies.
  ///
  /// In en, this message translates to:
  /// **'privacy policies'**
  String get privacyPolicies;

  /// No description provided for @promoterId.
  ///
  /// In en, this message translates to:
  /// **'Promoter ID'**
  String get promoterId;

  /// No description provided for @redeemCoupon.
  ///
  /// In en, this message translates to:
  /// **'Redeem coupon'**
  String get redeemCoupon;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @savingAccount.
  ///
  /// In en, this message translates to:
  /// **'Saving Account'**
  String get savingAccount;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @selectCategoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Select your categories\n(choose one or more options)'**
  String get selectCategoryDescription;

  /// No description provided for @selectLang.
  ///
  /// In en, this message translates to:
  /// **'Cambiar a Español'**
  String get selectLang;

  /// No description provided for @selectSubCategoryDescription.
  ///
  /// In en, this message translates to:
  /// **'select your subcategories\n(choose one or more options)'**
  String get selectSubCategoryDescription;

  /// No description provided for @selectYourPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Select your payment method'**
  String get selectYourPaymentMethod;

  /// No description provided for @sendRecoveryPasswordAlertContent.
  ///
  /// In en, this message translates to:
  /// **'We have sent you a link to your email to recover your password.'**
  String get sendRecoveryPasswordAlertContent;

  /// No description provided for @sendRecoveryPasswordCancelText.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get sendRecoveryPasswordCancelText;

  /// No description provided for @sendRecoveryPasswordConfirmText.
  ///
  /// In en, this message translates to:
  /// **'Do you want to access your email?'**
  String get sendRecoveryPasswordConfirmText;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signInWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Sign In with Facebook'**
  String get signInWithFacebook;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signOutAlert.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get signOutAlert;

  /// No description provided for @signUpLater.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Later'**
  String get signUpLater;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @skipDisabled.
  ///
  /// In en, this message translates to:
  /// **'Thrown if the user corresponding to the given email has been disabled.'**
  String get skipDisabled;

  /// No description provided for @subCategories.
  ///
  /// In en, this message translates to:
  /// **'Sub Categories'**
  String get subCategories;

  /// No description provided for @sureOrderedNow.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to make your\nordered now?'**
  String get sureOrderedNow;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consectetur id massa tincidunt fringilla. Etiam a nunc odio. Mauris nec euismod erat. Ut dignissim nunc a vulputate scelerisque. Nunc suscipit purus odio, tempus feugiat libero pellentesque et. Sed porttitor malesuada sapien, ut aliquam justo iaculis sed. Sed vulputate lacus eget faucibus ornare. Nam suscipit condimentum elementum.\n\nMauris rhoncus nulla ac risus euismod consequat. Fusce massa sapien, aliquam id suscipit ut, semper in nibh. Nulla mauris magna, ornare a ex non, luctus tincidunt nibh. Donec ornare augue ipsum, ac fermentum elit ullamcorper sit amet. Cras sit amet nibh ac lacus dictum laoreet et nec quam. Integer malesuada enim tortor, eget pellentesque sem bibendum non. Ut quis lectus augue. Quisque nec dui cursus, malesuada ipsum nec, tempus neque. Curabitur nisi augue, sodales quis arcu eget, tempor maximus sapien.\n\nMauris mi sapien, commodo semper felis non, congue blandit neque. Vestibulum condimentum magna a fermentum sagittis. Integer nisl magna, vestibulum at erat vel, rutrum ultricies erat. Maecenas faucibus velit eget libero rhoncus, a molestie lectus consectetur. Proin finibus erat ut pulvinar efficitur. Phasellus elementum lorem a erat porttitor gravida. Nullam id mauris eget tortor vestibulum congue vitae sed diam. Fusce eu magna dapibus, auctor ligula id, placerat nunc. Vivamus bibendum aliquet maximus. Aenean enim felis, tristique sed dui ac, laoreet faucibus arcu. Nullam id quam placerat ex venenatis vestibulum eget ut turpis. Nunc consequat, purus ut iaculis eleifend, metus nisl facilisis orci, vitae dignissim tortor quam id sem.\n\nPellentesque molestie suscipit lorem. Nulla facilisi. Donec a feugiat justo, ut placerat ex. Nunc at consequat libero. Aenean fringilla vestibulum nisi, in consequat nisi vestibulum in. Ut tempor convallis lorem. Donec mollis molestie faucibus. Aenean volutpat consequat lacus vehicula porttitor. Aenean id molestie felis, ac volutpat elit. Cras ut ex ac libero consequat dignissim.\n\nSed vestibulum vitae nisl nec aliquam. Sed varius iaculis commodo. Nam quam purus, elementum quis sem et, porttitor maximus lacus. Maecenas sem ex, tristique tristique maximus vel, auctor non magna. Nulla ut ex at tellus placerat aliquam eu eget orci. In semper a augue in congue. Mauris nulla erat, volutpat at iaculis ac, interdum non ipsum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'**
  String get terms;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'terms and conditions'**
  String get termsAndConditions;

  /// No description provided for @thisFieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required!'**
  String get thisFieldIsRequired;

  /// No description provided for @thisSectionInConstruction.
  ///
  /// In en, this message translates to:
  /// **'This section is in construction!'**
  String get thisSectionInConstruction;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @titleName.
  ///
  /// In en, this message translates to:
  /// **'Holder'**
  String get titleName;

  /// No description provided for @titularName.
  ///
  /// In en, this message translates to:
  /// **'Titular Name'**
  String get titularName;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @unavailableUsername.
  ///
  /// In en, this message translates to:
  /// **'The username {username} is not available'**
  String unavailableUsername(String username);

  /// No description provided for @uploadDataSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your data has been sent successfully'**
  String get uploadDataSuccess;

  /// No description provided for @uploadVerifyDataConfirm.
  ///
  /// In en, this message translates to:
  /// **'Once you send the photos you will not be able to edit them'**
  String get uploadVerifyDataConfirm;

  /// No description provided for @upToDate.
  ///
  /// In en, this message translates to:
  /// **'You are already up to date'**
  String get upToDate;

  /// No description provided for @useBTP.
  ///
  /// In en, this message translates to:
  /// **'Use BTP'**
  String get useBTP;

  /// No description provided for @userDisabled.
  ///
  /// In en, this message translates to:
  /// **'Thrown if the user corresponding to the given email has been disabled'**
  String get userDisabled;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @validEmail.
  ///
  /// In en, this message translates to:
  /// **'You must enter a valid email!'**
  String get validEmail;

  /// No description provided for @valueHour.
  ///
  /// In en, this message translates to:
  /// **'value \$ hour'**
  String get valueHour;

  /// No description provided for @valueHourDescription.
  ///
  /// In en, this message translates to:
  /// **'Select the price range you want to find'**
  String get valueHourDescription;

  /// No description provided for @varifyAccountGuide.
  ///
  /// In en, this message translates to:
  /// **'Then attach the following photos and that\'s it, that\'s it!'**
  String get varifyAccountGuide;

  /// No description provided for @verifyAccount.
  ///
  /// In en, this message translates to:
  /// **'Verify Account'**
  String get verifyAccount;

  /// No description provided for @verifyAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'In order to make a match you must verify your account first, this will take you a few minutes and in one simple step!'**
  String get verifyAccountDescription;

  /// No description provided for @verifyAgentNotification.
  ///
  /// In en, this message translates to:
  /// **'One of our agents will verify your account and in a moment you will be able to make your first Match!'**
  String get verifyAgentNotification;

  /// No description provided for @verifyPassword.
  ///
  /// In en, this message translates to:
  /// **'Verify Password'**
  String get verifyPassword;

  /// No description provided for @verifyYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Verify your Account'**
  String get verifyYourAccount;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @addPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Add Payment Method'**
  String get addPaymentMethod;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Number in the card'**
  String get cardNumber;

  /// No description provided for @expirationDate.
  ///
  /// In en, this message translates to:
  /// **'Expiration date'**
  String get expirationDate;

  /// No description provided for @youHaveNoNotifications.
  ///
  /// In en, this message translates to:
  /// **'You have no notifications'**
  String get youHaveNoNotifications;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No resuls found'**
  String get noResultsFound;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @imageNotSelected.
  ///
  /// In en, this message translates to:
  /// **'You must upload an image'**
  String get imageNotSelected;

  /// No description provided for @categoriesNotSelected.
  ///
  /// In en, this message translates to:
  /// **'You must select at least one category'**
  String get categoriesNotSelected;

  /// No description provided for @forgotPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'We will send you a recovery link to the following email.'**
  String get forgotPasswordMessage;

  /// No description provided for @emptySaved.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t saved anything yet'**
  String get emptySaved;

  /// No description provided for @emptyMeets.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any pending meets yet'**
  String get emptyMeets;

  /// No description provided for @emptyMatches.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have matches yet'**
  String get emptyMatches;

  /// No description provided for @emptyCards.
  ///
  /// In en, this message translates to:
  /// **'This user doesn\'t have skills yet'**
  String get emptyCards;

  /// No description provided for @youMustSelectAPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'You must select a payment method'**
  String get youMustSelectAPaymentMethod;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'select'**
  String get select;

  /// No description provided for @requiredLocation.
  ///
  /// In en, this message translates to:
  /// **'Required Location'**
  String get requiredLocation;

  /// No description provided for @locationDeniedForever.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied permanently.'**
  String get locationDeniedForever;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @qualify.
  ///
  /// In en, this message translates to:
  /// **'Qualify'**
  String get qualify;

  /// No description provided for @rateYourMatch.
  ///
  /// In en, this message translates to:
  /// **'Rate your Match and leave a comment for others to see'**
  String get rateYourMatch;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @classification.
  ///
  /// In en, this message translates to:
  /// **'Classification'**
  String get classification;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @accountData.
  ///
  /// In en, this message translates to:
  /// **'{accountType} data'**
  String accountData(String accountType);

  /// No description provided for @selectABank.
  ///
  /// In en, this message translates to:
  /// **'Select a bank'**
  String get selectABank;

  /// No description provided for @movements.
  ///
  /// In en, this message translates to:
  /// **'Movements'**
  String get movements;

  /// No description provided for @notMovements.
  ///
  /// In en, this message translates to:
  /// **'You have no movements yet'**
  String get notMovements;

  /// No description provided for @requestWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Request withdrawal'**
  String get requestWithdrawal;

  /// No description provided for @tenMinutesToFinish.
  ///
  /// In en, this message translates to:
  /// **'10 minutes left to finish'**
  String get tenMinutesToFinish;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
