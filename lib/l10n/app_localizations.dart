import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('ja'),
    Locale('pt')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'SambApp'**
  String get appTitle;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorMessage;

  /// No description provided for @errorLoadingImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data'**
  String get errorLoadingImage;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @resetFilters.
  ///
  /// In en, this message translates to:
  /// **'Reset Filters'**
  String get resetFilters;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @portuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get portuguese;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @japanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get japanese;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

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

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @themeTrueBlack.
  ///
  /// In en, this message translates to:
  /// **'True Black'**
  String get themeTrueBlack;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get lightTheme;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System Theme'**
  String get systemTheme;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @instrumentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Instruments'**
  String get instrumentsTitle;

  /// No description provided for @instrumentDetails.
  ///
  /// In en, this message translates to:
  /// **'Instruments Details'**
  String get instrumentDetails;

  /// No description provided for @instrumentDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get instrumentDescription;

  /// No description provided for @instrumentLearning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get instrumentLearning;

  /// No description provided for @instrumentGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get instrumentGallery;

  /// No description provided for @paradesTitle.
  ///
  /// In en, this message translates to:
  /// **'Parades'**
  String get paradesTitle;

  /// No description provided for @schoolsTitle.
  ///
  /// In en, this message translates to:
  /// **'Schools'**
  String get schoolsTitle;

  /// No description provided for @schoolFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get schoolFavorites;

  /// No description provided for @schoolSymbols.
  ///
  /// In en, this message translates to:
  /// **'Symbols'**
  String get schoolSymbols;

  /// No description provided for @schoolFoundation.
  ///
  /// In en, this message translates to:
  /// **'Foundation'**
  String get schoolFoundation;

  /// No description provided for @schoolFoundationDate.
  ///
  /// In en, this message translates to:
  /// **'Foundation Date'**
  String get schoolFoundationDate;

  /// No description provided for @schoolColors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get schoolColors;

  /// No description provided for @schoolGodmother.
  ///
  /// In en, this message translates to:
  /// **'Godmother'**
  String get schoolGodmother;

  /// No description provided for @schoolLeague.
  ///
  /// In en, this message translates to:
  /// **'League'**
  String get schoolLeague;

  /// No description provided for @schoolDivision.
  ///
  /// In en, this message translates to:
  /// **'Division'**
  String get schoolDivision;

  /// No description provided for @schoolSortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get schoolSortBy;

  /// No description provided for @schoolSortByName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get schoolSortByName;

  /// No description provided for @schoolSortByRanking.
  ///
  /// In en, this message translates to:
  /// **'Ranking'**
  String get schoolSortByRanking;

  /// No description provided for @schoolSortByFoundationDate.
  ///
  /// In en, this message translates to:
  /// **'Foundation Date'**
  String get schoolSortByFoundationDate;

  /// No description provided for @schoolSortByDivision.
  ///
  /// In en, this message translates to:
  /// **'Division'**
  String get schoolSortByDivision;

  /// No description provided for @shoolSortByFavorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get shoolSortByFavorite;

  /// No description provided for @schoolSortByLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get schoolSortByLocation;

  /// No description provided for @schoolSortByLastPerformance.
  ///
  /// In en, this message translates to:
  /// **'Last Performance'**
  String get schoolSortByLastPerformance;

  /// No description provided for @schoolDivisionSpecial.
  ///
  /// In en, this message translates to:
  /// **'Special'**
  String get schoolDivisionSpecial;

  /// No description provided for @schoolDivisionSpecialFullName.
  ///
  /// In en, this message translates to:
  /// **'Special Group'**
  String get schoolDivisionSpecialFullName;

  /// No description provided for @schoolDivisionGold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get schoolDivisionGold;

  /// No description provided for @schoolDivisionGoldFullName.
  ///
  /// In en, this message translates to:
  /// **'Gold Series'**
  String get schoolDivisionGoldFullName;

  /// No description provided for @schoolDivisionSilver.
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get schoolDivisionSilver;

  /// No description provided for @schoolDivisionSilverFullName.
  ///
  /// In en, this message translates to:
  /// **'Silver Series'**
  String get schoolDivisionSilverFullName;

  /// No description provided for @schoolDivisionBronze.
  ///
  /// In en, this message translates to:
  /// **'Bronze'**
  String get schoolDivisionBronze;

  /// No description provided for @schoolDivisionBronzeFullName.
  ///
  /// In en, this message translates to:
  /// **'Bronze Series'**
  String get schoolDivisionBronzeFullName;

  /// No description provided for @schoolDivisionEvaluation.
  ///
  /// In en, this message translates to:
  /// **'Evaluation'**
  String get schoolDivisionEvaluation;

  /// No description provided for @schoolDivisionEvaluationFullName.
  ///
  /// In en, this message translates to:
  /// **'Evaluation Group'**
  String get schoolDivisionEvaluationFullName;

  /// No description provided for @schoolDivisionChildren.
  ///
  /// In en, this message translates to:
  /// **'Children'**
  String get schoolDivisionChildren;

  /// No description provided for @schoolDivisionChildrenFullName.
  ///
  /// In en, this message translates to:
  /// **'Children'**
  String get schoolDivisionChildrenFullName;

  /// No description provided for @schoolLeagueLiesa.
  ///
  /// In en, this message translates to:
  /// **'Liesa'**
  String get schoolLeagueLiesa;

  /// No description provided for @schoolLeagueLiesaFullName.
  ///
  /// In en, this message translates to:
  /// **'Liga Independente das Escolas de Samba'**
  String get schoolLeagueLiesaFullName;

  /// No description provided for @schoolLeagueLigarj.
  ///
  /// In en, this message translates to:
  /// **'Liga RJ'**
  String get schoolLeagueLigarj;

  /// No description provided for @schoolLeagueLigarjFullName.
  ///
  /// In en, this message translates to:
  /// **'Liga das Escolas de Samba do Rio de Janeiro'**
  String get schoolLeagueLigarjFullName;

  /// No description provided for @schoolLeagueSuperliga.
  ///
  /// In en, this message translates to:
  /// **'Superliga'**
  String get schoolLeagueSuperliga;

  /// No description provided for @schoolLeagueSuperligaFullName.
  ///
  /// In en, this message translates to:
  /// **'Superliga das Escolas de Samba do Rio de Janeiro'**
  String get schoolLeagueSuperligaFullName;

  /// No description provided for @schoolLeagueAcas.
  ///
  /// In en, this message translates to:
  /// **'acas'**
  String get schoolLeagueAcas;

  /// No description provided for @schoolLeagueAcasFullName.
  ///
  /// In en, this message translates to:
  /// **'Associação Cultural das Escolas de Samba'**
  String get schoolLeagueAcasFullName;

  /// No description provided for @schoolPerformancePlace.
  ///
  /// In en, this message translates to:
  /// **'place'**
  String get schoolPerformancePlace;

  /// No description provided for @schoolToParade.
  ///
  /// In en, this message translates to:
  /// **'to parade'**
  String get schoolToParade;

  /// No description provided for @schoolScore.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get schoolScore;

  /// No description provided for @schoolComponents.
  ///
  /// In en, this message translates to:
  /// **'Components'**
  String get schoolComponents;

  /// No description provided for @noMoreSchools.
  ///
  /// In en, this message translates to:
  /// **'There\'s no more schools 😔'**
  String get noMoreSchools;

  /// No description provided for @noFilteredSchools.
  ///
  /// In en, this message translates to:
  /// **'No schools found with these filters 😣'**
  String get noFilteredSchools;

  /// No description provided for @noFavoriteSchools.
  ///
  /// In en, this message translates to:
  /// **'No favorite schools 🥺'**
  String get noFavoriteSchools;

  /// No description provided for @noSchoolsFound.
  ///
  /// In en, this message translates to:
  /// **'No schools found 😢'**
  String get noSchoolsFound;

  /// No description provided for @schoolDivisionEnredoBloco1.
  ///
  /// In en, this message translates to:
  /// **'Enredo Blocos 1'**
  String get schoolDivisionEnredoBloco1;

  /// No description provided for @schoolDivisionEnredoBloco2.
  ///
  /// In en, this message translates to:
  /// **'Enredo Blocos 2'**
  String get schoolDivisionEnredoBloco2;

  /// No description provided for @schoolDivisionStreetBloco.
  ///
  /// In en, this message translates to:
  /// **'Street Blocos'**
  String get schoolDivisionStreetBloco;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @switchTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get switchTheme;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'ja', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'ja': return AppLocalizationsJa();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
