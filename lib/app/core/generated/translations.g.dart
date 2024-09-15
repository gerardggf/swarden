/// Generated file. Do not edit.
///
/// Original: lib/app/presentation/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 3
/// Strings: 168 (56 per locale)
///
/// Built on 2024-09-15 at 11:49 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	ca(languageCode: 'ca', build: _TranslationsCa.build),
	es(languageCode: 'es', build: _TranslationsEs.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of texts).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = texts.someKey.anotherKey;
/// String b = texts['someKey.anotherKey']; // Only for edge cases!
Translations get texts => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final texts = Translations.of(context); // Get texts variable.
/// String a = texts.someKey.anotherKey; // Use texts variable.
/// String b = texts['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.texts.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get texts => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final texts = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsAuthEn auth = _TranslationsAuthEn._(_root);
	late final _TranslationsGlobalEn global = _TranslationsGlobalEn._(_root);
}

// Path: auth
class _TranslationsAuthEn {
	_TranslationsAuthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get welcome => 'Welcome!';
	String get welcomeBack => 'Welcome back!';
	String get getStartedWith => 'Get started with';
	String get signInWith => 'Sign in with';
	String get orAccessWith => 'or access with';
	String get email => 'Email';
	String get forgotYourPassword => 'Forgot yout password?';
	String get needAnAccount => 'Need an account?';
	String get register => 'Register';
	String get signIn => 'Sign in';
	String get particular => 'particular';
	String get company => 'company';
	String get name => 'Name';
	String get lastName => 'Last name';
	String get address => 'Address';
	String get city => 'City';
	String get password => 'Password';
	String get repeatPassword => 'Repeat password';
	String get alreadyOnboard => 'Already onboard?';
	String get iHaveReadAndAgreeThe => 'I have read and agree the ';
	String get legalConditions => 'Legal conditions';
	String get andThe => 'and the';
	String get privacyPolicy => 'Privacy policy';
	String get receiveNewsAndPromos => 'Receive news and promotions';
	String get taxName => 'Tex name';
	String get cif => 'CIF';
	String get send => 'Send';
	String get loggedIn => 'Logged in';
	String get forgotMyPassword => 'Forgot my password';
	String get emailAlreadyExists => 'Email already exists';
	String get insufficientPermissions => 'Insufficient permissions';
	String get internalError => 'Internal error';
	String get invalidCredential => 'Invalid email or password';
	String get anErrorHasOccurred => 'An error has occurred';
	String get userDisabled => 'User disabled';
	String get userNotFound => 'User not found';
	String get wrongPassword => 'Wrong password';
	String get invalidEmail => 'Invalid email';
	String get operationNotAllowed => 'Operation not allowed';
	String get userAlreadyExists => 'User already exists';
	String get requiresRecentLogin => 'Requires recent login';
	String get invalidPassword => 'Invalid password';
	String get tooManyRequests => 'Too many requests';
	String get accountCreated => 'Account created';
	String get passwordIsTooWeak => 'The password must contain at least 6 characters, one uppercase and one lowercase letters.';
	String get theFieldCannotBeEmpty => 'The field cannot be empty';
	String get passwordsDoNotMatch => 'Passwords do not match';
	String get youMustAcceptThePrivacyPolicy => 'You must accept the privacy policy';
	String get emailSentSuccessfully => 'Email sent successfully. If it doesn\'t appear in your inbox, check your spam folder';
	String get youHaveLoggedOut => 'You have logged out';
	String get weWillSendYouAnEmailFromWhichYouCanChangeYourPassword => 'We will send you an email from which you can change your password';
	String get changePassword => 'Change password';
	String get logout => 'Logout';
}

// Path: global
class _TranslationsGlobalEn {
	_TranslationsGlobalEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get cancel => 'Cancel';
	String get confirm => 'Confirm';
	String get anErrorHasOccurred => 'An error has occurred';
}

// Path: <root>
class _TranslationsCa implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsCa.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ca,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ca>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _TranslationsCa _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAuthCa auth = _TranslationsAuthCa._(_root);
	@override late final _TranslationsGlobalCa global = _TranslationsGlobalCa._(_root);
}

