import 'dart:io';

import 'package:cooking_project/app/pages/home/view/home_screen.dart';
import 'package:cooking_project/app/pages/splash/cubit/splash_cubit.dart';
import 'package:cooking_project/app/pages/splash/cubit/splash_state.dart';
import 'package:cooking_project/core/helper/screen_app.dart';
import 'package:cooking_project/app/routes.dart';
import 'package:cooking_project/core/singleton/injection_container.dart';
import 'package:cooking_project/core/helper/shared_preferences.dart';
import 'package:cooking_project/data/repository/login_repository.dart';
import 'package:cooking_project/domain/repositories/auth_repo/login_auth_repo.dart';
import 'package:cooking_project/domain/use_cases/auth_use_case/auth_use_case.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/bundle/default_asset.dart';
import 'core/singleton/local_language.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/firebase_options.dart';
import 'app/pages/splash/view/splash_screen.dart';

Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await _initialize();
  await initDependencies();
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'vi', supportedLocales: ['en_US', 'vi']);

  runApp(DefaultAssetBundle(
    bundle: TestAssetBundle(),
    child: BlocProvider<SplashCubit>(
        create: (context) => SplashCubit(getAuthUseCase: GetAuthStatusUseCase(loginRepository: sl<LoginRepository>()))..appStart(),
        child: LocalizedApp(delegate, App())),
  ));
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
    ScreenApp.init(context);
    SharedPrefsRepository().init();
    LocalizationService().init(context);
    return LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp(
            initialRoute: AppRoutes.home,
            onGenerateRoute: AppRoutes.generateRoute,
            home: BlocBuilder<SplashCubit, SplashState>(
              builder: (BuildContext context, state) {
                if (state is SplashDone) {
                  return HomeScreen();
                }
                return SplashScreen();
              },
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              LocalizationService().delegate
            ],
            supportedLocales: LocalizationService().delegate.supportedLocales,
            locale: LocalizationService().delegate.currentLocale,
            debugShowCheckedModeBanner: false,
          ),
        ));
  }
}
