import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Free Lancer'**
  String get appName;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @contentLoginPage.
  ///
  /// In en, this message translates to:
  /// **'We\'\'re excited to have you back, we can\'\'t wait to see what you\'\'ve been up to since you last logged in.'**
  String get contentLoginPage;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @orSignInWith.
  ///
  /// In en, this message translates to:
  /// **'Or Sign in with'**
  String get orSignInWith;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @contentRegisterPage.
  ///
  /// In en, this message translates to:
  /// **'Register now and start exploring all that our app has to offer. We\'\'re excited to welcome you to our community!'**
  String get contentRegisterPage;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'By signing up, you agree to our Terms and Privacy Policy.'**
  String get privacy;

  /// No description provided for @haveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign In'**
  String get haveAnAccount;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @donthaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'\'t have an account?'**
  String get donthaveAnAccount;

  /// No description provided for @allreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get allreadyHaveAccount;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @contentPassword.
  ///
  /// In en, this message translates to:
  /// **'Please take a few minutes to fill out your profile with as much detail as possible.'**
  String get contentPassword;

  /// No description provided for @emailOrPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone Number'**
  String get emailOrPhoneNumber;

  /// No description provided for @titleApp.
  ///
  /// In en, this message translates to:
  /// **'Ehsan App'**
  String get titleApp;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @lang.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get lang;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @helper.
  ///
  /// In en, this message translates to:
  /// **'Helper'**
  String get helper;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get info;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'LogOut'**
  String get logOut;

  /// No description provided for @areUsure.
  ///
  /// In en, this message translates to:
  /// **'Are you Sure?'**
  String get areUsure;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ayat.
  ///
  /// In en, this message translates to:
  /// **'Ayat'**
  String get ayat;

  /// No description provided for @searchOfVerse.
  ///
  /// In en, this message translates to:
  /// **'Search by Verse'**
  String get searchOfVerse;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @listen.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get listen;

  /// No description provided for @listToQuran.
  ///
  /// In en, this message translates to:
  /// **'Listen to the holy Quran'**
  String get listToQuran;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'The Popular'**
  String get popular;

  /// No description provided for @volume.
  ///
  /// In en, this message translates to:
  /// **'Volume Level'**
  String get volume;

  /// No description provided for @speed.
  ///
  /// In en, this message translates to:
  /// **'Speed Level'**
  String get speed;

  /// No description provided for @addCustomZekr.
  ///
  /// In en, this message translates to:
  /// **'Add Custom Zekr'**
  String get addCustomZekr;

  /// No description provided for @enterCustomZekr.
  ///
  /// In en, this message translates to:
  /// **'Enter your custom zekr'**
  String get enterCustomZekr;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @editCustomZekr.
  ///
  /// In en, this message translates to:
  /// **'Edit Custom Zekr'**
  String get editCustomZekr;

  /// No description provided for @deleteCustomZekr.
  ///
  /// In en, this message translates to:
  /// **'Delete Custom Zekr'**
  String get deleteCustomZekr;

  /// No description provided for @deleteCustomZekrConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this custom zekr?'**
  String get deleteCustomZekrConfirm;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @holyQuran.
  ///
  /// In en, this message translates to:
  /// **'The Holy Quran'**
  String get holyQuran;

  /// No description provided for @tfsir.
  ///
  /// In en, this message translates to:
  /// **'Explanation'**
  String get tfsir;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @sunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunrise;

  /// No description provided for @dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// No description provided for @howOfen.
  ///
  /// In en, this message translates to:
  /// **'How Often'**
  String get howOfen;

  /// No description provided for @sebha.
  ///
  /// In en, this message translates to:
  /// **'Sebha'**
  String get sebha;

  /// No description provided for @azkar.
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get azkar;

  /// No description provided for @doaa.
  ///
  /// In en, this message translates to:
  /// **'God Names'**
  String get doaa;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get about;

  /// No description provided for @nameOsama.
  ///
  /// In en, this message translates to:
  /// **'Osama Nabil'**
  String get nameOsama;

  /// No description provided for @jobTitleOsama.
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer'**
  String get jobTitleOsama;

  /// No description provided for @descriptionOsama.
  ///
  /// In en, this message translates to:
  /// **'This text is an example of text that can be replaced in the same space. This text was generated from the Arabic text generator, where you can generate such text or many other texts in addition to increasing the number of letters that the application generates.'**
  String get descriptionOsama;

  /// No description provided for @nameBilal.
  ///
  /// In en, this message translates to:
  /// **'Bilal Reda'**
  String get nameBilal;

  /// No description provided for @jobTitleBilal.
  ///
  /// In en, this message translates to:
  /// **'Ui / Ux Designer'**
  String get jobTitleBilal;

  /// No description provided for @descriptionBilal.
  ///
  /// In en, this message translates to:
  /// **'This text is an example of text that can be replaced in the same space. This text was generated from the Arabic text generator, where you can generate such text or many other texts in addition to increasing the number of letters that the application generates.'**
  String get descriptionBilal;

  /// No description provided for @prayerTimes.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTimes;

  /// No description provided for @nextPrayer.
  ///
  /// In en, this message translates to:
  /// **'Next prayer'**
  String get nextPrayer;

  /// No description provided for @timeRemaining.
  ///
  /// In en, this message translates to:
  /// **'Time remaining'**
  String get timeRemaining;

  /// No description provided for @prayerPassed.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get prayerPassed;

  /// No description provided for @currentPrayerPeriod.
  ///
  /// In en, this message translates to:
  /// **'After {name} prayer'**
  String currentPrayerPeriod(Object name);

  /// No description provided for @chooseZekr.
  ///
  /// In en, this message translates to:
  /// **'Choose the mention that you want'**
  String get chooseZekr;

  /// No description provided for @plzEnterSomeText.
  ///
  /// In en, this message translates to:
  /// **'Please enter some text'**
  String get plzEnterSomeText;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @books.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get books;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @checkInternet.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection!'**
  String get checkInternet;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again.'**
  String get tryAgain;

  /// No description provided for @fontsize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontsize;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// No description provided for @ahadeth.
  ///
  /// In en, this message translates to:
  /// **'Ahadeth'**
  String get ahadeth;

  /// No description provided for @ad3ya.
  ///
  /// In en, this message translates to:
  /// **'Ad3ya'**
  String get ad3ya;

  /// No description provided for @hajj.
  ///
  /// In en, this message translates to:
  /// **'Hajj & Umrah'**
  String get hajj;

  /// No description provided for @seerah.
  ///
  /// In en, this message translates to:
  /// **'Prophetic Biography'**
  String get seerah;

  /// No description provided for @ramadan.
  ///
  /// In en, this message translates to:
  /// **'Ramadan'**
  String get ramadan;

  /// No description provided for @ahadith.
  ///
  /// In en, this message translates to:
  /// **'Ahadith'**
  String get ahadith;

  /// No description provided for @asmaaAllahTitle.
  ///
  /// In en, this message translates to:
  /// **'Beautiful Names of Allah'**
  String get asmaaAllahTitle;

  /// No description provided for @zekrTapHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to count'**
  String get zekrTapHint;

  /// No description provided for @zekrCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get zekrCompleted;

  /// No description provided for @zekrInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get zekrInProgress;

  /// No description provided for @zekrNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get zekrNotStarted;

  /// No description provided for @zekrRepeatCount.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String zekrRepeatCount(int current, int total);

  /// No description provided for @zekrSequence.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String zekrSequence(int current, int total);

  /// No description provided for @zekrCompletedSummary.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} completed'**
  String zekrCompletedSummary(int done, int total);

  /// No description provided for @elements.
  ///
  /// In en, this message translates to:
  /// **'elements'**
  String get elements;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @youtubeTitle.
  ///
  /// In en, this message translates to:
  /// **'Religious Videos'**
  String get youtubeTitle;

  /// No description provided for @youtubePoweredBy.
  ///
  /// In en, this message translates to:
  /// **'Powered by YouTube — content from public channels'**
  String get youtubePoweredBy;

  /// No description provided for @youtubeNoVideos.
  ///
  /// In en, this message translates to:
  /// **'No videos available right now'**
  String get youtubeNoVideos;

  /// No description provided for @youtubeOpenExternal.
  ///
  /// In en, this message translates to:
  /// **'Open in YouTube'**
  String get youtubeOpenExternal;

  /// No description provided for @youtubeTapToPlay.
  ///
  /// In en, this message translates to:
  /// **'Tap to play in app'**
  String get youtubeTapToPlay;

  /// No description provided for @youtubePlayInApp.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get youtubePlayInApp;

  /// No description provided for @youtubePlayerFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load the player. Try opening in YouTube or use a real device'**
  String get youtubePlayerFailed;
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
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
