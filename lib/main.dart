import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:busniess_card_app/Bindings/all_bindings.dart';
import 'package:busniess_card_app/Controllers/auth_controller.dart';
import 'package:busniess_card_app/Utils/appThemes.dart';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:busniess_card_app/Views/loading_view.dart';
import 'package:busniess_card_app/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_strategy/url_strategy.dart';

var kWidth = Get.width;
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   Get.put(AuthController());
//   setPathUrlStrategy();
//   kIsWeb ? kWidth = 410 : Get.width;
//   runApp(const MyApp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  setPathUrlStrategy();
  kIsWeb ? kWidth = 410 : Get.width;

  runApp(
    ThemeProvider(
      initTheme: AppThemes.darkThemeData,
      child: Builder(
        builder: (context) => GetMaterialApp(
          initialBinding: AuthCheckBinding(),
          debugShowCheckedModeBanner: false,
          darkTheme: AppThemes.darkThemeData,
          theme: ThemeData(
            primarySwatch: kPrimaryColor,
            primaryColor: kPrimaryColor,
            textTheme: GoogleFonts.poppinsTextTheme(),
            scaffoldBackgroundColor: backgroundColor,
            // Theme.of(context).textTheme
          ),
          home: LoadingScreen(),
        ),
      ),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       initialBinding: AuthCheckBinding(),
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: kPrimaryColor,
//         primaryColor: kPrimaryColor,
//         textTheme: GoogleFonts.poppinsTextTheme(
//           Theme.of(context).textTheme,
//         ),
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: LoadingScreen(),
//     );
//   }
// }
