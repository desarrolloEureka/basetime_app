// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get about => 'Acerca de';

  @override
  String get aboutYourself => 'Cuéntanos sobre tí';

  @override
  String get accountNumber => 'Número de cuenta';

  @override
  String get activeMatch => 'Activar Match';

  @override
  String get actives => 'Activos';

  @override
  String get add => 'Agregar';

  @override
  String get addToken => 'Agregar ficha';

  @override
  String get and => 'y';

  @override
  String get backToHome => 'Volver al inicio';

  @override
  String get backToChat => 'Volver al chat';

  @override
  String get balanceDescription =>
      'Aca veras el saldo a favor que ganes por referidos con Base Time, el cual podrás usar para realizar Matchs';

  @override
  String get balancePriceDescription => 'Actualmente tienes un saldo de ';

  @override
  String get bank => 'Banco';

  @override
  String get calendar => 'Calendario';

  @override
  String get camera => 'Cámara';

  @override
  String get cancel => 'Cancelar';

  @override
  String get cancellationMeetAlert =>
      'Tu Match no ha deseado continuar con el meeting...esperamos sea en otra ocasión';

  @override
  String get cardData => 'Datos Tarjeta';

  @override
  String get categories => 'Categorías';

  @override
  String get categoriesDescription =>
      'Selecciona tus gustos y los perfiles que deseas encontrar';

  @override
  String get change => 'Cambiar';

  @override
  String get changePhotoConfirm => 'Quieres cambiar esta foto en realidad?';

  @override
  String get chat => 'Chat';

  @override
  String get checkingAccount => 'Cuenta corriente';

  @override
  String get classifications => 'Clasificaciones';

  @override
  String get completedMeetAlert =>
      'Tu Match ha terminado, ¡vuelve al inicio y sigue buscando nuevas personas!';

  @override
  String get completeProfile => 'Completar perfil';

  @override
  String confirmMatch(num hours, num amount) {
    final intl.NumberFormat amountNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String amountString = amountNumberFormat.format(amount);

    return 'Estas a punto de hacer match para ${hours}h de servicio por $amountString cop';
  }

  @override
  String get continueText => 'Continuar';

  @override
  String copInFavor(num amount) {
    final intl.NumberFormat amountNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String amountString = amountNumberFormat.format(amount);

    return '\$$amountString cop a favor';
  }

  @override
  String get copyLink => 'Copiar enlace';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get credit => 'Crédito';

  @override
  String get creditCard => 'Tarjeta de crédito';

  @override
  String get debitCard => 'Tarjeta de débito';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountAlert => '¿Seguro que deseas borrar tu cuenta?';

  @override
  String deletedAccountAlert(String account) {
    return 'La cuenta $account ha sido borrada.';
  }

  @override
  String get description => 'Descripción';

  @override
  String get discountCoupon => 'Cupon de descuento';

  @override
  String get dniBackPhoto => 'Foto detrás cédula';

  @override
  String get dniFrontPhoto => 'Foto de frente cédula';

  @override
  String get dniSelfie => 'Foto de perfil sosteniendo cédula';

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

    return '\$$amountString cop x hora';
  }

  @override
  String get dollarsXHourHint => 'COP por hora';

  @override
  String get editProfile => 'Editar Perfil';

  @override
  String get editToken => 'Editar ficha';

  @override
  String get email => 'Correo';

  @override
  String get emptyFeedMessage => 'Por ahora no hay profesionales cerca de ti.';

  @override
  String get emptyPaymentAccounts => 'No tienes cuentas bancarias';

  @override
  String get emptyPaymentMethods => 'No tienes métodos de pagos';

  @override
  String get emptyReferralsMessage => 'No has registrado referidos aún.';

  @override
  String get emptyTokens => 'No tienes fichas';

  @override
  String get emptyTokensMessanger => 'Este usuario no tiene perfiles aún.';

  @override
  String get favorites => 'Favoritos';

  @override
  String get filters => 'Filtros';

  @override
  String get firstname => 'Nombre';

  @override
  String get forgotPassword => 'Recuperar contraseña';

  @override
  String get gallery => 'Galería';

  @override
  String get geoDescription =>
      'Selecciona los kilometros a la redonda que quieres buscar, o activa el swich global para buscar en cualquier parte del mundo';

  @override
  String get geolocation => 'Geolocalización';

  @override
  String get globalSearch => 'Búsqueda global';

  @override
  String get hereYouWillSeePayments =>
      'Aca veras el saldo a favor que ganes por referidos con Base Time, el cual podrás usar para realizar Matchs';

  @override
  String get home => 'Inicio';

  @override
  String hours(num amount) {
    return '$amount horas';
  }

  @override
  String hoursMeet(num count) {
    return '$count horas meet';
  }

  @override
  String get iAgreeToHaveRead => 'Acepto haber leido los';

  @override
  String get id => 'Cédula';

  @override
  String get inactive => 'Inactivos';

  @override
  String get invalidID =>
      'La cédula que ingresaste ya existe en el sistema, por favor rectifica que tus datos estén bien y vuelve a intentar';

  @override
  String get invalidPromoterID =>
      'La cédula del promotor que ingresaste no existe, por favor rectifica que los datos estén bien y vuelve a intentar';

  @override
  String get lastname => 'Apellidos';

  @override
  String get majorYearsOld => 'Soy mayor de 18 años';

  @override
  String get makePayment => 'Hacer pago';

  @override
  String get matches => 'Matches';

  @override
  String get matchHours => 'Horas de match';

  @override
  String get meet => 'Meet';

  @override
  String get meets => 'Meets';

  @override
  String get meetTime => 'Tiempo de reunión';

  @override
  String get myAccount => 'Mi cuenta';

  @override
  String get myPaymentAccounts => 'Mis cuentas de recaudo';

  @override
  String get myPaymentMethods => 'Mis métodos de pago';

  @override
  String get myReferrals => 'Mis referidos';

  @override
  String get newPaymentAccount => 'Nueva cuenta de recaudo';

  @override
  String get newPaymentMethod => 'Nuevo método de pago';

  @override
  String get next => 'Siguiente';

  @override
  String get no => 'No';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get numberOfInstallments => 'Número de cuotas';

  @override
  String get optional => 'Opcional';

  @override
  String get password => 'Contraseña';

  @override
  String get password8length =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get passwordHasBeenChanged =>
      'La contraseña ha sido modificada correctamente';

  @override
  String get passwordShouldNotPassword =>
      'La contraseña no debe ser \"contraseña\"';

  @override
  String get passwordVerification =>
      'Su verificación de contraseña debe ser igual a su contraseña';

  @override
  String get paymentData => 'Datos de pago';

  @override
  String get paymentMethod => 'Método de pago';

  @override
  String get paymentRejected =>
      '¡No hemos podido realizar tu pago, intenta con otro método!';

  @override
  String get payments => 'Pagos';

  @override
  String get paymentSuccess => '¡Tu pago se ha realizado con éxito!';

  @override
  String get paymentToStartMatch => 'Pagar para iniciar match';

  @override
  String get phoneNumber => 'Número de teléfono';

  @override
  String get points => 'Puntos';

  @override
  String get policy =>
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consectetur id massa tincidunt fringilla. Etiam a nunc odio. Mauris nec euismod erat. Ut dignissim nunc a vulputate scelerisque. Nunc suscipit purus odio, tempus feugiat libero pellentesque et. Sed porttitor malesuada sapien, ut aliquam justo iaculis sed. Sed vulputate lacus eget faucibus ornare. Nam suscipit condimentum elementum.\n\nMauris rhoncus nulla ac risus euismod consequat. Fusce massa sapien, aliquam id suscipit ut, semper in nibh. Nulla mauris magna, ornare a ex non, luctus tincidunt nibh. Donec ornare augue ipsum, ac fermentum elit ullamcorper sit amet. Cras sit amet nibh ac lacus dictum laoreet et nec quam. Integer malesuada enim tortor, eget pellentesque sem bibendum non. Ut quis lectus augue. Quisque nec dui cursus, malesuada ipsum nec, tempus neque. Curabitur nisi augue, sodales quis arcu eget, tempor maximus sapien.\n\nMauris mi sapien, commodo semper felis non, congue blandit neque. Vestibulum condimentum magna a fermentum sagittis. Integer nisl magna, vestibulum at erat vel, rutrum ultricies erat. Maecenas faucibus velit eget libero rhoncus, a molestie lectus consectetur. Proin finibus erat ut pulvinar efficitur. Phasellus elementum lorem a erat porttitor gravida. Nullam id mauris eget tortor vestibulum congue vitae sed diam. Fusce eu magna dapibus, auctor ligula id, placerat nunc. Vivamus bibendum aliquet maximus. Aenean enim felis, tristique sed dui ac, laoreet faucibus arcu. Nullam id quam placerat ex venenatis vestibulum eget ut turpis. Nunc consequat, purus ut iaculis eleifend, metus nisl facilisis orci, vitae dignissim tortor quam id sem.\n\nPellentesque molestie suscipit lorem. Nulla facilisi. Donec a feugiat justo, ut placerat ex. Nunc at consequat libero. Aenean fringilla vestibulum nisi, in consequat nisi vestibulum in. Ut tempor convallis lorem. Donec mollis molestie faucibus. Aenean volutpat consequat lacus vehicula porttitor. Aenean id molestie felis, ac volutpat elit. Cras ut ex ac libero consequat dignissim.\n\nSed vestibulum vitae nisl nec aliquam. Sed varius iaculis commodo. Nam quam purus, elementum quis sem et, porttitor maximus lacus. Maecenas sem ex, tristique tristique maximus vel, auctor non magna. Nulla ut ex at tellus placerat aliquam eu eget orci. In semper a augue in congue. Mauris nulla erat, volutpat at iaculis ac, interdum non ipsum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.';

  @override
  String get privacyPolicies => 'políticas de privacidad';

  @override
  String get promoterId => 'Cédula Promotor';

  @override
  String get redeemCoupon => 'Canjear cupon';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get savingAccount => 'Cuenta de ahorros';

  @override
  String get search => 'Busqueda';

  @override
  String get selectCategoryDescription =>
      'Selecciona tus categorías\n(elige una o más opciones)';

  @override
  String get selectLang => 'Change to English';

  @override
  String get selectSubCategoryDescription =>
      'selecciona tus subcategorías\n(elige una o más opciones)';

  @override
  String get selectYourPaymentMethod => 'Selecciona tu método de pago';

  @override
  String get sendRecoveryPasswordAlertContent =>
      'Te hemos enviado un enlace a tu correo electrónico para recuperar tu contraseña.';

  @override
  String get sendRecoveryPasswordCancelText => 'Regresar';

  @override
  String get sendRecoveryPasswordConfirmText => '¿Desea ingresar a su correo?';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get signInWithFacebook => 'Iniciar sesión con Facebook';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get signOutAlert => '¿Seguro que deseas cerrar tu sesión?';

  @override
  String get signUpLater => 'Registrar después';

  @override
  String get skip => 'Omitir';

  @override
  String get skipDisabled =>
      'Se lanza si el usuario correspondiente al correo electrónico dado ha sido deshabilitado.';

  @override
  String get subCategories => 'Sub Categorías';

  @override
  String get sureOrderedNow => '¿Estas seguro de realizar tu\npedido ahora?';

  @override
  String get terms =>
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consectetur id massa tincidunt fringilla. Etiam a nunc odio. Mauris nec euismod erat. Ut dignissim nunc a vulputate scelerisque. Nunc suscipit purus odio, tempus feugiat libero pellentesque et. Sed porttitor malesuada sapien, ut aliquam justo iaculis sed. Sed vulputate lacus eget faucibus ornare. Nam suscipit condimentum elementum.\n\nMauris rhoncus nulla ac risus euismod consequat. Fusce massa sapien, aliquam id suscipit ut, semper in nibh. Nulla mauris magna, ornare a ex non, luctus tincidunt nibh. Donec ornare augue ipsum, ac fermentum elit ullamcorper sit amet. Cras sit amet nibh ac lacus dictum laoreet et nec quam. Integer malesuada enim tortor, eget pellentesque sem bibendum non. Ut quis lectus augue. Quisque nec dui cursus, malesuada ipsum nec, tempus neque. Curabitur nisi augue, sodales quis arcu eget, tempor maximus sapien.\n\nMauris mi sapien, commodo semper felis non, congue blandit neque. Vestibulum condimentum magna a fermentum sagittis. Integer nisl magna, vestibulum at erat vel, rutrum ultricies erat. Maecenas faucibus velit eget libero rhoncus, a molestie lectus consectetur. Proin finibus erat ut pulvinar efficitur. Phasellus elementum lorem a erat porttitor gravida. Nullam id mauris eget tortor vestibulum congue vitae sed diam. Fusce eu magna dapibus, auctor ligula id, placerat nunc. Vivamus bibendum aliquet maximus. Aenean enim felis, tristique sed dui ac, laoreet faucibus arcu. Nullam id quam placerat ex venenatis vestibulum eget ut turpis. Nunc consequat, purus ut iaculis eleifend, metus nisl facilisis orci, vitae dignissim tortor quam id sem.\n\nPellentesque molestie suscipit lorem. Nulla facilisi. Donec a feugiat justo, ut placerat ex. Nunc at consequat libero. Aenean fringilla vestibulum nisi, in consequat nisi vestibulum in. Ut tempor convallis lorem. Donec mollis molestie faucibus. Aenean volutpat consequat lacus vehicula porttitor. Aenean id molestie felis, ac volutpat elit. Cras ut ex ac libero consequat dignissim.\n\nSed vestibulum vitae nisl nec aliquam. Sed varius iaculis commodo. Nam quam purus, elementum quis sem et, porttitor maximus lacus. Maecenas sem ex, tristique tristique maximus vel, auctor non magna. Nulla ut ex at tellus placerat aliquam eu eget orci. In semper a augue in congue. Mauris nulla erat, volutpat at iaculis ac, interdum non ipsum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.';

  @override
  String get termsAndConditions => 'términos y condiciones';

  @override
  String get thisFieldIsRequired => '¡Este campo es requerido!';

  @override
  String get thisSectionInConstruction =>
      '¡Esta sección se encuntra en construcción!';

  @override
  String get title => 'Título';

  @override
  String get titleName => 'Nombre titular';

  @override
  String get titularName => 'Nombre titular';

  @override
  String get total => 'Total';

  @override
  String get tryAgain => 'Volver a intentar';

  @override
  String unavailableUsername(String username) {
    return 'El nombre de usuario $username, no esta disponible';
  }

  @override
  String get uploadDataSuccess => 'Tus datos han sido enviados con éxito';

  @override
  String get uploadVerifyDataConfirm =>
      'Una vez envies las fotos no podras editarlas';

  @override
  String get upToDate => 'Ya estás al día';

  @override
  String get useBTP => 'Usar BTP';

  @override
  String get userDisabled => 'Su usario ha sido desabilido.';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get validEmail => '¡Debe ingresar un correo electrónico válido!';

  @override
  String get valueHour => 'Valor \$ hour';

  @override
  String get valueHourDescription =>
      'Selecciona el rango de precio que deseas encontrar';

  @override
  String get varifyAccountGuide =>
      'A continuación adjunta las siguientes fotos y listo, ¡eso es todo!';

  @override
  String get verifyAccount => 'Verificar Cuenta';

  @override
  String get verifyAccountDescription =>
      'Para poder realizar un match debes verificar tu cuenta primero, esto te tomara unos pocos minutos y en un simple paso!';

  @override
  String get verifyAgentNotification =>
      'Uno de nuestros agentes verificara tu cuenta y en un momento podrás hacer ¡tu primer Match¡';

  @override
  String get verifyPassword => 'Verificar contraseña';

  @override
  String get verifyYourAccount => 'Verifica tu cuenta';

  @override
  String get yes => 'Sí';

  @override
  String get addPaymentMethod => 'Nuevo método de pago';

  @override
  String get cardNumber => 'Número en la tarjeta';

  @override
  String get expirationDate => 'Expiración';

  @override
  String get youHaveNoNotifications => 'No tienes notificaciones';

  @override
  String get noResultsFound => 'No se encontraron resultados';

  @override
  String get skills => 'Habilidades';

  @override
  String get imageNotSelected => 'Debe subir una imagen';

  @override
  String get categoriesNotSelected => 'Debe seleccionar al menos una categoría';

  @override
  String get forgotPasswordMessage =>
      'Te enviaremos un link de recuperación al siguiente correo.';

  @override
  String get emptySaved => 'No has guardado nada aún';

  @override
  String get emptyMeets => 'No tienes meets pendientes aún';

  @override
  String get emptyMatches => 'Todavía no tienes coincidencias';

  @override
  String get emptyCards => 'Este usuario no tiene habilidades aún';

  @override
  String get youMustSelectAPaymentMethod =>
      'Debe seleccionar un método de pago';

  @override
  String get select => 'seleccionar';

  @override
  String get requiredLocation => 'Ubicación requerida';

  @override
  String get locationDeniedForever =>
      'Permiso de ubicación denegado permanentemente.';

  @override
  String get openSettings => 'Abrir configuración';

  @override
  String get qualify => 'Calificar';

  @override
  String get rateYourMatch =>
      'Califica a tu Match y déjale un comentario para que los demás lo vean';

  @override
  String get comment => 'Comentario';

  @override
  String get classification => 'Clasificación';

  @override
  String get finish => 'Finalizar';

  @override
  String get loading => 'Cargando';

  @override
  String accountData(String accountType) {
    return 'Datos $accountType';
  }

  @override
  String get selectABank => 'Selecciona un banco';

  @override
  String get movements => 'Movimientos';

  @override
  String get notMovements => 'No tienes movimientos aún';

  @override
  String get requestWithdrawal => 'Solicitar retiro';

  @override
  String get tenMinutesToFinish => 'Faltan 10 minutos para finalizar';
}
