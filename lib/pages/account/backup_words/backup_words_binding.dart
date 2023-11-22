import 'package:get/get.dart';

import 'backup_words_controller.dart';

class BackupWordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BackupWordsController>(BackupWordsController());
  }
}
