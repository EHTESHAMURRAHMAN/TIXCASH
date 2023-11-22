import 'package:get/get.dart';
import 'package:tixcash/models/trans_list_response.dart';

class TransactionDetailController extends GetxController {
  var arguments = Get.arguments;

  TransactionListResponse? trxDetails;

  @override
  void onInit() {
    super.onInit();
    trxDetails = arguments[0]['trans'];
  }
}
