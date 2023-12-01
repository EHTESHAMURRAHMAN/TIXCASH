import 'package:shared_preferences/shared_preferences.dart';
import 'di.dart';
import 'routes/app_pages.dart';
import 'theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tixcash/app_binding.dart';
import 'package:tixcash/lang/lang.dart';
import 'package:tixcash/shared/shared.dart';

bool isLocalAuth = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DenpendencyInjection.init();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  bool isLocked = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        var storage = Get.find<SharedPreferences>();
        storage.setInt(
            StorageConstants.pauseTime, DateTime.now().millisecondsSinceEpoch);
      });
    } else if (state == AppLifecycleState.paused) {
      setState(() {
        var storage = Get.find<SharedPreferences>();
        var sUser = storage.getString(StorageConstants.userInfo);
        super.didChangeAppLifecycleState(state);
        int time = storage.getInt(StorageConstants.pauseTime) ?? 1800;
        int locTime = storage.getInt(StorageConstants.locTime) ?? 1800;
        int timeNow = DateTime.now().millisecondsSinceEpoch;
        int diff = timeNow - time;

        printInfo(info: 'Difference => $diff');
        if (locTime * 500 < diff) {
          if (sUser != null) {
            Get.offAllNamed(Routes.FINGER_PRINT_LOGIN);
          } else {
            // Get.offAndToNamed(Routes.START);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
        child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: Routes.SPLASH,
      defaultTransition: Transition.fade,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      title: 'Tixcash wallet',
      theme: lightTheme1(),
      darkTheme: darkTheme1(),
      themeMode: ThemeMode.system,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      builder: EasyLoading.init(),
    ));
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   printInfo(info: 'AppState: $state');
  //   if (state == AppLifecycleState.paused) {
  //     var storage = Get.find<SharedPreferences>();
  //     storage.setInt(
  //         StorageConstants.pauseTime, DateTime.now().millisecondsSinceEpoch);
  //   }
  //   if (state == AppLifecycleState.resumed) {
  //     var storage = Get.find<SharedPreferences>();
  //     int time = storage.getInt(StorageConstants.pauseTime) ?? 1800;
  //     int locTime = storage.getInt(StorageConstants.locTime) ?? 1800;
  //     int timeNow = DateTime.now().millisecondsSinceEpoch;
  //     int diff = timeNow - time;
  //     printInfo(info: 'Difference => $diff');
  //     if (locTime * 500 < diff) {
  //       Get.offAndToNamed(Routes.FINGER_PRINT_LOGIN);
  //     }
  //   }
  // }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    // ..indicatorSize = 45.0/
    ..radius = 10.0
    // ..progressColor = Colors.yellow
    ..backgroundColor = ColorConstants.lightGray
    ..indicatorColor = ColorConstants.secondaryDarkAppColor
    ..textColor = ColorConstants.secondaryDarkAppColor
    // ..maskColor = Colors.red
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}


// //import 'package:firebase_core/firebase_core.dart';
// import 'di.dart';
// import 'routes/app_pages.dart';
// import 'theme/theme_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:tyv_wallet/app_binding.dart';
// import 'package:tyv_wallet/lang/lang.dart';
// import 'package:tyv_wallet/shared/shared.dart';

// // import 'firebase_options.dart';
// bool isLocalAuth = false;
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   await DenpendencyInjection.init();
//   runApp(const App());
//   // configLoading();
// }

// class App extends StatelessWidget with WidgetsBindingObserver {
//   const App({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addObserver(this);

//     return OverlaySupport.global(
//         child: GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       enableLog: true,
//       initialRoute: Routes.SPLASH,
//       defaultTransition: Transition.fade,
//       getPages: AppPages.routes,
//       initialBinding: AppBinding(),
//       smartManagement: SmartManagement.keepFactory,
//       title: 'Tixcash wallet',
//       theme: ThemeConfig.darkTheme,
//       locale: TranslationService.locale,
//       fallbackLocale: TranslationService.fallbackLocale,
//       translations: TranslationService(),
//       builder: EasyLoading.init(),
//     ));
//   }

//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) {
//   //   super.didChangeAppLifecycleState(state);
//   //   printInfo(info: 'AppState: $state');
//   //   if (state == AppLifecycleState.paused) {
//   //     var storage = Get.find<SharedPreferences>();
//   //     storage.setInt(
//   //         StorageConstants.pauseTime, DateTime.now().millisecond sSinceEpoch);
//   //   }
//   //   if (state == AppLifecycleState.resumed) {
//   //     var storage = Get.find<SharedPreferences>();
//   //     int time = storage.getInt(StorageConstants.pauseTime) ?? 1800;
//   //     int locTime = storage.getInt(StorageConstants.locTime) ?? 1800;
//   //     int timeNow = DateTime.now().millisecondsSinceEpoch;
//   //     int diff = timeNow - time;
//   //     printInfo(info: 'Difference => $diff');
//   //     if (locTime * 500 < diff) {
//   //       Get.offAndToNamed(Routes.FINGER_PRINT_LOGIN);
//   //     }
//   //   }
//   // }
// }

// void configLoading() {
//   EasyLoading.instance
//     ..indicatorType = EasyLoadingIndicatorType.threeBounce
//     ..loadingStyle = EasyLoadingStyle.custom
//     // ..indicatorSize = 45.0/
//     ..radius = 10.0
//     // ..progressColor = Colors.yellow
//     ..backgroundColor = ColorConstants.lightGray
//     ..indicatorColor = ColorConstants.secondaryDarkAppColor
//     ..textColor = ColorConstants.secondaryDarkAppColor
//     // ..maskColor = Colors.red
//     ..userInteractions = false
//     ..dismissOnTap = false
//     ..animationStyle = EasyLoadingAnimationStyle.scale;
// }