// Path: auth
class _TranslationsAuthCa implements _TranslationsAuthEn {
	_TranslationsAuthCa._(this._root);

	@override final _TranslationsCa _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Benvingut/da!';
	@override String get welcomeBack => 'Benvingut/da de nou!';
	@override String get getStartedWith => 'Registrar-se';
	@override String get signInWith => 'Iniciar sessió amb';
	@override String get orAccessWith => 'o accedeix amb';
	@override String get email => 'Correu electrònic';
	@override String get forgotYourPassword => '¿Has oblidat la teva contrasenya?';
	@override String get needAnAccount => 'Necessites un compte?';
	@override String get register => 'Registrar-se';
	@override String get signIn => 'Iniciar sessió';
	@override String get particular => 'particular';
	@override String get company => 'companyia';
	@override String get name => 'Nom';
	@override String get lastName => 'Cognoms';
	@override String get address => 'Adreça';
	@override String get city => 'Ciutat';
	@override String get password => 'Contrasenya';
	@override String get repeatPassword => 'Repetir contrasenya';
	@override String get alreadyOnboard => 'Ja tens un compte?';
	@override String get iHaveReadAndAgreeThe => 'Ja he llegit i acceptat les ';
	@override String get legalConditions => 'Condicions legals';
	@override String get andThe => 'i la';
	@override String get privacyPolicy => 'Política de privacitat';
	@override String get receiveNewsAndPromos => 'Rebre noticies i promocions';
	@override String get taxName => 'Nom fiscal';
	@override String get cif => 'CIF';
	@override String get send => 'Enviar';
	@override String get loggedIn => 'Sessió iniciada';
	@override String get forgotMyPassword => 'He oblidat la meva contrasenya';
	@override String get emailAlreadyExists => 'El correu electrònic ja existeix';
	@override String get insufficientPermissions => 'Permisos insuficients';
	@override String get internalError => 'Error intern';
	@override String get invalidCredential => 'Correu electrònic o contrasenya incorrectes';
	@override String get anErrorHasOccurred => 'S\'ha produït un error';
	@override String get userDisabled => 'L\'usuari ha estat deshabilitat';
	@override String get userNotFound => 'No s\'ha trobat l\'usuari';
	@override String get wrongPassword => 'La contrasenya es incorrecta';
	@override String get invalidEmail => 'El correu electrònic no es vàlid';
	@override String get operationNotAllowed => 'Operació no permesa';
	@override String get userAlreadyExists => 'L\'usuari ja existeix';
	@override String get requiresRecentLogin => 'Es requereix tornar a iniciar sessió';
	@override String get invalidPassword => 'La contrasenya no es vàlida';
	@override String get tooManyRequests => 'Masses peticions';
	@override String get accountCreated => 'S\'ha creat el compte';
	@override String get passwordIsTooWeak => 'La contrasenya ha de contenir almenys 6 caràcters, una majúscula i una minúscula.';
	@override String get theFieldCannotBeEmpty => 'El camp no pot estar buit';
	@override String get passwordsDoNotMatch => 'Les contrasenyes no coincideixen';
	@override String get youMustAcceptThePrivacyPolicy => 'Has d\'acceptar la política de privacitat';
	@override String get emailSentSuccessfully => 'Correu electrònic enviat correctament. Si no t\'apareix a la safata d\'entrada, comprova la safata d\'Spam';
	@override String get youHaveLoggedOut => 'S\'ha tancat la sessió';
	@override String get weWillSendYouAnEmailFromWhichYouCanChangeYourPassword => 'T\'enviarem un correu electrònic perquè puguis canviar la teva contrasenya';
	@override String get changePassword => 'Canvia la contrasenya';
	@override String get logout => 'Tancar sessió';
}

// Path: global
class _TranslationsGlobalCa implements _TranslationsGlobalEn {
	_TranslationsGlobalCa._(this._root);

