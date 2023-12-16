import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'app/controllers/global_controller.dart';
import 'app/controllers/home_controller.dart';
import 'app/controllers/pdf_controller.dart';
import 'app/data/shared/preferences.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/ui/utils/constants.dart';

void main() async {
  final prefs = Preferences();
  WidgetsFlutterBinding.ensureInitialized();
  await prefs.initPrefs();

  Get.put(GlobalController());
  Get.put(PdfController());
  Get.put(HomeController());
  configLoading();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Constants.themeBlack,
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Constants.themeBlack),
          primaryTextTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Constants.themeTextPrimary),
          primaryIconTheme:
              const IconThemeData(color: Constants.themeTextPrimary),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        defaultTransition: Transition.fade,
        getPages: AppPages.pages,
        initialRoute: Routes.home,
        builder:
            EasyLoading.init(builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: SafeArea(
              child: Scaffold(
                body: child ?? Container(),
              ),
            ),
          );
        }),
        title: '' //poner el título,
        );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
