import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:swarden/app/core/const/global.dart';
import 'package:swarden/app/presentation/global/theme.dart';
import 'package:swarden/app/presentation/routes/router.dart';

import '../core/generated/translations.g.dart';

class SWardenApp extends StatefulWidget {
  const SWardenApp({super.key});

  @override
  State<SWardenApp> createState() => _SWardenAppState();
}

class _SWardenAppState extends State<SWardenApp> with RoutesMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        debugShowCheckedModeBanner: false,
        title: Global.appName,
        theme: SWardenTheme.lightTeme,
        routerConfig: router,
      ),
    );
  }
}