	@override final _TranslationsCa _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Cancel·lar';
	@override String get confirm => 'Confirmar';
	@override String get anErrorHasOccurred => 'S\'ha produït un error';
}

// Path: <root>
class _TranslationsEs implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEs.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _TranslationsEs _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAuthEs auth = _TranslationsAuthEs._(_root);
	@override late final _TranslationsGlobalEs global = _TranslationsGlobalEs._(_root);
}

// Path: auth
class _TranslationsAuthEs implements _TranslationsAuthEn {
	_TranslationsAuthEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get welcome => '¡Bienvenido/a!';
	@override String get welcomeBack => '¡Bienvenido/a de nuevo!';
	@override String get getStartedWith => 'Registrarse con';
	@override String get signInWith => 'Inicia sesión con';
	@override String get orAccessWith => 'o accede con';
	@override String get email => 'Correo electrónico';
	@override String get forgotYourPassword => '¿Olvidaste tu contraseña?';
	@override String get needAnAccount => '¿Necesitas una cuenta?';
	@override String get register => 'Registrarse';
	@override String get signIn => 'Iniciar sesión';
	@override String get particular => 'particular';
	@override String get company => 'compañía';
	@override String get name => 'Nombre';
	@override String get lastName => 'Apellidos';
	@override String get address => 'Dirección';
	@override String get city => 'Ciudad';
	@override String get password => 'Contraseña';
	@override String get repeatPassword => 'Repetir contraseña';
	@override String get alreadyOnboard => '¿Ya tienes una cuenta?';
	@override String get iHaveReadAndAgreeThe => 'Ya he leido y acepto las ';
	@override String get legalConditions => 'Condiciones legales';
	@override String get andThe => 'y la';
	@override String get privacyPolicy => 'Política de privacidad';
	@override String get receiveNewsAndPromos => 'Recibir notícias y promociones';
	@override String get taxName => 'Nombre fiscal';
	@override String get cif => 'CIF';
	@override String get send => 'Enviar';
	@override String get loggedIn => 'Sesión iniciada';
	@override String get forgotMyPassword => 'He olvidado mi contraseña';
	@override String get emailAlreadyExists => 'El correo electrónico ya existe';
	@override String get insufficientPermissions => 'Permisos insuficientes';
	@override String get internalError => 'Error interno';
	@override String get invalidCredential => 'Correo electrónico o contraseña incorrectas';
	@override String get anErrorHasOccurred => 'Se ha producido un error';
	@override String get userDisabled => 'El usuario ha sido deshabilitado';
	@override String get userNotFound => 'No se ha encontrado el usuario';
	@override String get wrongPassword => 'La contraseña es incorrecta';
	@override String get invalidEmail => 'El correo electrónico no es válido';
	@override String get operationNotAllowed => 'Operación no permitida';
	@override String get userAlreadyExists => 'El usuario ya existe';
	@override String get requiresRecentLogin => 'Se requiere iniciar sesión reciente';
	@override String get invalidPassword => 'La contraseña no es válida';
	@override String get tooManyRequests => 'Demasiadas peticiones';
	@override String get accountCreated => 'Cuenta creada';
	@override String get passwordIsTooWeak => 'La contraseña debe contener al menos 6 caracteres, una mayúscula y una minúscula.';
	@override String get theFieldCannotBeEmpty => 'El campo no puede estar vacío';
	@override String get passwordsDoNotMatch => 'Las contraseñas no coinciden';
	@override String get youMustAcceptThePrivacyPolicy => 'Debes aceptar la política de privacidad';
	@override String get emailSentSuccessfully => 'Email enviado correctamente. Si no aparece en tu bandeja de entrada, revisa tu carpeta de Spam';
	@override String get youHaveLoggedOut => 'Sesión cerrada';
	@override String get weWillSendYouAnEmailFromWhichYouCanChangeYourPassword => 'Te enviaremos un correo electrónico desde donde podras cambiar tu contraseña';
	@override String get changePassword => 'Cambia la contraseña';
	@override String get logout => 'Cerrar sesión';
}

