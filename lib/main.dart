import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme/app_state_notifier.dart';
import 'app_theme/app_theme.dart';
import 'app_theme/my_behaviour.dart';
import 'functions/change_language.dart';
import 'functions/localizations.dart';
import 'pages/home/home_page.dart';
import 'pages/login_signup/login.dart';
import 'pages/login_signup/login_controller.dart';
import 'pages/onboarding/onboarding.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();

  final loginController = LoginController();
  final isAuthorized = await loginController.isUserAuthorized();
  final defaultHome = isAuthorized ? HomePage() : LoginPage();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (_) => AppStateNotifier()),
          Provider<LoginController>(builder: (_) => LoginController()),
        ],
        child: MyApp(appLanguage: appLanguage, homePage: defaultHome),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AppLanguage appLanguage;
  final Widget homePage;

  MyApp({this.appLanguage, this.homePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, appState, child) {
        return ChangeNotifierProvider<AppLanguage>(
          builder: (_) => appLanguage,
          child: Consumer<AppLanguage>(builder: (context, model, child) {
            return MaterialApp(
              title: 'Gg B2B',
              debugShowCheckedModeBanner: false,
              locale: model.appLocal,
              supportedLocales: [
                Locale('en', 'US'),
                Locale('hi', ''),
                Locale('ar', ''),
                Locale('zh', ''),
                Locale('id', ''),
                Locale('ru', ''),
                Locale('es', ''),
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode:
                  appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
              builder: (context, child) {
                return ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: child,
                );
              },
              home: MyHomePage(homePage: homePage),
            );
          }),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Widget homePage;

  MyHomePage({this.homePage});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool progress = true;

  @override
  initState() {
    super.initState();

    checkOnboardingStatus();
  }

  checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int onBoardingStatus = (prefs.getInt('onboardingStatus') ?? 0);
    if (onBoardingStatus == 0) {
      Timer(Duration(seconds: 4), () {
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OnBoarding(nextPage: LoginPage()),
          ),
        );
      });
    } else {
      Timer(Duration(seconds: 4), () {
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.homePage),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // var appLanguage = Provider.of<AppLanguage>(context);

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash_screen.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('splash', 'welcomeMsg'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Jost',
                letterSpacing: 0.7,
              ),
            ),
            SizedBox(height: 17.0),
            Text(
              'GeetGobind\nB2B',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Jost',
                letterSpacing: 0.7,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
