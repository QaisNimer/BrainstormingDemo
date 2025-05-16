import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodtek/service/auth/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:foodtek/controller/favorites_controller.dart';
import 'package:foodtek/controller/profile_controller.dart';
import 'package:foodtek/controller/signup_controller.dart';
import 'package:foodtek/controller/track_location_controller.dart';
import 'package:foodtek/controller/login_controller.dart';
import 'package:foodtek/controller/lang_controller.dart';
import 'controller/location_controller.dart';
import 'firebase_options.dart';
import 'package:foodtek/controller/location_controller.dart';
import 'package:foodtek/core/theme/app_theme.dart';
import 'package:foodtek/core/theme/theme_provider.dart';
import 'package:foodtek/view/screens/section_1/splash_screen.dart';
import 'dart:io';

import 'controller/category_controller.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // إضافة تجاوز شهادات SSL
  HttpOverrides.global = MyHttpOverrides();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => AuthenticationService()),
        ChangeNotifierProvider(create: (_) => TrackLocationController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => LangController()),
        ChangeNotifierProvider(create: (_) => LocationController()),
        ChangeNotifierProvider(create: (_) => FavoritesController()),
    ChangeNotifierProvider(
        create: (_) => CategoryController()..fetchCategories(),),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("token = $token ");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LangController, ThemeProvider>(
      builder: (context, langController, themeProvider, child) {
        return MaterialApp(
          title: 'FoodTek',
          debugShowCheckedModeBanner: false,
          locale: langController.locale,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}