// Path: global
class _TranslationsGlobalEs implements _TranslationsGlobalEn {
	_TranslationsGlobalEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Cancelar';
	@override String get confirm => 'Confirmar';
	@override String get anErrorHasOccurred => 'Se ha producido un error';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'auth.welcome': return 'Welcome!';
			case 'auth.welcomeBack': return 'Welcome back!';
			case 'auth.getStartedWith': return 'Get started with';
			case 'auth.signInWith': return 'Sign in with';
			case 'auth.orAccessWith': return 'or access with';
			case 'auth.email': return 'Email';
			case 'auth.forgotYourPassword': return 'Forgot yout password?';
			case 'auth.needAnAccount': return 'Need an account?';
			case 'auth.register': return 'Register';
			case 'auth.signIn': return 'Sign in';
			case 'auth.particular': return 'particular';
			case 'auth.company': return 'company';
			case 'auth.name': return 'Name';
			case 'auth.lastName': return 'Last name';
			case 'auth.address': return 'Address';
			case 'auth.city': return 'City';
			case 'auth.password': return 'Password';
			case 'auth.repeatPassword': return 'Repeat password';
			case 'auth.alreadyOnboard': return 'Already onboard?';
			case 'auth.iHaveReadAndAgreeThe': return 'I have read and agree the ';
			case 'auth.legalConditions': return 'Legal conditions';
			case 'auth.andThe': return 'and the';
			case 'auth.privacyPolicy': return 'Privacy policy';
			case 'auth.receiveNewsAndPromos': return 'Receive news and promotions';
			case 'auth.taxName': return 'Tex name';
			case 'auth.cif': return 'CIF';
			case 'auth.send': return 'Send';
			case 'auth.loggedIn': return 'Logged in';
			case 'auth.forgotMyPassword': return 'Forgot my password';
			case 'auth.emailAlreadyExists': return 'Email already exists';
			case 'auth.insufficientPermissions': return 'Insufficient permissions';
			case 'auth.internalError': return 'Internal error';
			case 'auth.invalidCredential': return 'Invalid email or password';
			case 'auth.anErrorHasOccurred': return 'An error has occurred';
			case 'auth.userDisabled': return 'User disabled';
			case 'auth.userNotFound': return 'User not found';
			case 'auth.wrongPassword': return 'Wrong password';
			case 'auth.invalidEmail': return 'Invalid email';
			case 'auth.operationNotAllowed': return 'Operation not allowed';
			case 'auth.userAlreadyExists': return 'User already exists';
			case 'auth.requiresRecentLogin': return 'Requires recent login';
			case 'auth.invalidPassword': return 'Invalid password';
			case 'auth.tooManyRequests': return 'Too many requests';
			case 'auth.accountCreated': return 'Account created';
			case 'auth.passwordIsTooWeak': return 'The password must contain at least 6 characters, one uppercase and one lowercase letters.';
			case 'auth.theFieldCannotBeEmpty': return 'The field cannot be empty';
			case 'auth.passwordsDoNotMatch': return 'Passwords do not match';
			case 'auth.youMustAcceptThePrivacyPolicy': return 'You must accept the privacy policy';
			case 'auth.emailSentSuccessfully': return 'Email sent successfully. If it doesn\'t appear in your inbox, check your spam folder';
			case 'auth.youHaveLoggedOut': return 'You have logged out';
			case 'auth.weWillSendYouAnEmailFromWhichYouCanChangeYourPassword': return 'We will send you an email from which you can change your password';
			case 'auth.changePassword': return 'Change password';
			case 'auth.logout': return 'Logout';
			case 'global.cancel': return 'Cancel';
			case 'global.confirm': return 'Confirm';
			case 'global.anErrorHasOccurred': return 'An error has occurred';
			default: return null;
		}
	}
}

