import 'package:centraldb/helpers/colors.dart';
import 'package:centraldb/provider/appState.dart';
import 'package:centraldb/screens/auth/auth.dart';
import 'package:centraldb/screens/dashboard.dart';
import 'package:centraldb/screens/routes/studentsList.dart';
import 'package:centraldb/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => new AppState(),
          ),
        ],
        child: CentralDb(),
      ),
    );

Map<int, Color> color = {
  50: white,
  100: white,
  200: white,
  300: white,
  400: white,
  500: white,
  600: white,
  700: white,
  800: white,
  900: white,
};

Map<int, Color> colorDark = {
  50: hoverBlack,
  100: hoverBlack,
  200: hoverBlack,
  300: hoverBlack,
  400: hoverBlack,
  500: hoverBlack,
  600: hoverBlack,
  700: hoverBlack,
  800: hoverBlack,
  900: hoverBlack,
};

MaterialColor colorCustom = MaterialColor(0xffFFFFFFF, color);
MaterialColor colorCustomDark = MaterialColor(0xff000000, colorDark);

class CentralDb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      title: 'NACOS Database',
      theme: ThemeData(
        primarySwatch: colorCustom,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'auth':
            return PageTransition(
                child: Auth(), type: PageTransitionType.rightToLeft);
            break;
          case 'home':
            return PageTransition(
                child: Dashboard(), type: PageTransitionType.rightToLeft);
            break;
          case 'studentsList':
            return PageTransition(
                child: StudentsList(), type: PageTransitionType.rightToLeft);
            break;
          default:
            return null;
        }
      },
    );
  }
}
