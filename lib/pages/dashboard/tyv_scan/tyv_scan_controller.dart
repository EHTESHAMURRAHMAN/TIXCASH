import 'package:get/get.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/app_controller.dart';
import 'package:tixcash/models/models.dart';
import 'package:intl/intl.dart';
import 'package:tixcash/pages/dashboard/home_navigation/home_navigation_controller.dart';

class TyvScanController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final HomeNavigationController homeNavigationController =
      Get.find<HomeNavigationController>();
  final transactionListResponse = RxList<TransactionListResponse>();
  final holderResponseList = RxList<HolderResponse>();
  final transferResponseList = RxList<TransferResponse>();

  final infoResponse = InfoResponse(
          overview: 'ERC20',
          tokenName: 'LINE Tyrtkov',
          maxTotalSupply: '15,000,000 LINE',
          holders: '152',
          internaltransfer: '91',
          externaltransfer: '11',
          contractAddress: '0x15ff09fd0159b25fad9e8bf0d2a5bfef6e46e2bc',
          decimalValue: '3')
      .obs;

  final isTransLoaded = false.obs;
  final index = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getTransactionList();
    getAllTransactionList();
    getHolderList();
    getmarketstatic();
  }

  void getTransactionList() async {
    ApiResponse response = await getTransactionListAPI(null);
    transactionListResponse.value = response.data;
    transactionListResponse.sort((a, b) =>
        formatDate(b.transactionDate).compareTo(formatDate(a.transactionDate)));
    isTransLoaded.value = true;
  }

  void getAllTransactionList() async {
    ApiResponse response = await getAllTransactionListAPI();
    transferResponseList.value = response.data;
    transferResponseList.sort((a, b) =>
        formatDate(b.transactionDate).compareTo(formatDate(a.transactionDate)));
  }

  void getHolderList() async {
    ApiResponse response = await getHolderListAPI();
    holderResponseList.value = response.data;
  }

  void getmarketstatic() async {
    ApiResponse response = await getmarketstaticAPI();
    if (response.status) {
      infoResponse.value = response.data;
    }
  }

  DateTime formatDate(String date) {
    // DateTime time = DateTime.fromMillisecondsSinceEpoch(date is int?date:int.parse(date));
    DateTime time = DateFormat('MM/dd/yyyy hh:mm:ss').parse(date);
    return time;
  }
}