extension on _TranslationsCa {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'auth.welcome': return 'Benvingut/da!';
			case 'auth.welcomeBack': return 'Benvingut/da de nou!';
			case 'auth.getStartedWith': return 'Registrar-se';
			case 'auth.signInWith': return 'Iniciar sessió amb';
			case 'auth.orAccessWith': return 'o accedeix amb';
			case 'auth.email': return 'Correu electrònic';
			case 'auth.forgotYourPassword': return '¿Has oblidat la teva contrasenya?';
			case 'auth.needAnAccount': return 'Necessites un compte?';
			case 'auth.register': return 'Registrar-se';
			case 'auth.signIn': return 'Iniciar sessió';
			case 'auth.particular': return 'particular';
			case 'auth.company': return 'companyia';
			case 'auth.name': return 'Nom';
			case 'auth.lastName': return 'Cognoms';
			case 'auth.address': return 'Adreça';
			case 'auth.city': return 'Ciutat';
			case 'auth.password': return 'Contrasenya';
			case 'auth.repeatPassword': return 'Repetir contrasenya';
			case 'auth.alreadyOnboard': return 'Ja tens un compte?';
			case 'auth.iHaveReadAndAgreeThe': return 'Ja he llegit i acceptat les ';
			case 'auth.legalConditions': return 'Condicions legals';
			case 'auth.andThe': return 'i la';
			case 'auth.privacyPolicy': return 'Política de privacitat';
			case 'auth.receiveNewsAndPromos': return 'Rebre noticies i promocions';
			case 'auth.taxName': return 'Nom fiscal';
			case 'auth.cif': return 'CIF';
			case 'auth.send': return 'Enviar';
			case 'auth.loggedIn': return 'Sessió iniciada';
			case 'auth.forgotMyPassword': return 'He oblidat la meva contrasenya';
			case 'auth.emailAlreadyExists': return 'El correu electrònic ja existeix';
			case 'auth.insufficientPermissions': return 'Permisos insuficients';
			case 'auth.internalError': return 'Error intern';
			case 'auth.invalidCredential': return 'Correu electrònic o contrasenya incorrectes';
			case 'auth.anErrorHasOccurred': return 'S\'ha produït un error';
			case 'auth.userDisabled': return 'L\'usuari ha estat deshabilitat';
			case 'auth.userNotFound': return 'No s\'ha trobat l\'usuari';
			case 'auth.wrongPassword': return 'La contrasenya es incorrecta';
			case 'auth.invalidEmail': return 'El correu electrònic no es vàlid';
			case 'auth.operationNotAllowed': return 'Operació no permesa';
			case 'auth.userAlreadyExists': return 'L\'usuari ja existeix';
			case 'auth.requiresRecentLogin': return 'Es requereix tornar a iniciar sessió';
			case 'auth.invalidPassword': return 'La contrasenya no es vàlida';
			case 'auth.tooManyRequests': return 'Masses peticions';
			case 'auth.accountCreated': return 'S\'ha creat el compte';
			case 'auth.passwordIsTooWeak': return 'La contrasenya ha de contenir almenys 6 caràcters, una majúscula i una minúscula.';
			case 'auth.theFieldCannotBeEmpty': return 'El camp no pot estar buit';
			case 'auth.passwordsDoNotMatch': return 'Les contrasenyes no coincideixen';
			case 'auth.youMustAcceptThePrivacyPolicy': return 'Has d\'acceptar la política de privacitat';
			case 'auth.emailSentSuccessfully': return 'Correu electrònic enviat correctament. Si no t\'apareix a la safata d\'entrada, comprova la safata d\'Spam';
			case 'auth.youHaveLoggedOut': return 'S\'ha tancat la sessió';
			case 'auth.weWillSendYouAnEmailFromWhichYouCanChangeYourPassword': return 'T\'enviarem un correu electrònic perquè puguis canviar la teva contrasenya';
			case 'auth.changePassword': return 'Canvia la contrasenya';
			case 'auth.logout': return 'Tancar sessió';
			case 'global.cancel': return 'Cancel·lar';
			case 'global.confirm': return 'Confirmar';
			case 'global.anErrorHasOccurred': return 'S\'ha produït un error';
			default: return null;
		}
	}
}

