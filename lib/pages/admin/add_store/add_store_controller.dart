import 'package:get/get.dart';

class AddStoreController extends GetxController {

  @override
  void onInit() => null;
  
  final count = 0.obs;
  increment() => count.value++;
}
