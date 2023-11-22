import 'dart:async';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/models/models.dart';
import 'package:tixcash/routes/app_pages.dart';
import 'package:tixcash/shared/shared.dart';

class SplashController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final delay = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    delayCount();
  }

  void delayCount() {
    Future.delayed(const Duration(milliseconds: 100), () {
      delay.value = 1.0;
    });
  }

  void launchApp(context) async {
    // Future.delayed(const Duration(milliseconds: 1000), (){
    Timer(const Duration(milliseconds: 1000), () {
      var storage = Get.find<SharedPreferences>();
      try {
        var sUser = storage.getString(StorageConstants.userInfo);
        if (sUser != null) {
          // if (storage.getString(StorageConstants.userInfo) != null) {
          List<UserResponse> users = [];
          if (sUser.startsWith('[{')) {
            print('Start with an array');
            users = userResponseFromJson(
                storage.getString(StorageConstants.userInfo)!);
          } else {
            users = [
              userFromJson(storage.getString(StorageConstants.userInfo)!)
            ];
            final prefs = Get.find<SharedPreferences>();
            prefs.setString(
                StorageConstants.userInfo, userResponseToJson(users));
          }
          userPassword = storage.getString(StorageConstants.userPassword) ?? '';
          // List<UserResponse> users = userResponseFromJson(storage.getString(StorageConstants.userInfo)!);
          // users = userResponseFromJson(storage.getString(StorageConstants.userInfo)!);
          if (users.isNotEmpty && users.length == 1) {
            UserResponse resUser = users.first;
            resUser.active = true;
            userInfo = resUser;
          } else {
            var mUser = users.where((element) => element.active);
            if (mUser.isEmpty) {
              UserResponse sUser = users.first;
              sUser.active = true;
              userInfo = sUser;
            } else {
              userInfo = users.where((element) => element.active).first;
            }
          }
          String? mPass = storage.getString(StorageConstants.userPassword);
          if (mPass == null) {
            mPass = userInfo!.password;
            final prefs = Get.find<SharedPreferences>();
            prefs.setString(StorageConstants.userPassword, mPass);
            userPassword = mPass;
          }
          // userPassword = storage.getString(StorageConstants.userPassword)??userInfo!.password;
          // userInfo = userResponseFromJson(storage.getString(StorageConstants.userInfo)!);
          int typeLogin = storage.getInt(StorageConstants.loginType) ?? 1;

          if (typeLogin == 0) {
            appController.validateLogin(context, () {
              Get.offAndToNamed(Routes.Dashboard);
            });
          } else if (typeLogin == 1) {
            Get.offAndToNamed(Routes.FINGER_PRINT_LOGIN);
          } else {
            Get.offAndToNamed(Routes.Dashboard);
          }
        } else {
          Get.offAndToNamed(Routes.START);
        }
      } catch (e) {
        Get.offAndToNamed(Routes.START);
      }
    });
  }
}
