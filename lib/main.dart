import 'dart:io';

import 'package:cooking_project/views/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/bundle/default_asset.dart';

Future<void> _initialize() async{
  WidgetsFlutterBinding.ensureInitialized();

}

Future<void> main() async{
  HttpOverrides.global = MyHttpOverrides();
  await _initialize();
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'vi',
      supportedLocales: ['en_US', 'vi']);
  runApp(
    DefaultAssetBundle(
      bundle: TestAssetBundle(),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              return  LocalizedApp(delegate,App());
            },
          );
        },
      ),
    )
  );
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

}


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: MaterialApp(
            home: HomeScreen(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              localizationDelegate
            ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
            debugShowCheckedModeBanner: false,));
  }
}
