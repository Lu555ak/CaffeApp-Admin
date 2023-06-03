import 'package:caffe_app/models/tables_model.dart';
import 'package:caffe_app/models/menu_model.dart';

import 'package:flutter/material.dart';

import 'package:caffe_app/desktop/layout_desktop.dart';
import 'package:caffe_app/mobile/layout_mobile.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:caffe_app/utility/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Tables().loadFromDatabase();
  Menu().loadFromDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale("en", "EN"), Locale("hr", "HR")],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeListResolutionCallback: (locales, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locales![0].languageCode &&
              supportedLocale.countryCode == locales[0].countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: const CaffeApp(
        mobileLayout: LayoutMobile(),
        desktopLayout: LayoutDesktop(),
      ),
    );
  }
}

class CaffeApp extends StatelessWidget {
  final Widget mobileLayout;
  final Widget desktopLayout;

  const CaffeApp({super.key, required this.mobileLayout, required this.desktopLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 450) {
        return mobileLayout;
      } else {
        return desktopLayout;
      }
    });
  }
}
