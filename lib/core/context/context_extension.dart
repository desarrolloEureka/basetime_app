import 'package:basetime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


extension ContextExtension on BuildContext {
  /// Language
  AppLocalizations? get lang => AppLocalizations.of(this);

  /// current locale
  Locale get getLocale => Locale(lang?.localeName ?? 'en');

  /// onboarding texts
  String onboardingTitle(int index) {
    final enTexts = [
      'Connect',
      'Monetize',
      'Learn',
    ];
    final esTexts = [
      'Conecta',
      'Monetiza',
      'Aprende',
    ];
    return lang?.localeName == 'en' ? enTexts[index] : esTexts[index];
  }

  /// onboarding descriptions
  String onboardingDescriptions(int index) {
    final enTexts = [
      'With professionals and experts in all your areas of interest',
      'Earn money while doing what you love most',
      'From the passions of others',
    ];
    final esTexts = [
      'Con profesionales y expertos en todas tus areas de interes',
      'Gana dinero mientras haces lo que más te gusta',
      'Desde las pasiones de los demás',
    ];
    return lang?.localeName == 'en' ? enTexts[index] : esTexts[index];
  }

  /// Firebase Error Message
  String firebaseErrorMessage(String code) {
    switch (code) {
      case 'user-disabled':
        return lang!.userDisabled;
      default:
        return '';
    }
  }

  /// Show Banner
  ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>
      showBanner({required String message}) {
    return ScaffoldMessenger.of(this).showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: GoogleFonts.ubuntu(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(this).clearMaterialBanners();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Show Dialog
  Future<T?> showConfirm<T>({
    String? content,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
  }) async {
    return showDialog<T>(
      context: this,
      builder: (BuildContext dialogContext) {
        return Scaffold(
          backgroundColor: Colors.black26,
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(this).size.width - 64,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: onCancel ?? pop,
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          content ?? 'Text Here',
                          style: GoogleFonts.ubuntu(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(this).size.width - 62,
                      height: 1,
                      color: Colors.grey,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: onConfirm ?? pop,
                            child: Text(
                              lang!.yes,
                              style: GoogleFonts.ubuntu(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 48,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: MaterialButton(
                            onPressed: onCancel ?? pop,
                            child: Text(
                              lang!.no,
                              style: GoogleFonts.ubuntu(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Show Dialog
  Future<T?> showAlert<T>({
    String? content,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    String? confirmText,
  }) async {
    return showDialog<T>(
      context: this,
      builder: (BuildContext dialogContext) {
        return Scaffold(
          backgroundColor: Colors.black26,
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(this).size.width - 64,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: onCancel ?? pop,
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          content ?? 'Text Here',
                          style: GoogleFonts.ubuntu(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(this).size.width - 62,
                      height: 1,
                      color: Colors.grey,
                    ),
                    Row(
                      children: [
                        if (onConfirm != null)
                          Expanded(
                            child: MaterialButton(
                              onPressed: onConfirm,
                              child: Text(
                                confirmText ?? lang!.yes,
                                style: GoogleFonts.ubuntu(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        if (onCancel != null)
                          Container(
                            width: 1,
                            height: 48,
                            color: Colors.grey,
                          ),
                        if (onCancel != null)
                          Expanded(
                            child: MaterialButton(
                              onPressed: onCancel,
                              child: Text(
                                lang!.no,
                                style: GoogleFonts.ubuntu(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