extension on _TranslationsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'auth.welcome': return '¡Bienvenido/a!';
			case 'auth.welcomeBack': return '¡Bienvenido/a de nuevo!';
			case 'auth.getStartedWith': return 'Registrarse con';
			case 'auth.signInWith': return 'Inicia sesión con';
			case 'auth.orAccessWith': return 'o accede con';
			case 'auth.email': return 'Correo electrónico';
			case 'auth.forgotYourPassword': return '¿Olvidaste tu contraseña?';
			case 'auth.needAnAccount': return '¿Necesitas una cuenta?';
			case 'auth.register': return 'Registrarse';
			case 'auth.signIn': return 'Iniciar sesión';
			case 'auth.particular': return 'particular';
			case 'auth.company': return 'compañía';
			case 'auth.name': return 'Nombre';
			case 'auth.lastName': return 'Apellidos';
			case 'auth.address': return 'Dirección';
			case 'auth.city': return 'Ciudad';
			case 'auth.password': return 'Contraseña';
			case 'auth.repeatPassword': return 'Repetir contraseña';
			case 'auth.alreadyOnboard': return '¿Ya tienes una cuenta?';
			case 'auth.iHaveReadAndAgreeThe': return 'Ya he leido y acepto las ';
			case 'auth.legalConditions': return 'Condiciones legales';
			case 'auth.andThe': return 'y la';
			case 'auth.privacyPolicy': return 'Política de privacidad';
			case 'auth.receiveNewsAndPromos': return 'Recibir notícias y promociones';
			case 'auth.taxName': return 'Nombre fiscal';
			case 'auth.cif': return 'CIF';
			case 'auth.send': return 'Enviar';
			case 'auth.loggedIn': return 'Sesión iniciada';
			case 'auth.forgotMyPassword': return 'He olvidado mi contraseña';
			case 'auth.emailAlreadyExists': return 'El correo electrónico ya existe';
			case 'auth.insufficientPermissions': return 'Permisos insuficientes';
			case 'auth.internalError': return 'Error interno';
			case 'auth.invalidCredential': return 'Correo electrónico o contraseña incorrectas';
			case 'auth.anErrorHasOccurred': return 'Se ha producido un error';
			case 'auth.userDisabled': return 'El usuario ha sido deshabilitado';
			case 'auth.userNotFound': return 'No se ha encontrado el usuario';
			case 'auth.wrongPassword': return 'La contraseña es incorrecta';
			case 'auth.invalidEmail': return 'El correo electrónico no es válido';
			case 'auth.operationNotAllowed': return 'Operación no permitida';
			case 'auth.userAlreadyExists': return 'El usuario ya existe';
			case 'auth.requiresRecentLogin': return 'Se requiere iniciar sesión reciente';
			case 'auth.invalidPassword': return 'La contraseña no es válida';
			case 'auth.tooManyRequests': return 'Demasiadas peticiones';
			case 'auth.accountCreated': return 'Cuenta creada';
			case 'auth.passwordIsTooWeak': return 'La contraseña debe contener al menos 6 caracteres, una mayúscula y una minúscula.';
			case 'auth.theFieldCannotBeEmpty': return 'El campo no puede estar vacío';
			case 'auth.passwordsDoNotMatch': return 'Las contraseñas no coinciden';
			case 'auth.youMustAcceptThePrivacyPolicy': return 'Debes aceptar la política de privacidad';
			case 'auth.emailSentSuccessfully': return 'Email enviado correctamente. Si no aparece en tu bandeja de entrada, revisa tu carpeta de Spam';
			case 'auth.youHaveLoggedOut': return 'Sesión cerrada';
			case 'auth.weWillSendYouAnEmailFromWhichYouCanChangeYourPassword': return 'Te enviaremos un correo electrónico desde donde podras cambiar tu contraseña';
			case 'auth.changePassword': return 'Cambia la contraseña';
			case 'auth.logout': return 'Cerrar sesión';
			case 'global.cancel': return 'Cancelar';
			case 'global.confirm': return 'Confirmar';
			case 'global.anErrorHasOccurred': return 'Se ha producido un error';
			default: return null;
		}
	}
}
