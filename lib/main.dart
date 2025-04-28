import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:foodtek/controller/profile_controller.dart';
import 'package:foodtek/controller/signup_controller.dart';
import 'package:foodtek/controller/track_location_controller.dart';
import 'package:foodtek/controller/login_controller.dart';
import 'package:foodtek/controller/lang_controller.dart';
import 'package:foodtek/view/screens/section_1/splash_screen.dart';
import 'core/app_theme.dart';
import 'core/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => TrackLocationController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => LangController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LangController, ThemeProvider>(
      builder: (context, langController, themeProvider, child) {
        return MaterialApp(
          title: 'FoodTek',
          debugShowCheckedModeBanner: false,

          locale: langController.locale,
          supportedLocales:  [Locale('en'), Locale('ar')],
          localizationsDelegates:  [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,

          home:  SplashScreen(),
        );
      },
    );
  }
}