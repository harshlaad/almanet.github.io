import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  Db.onInit(preferences);
  // await PushNotificationService().setupInteractedMessage();
  runApp(
    GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraint) => OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(contraint, orientation);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.rightToLeft,
            theme: ThemeData(
              appBarTheme: AppBarTheme(backgroundColor: AppColors.primary),
              primaryColor: AppColors.primary,
              primarySwatch: generateMaterialColor(color: AppColors.primary),
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            ),
            title: "Star gate",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        },
      ),
    );
  }
}
