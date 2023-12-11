// ignore_for_file: dead_code

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/models/BackupPhraseresponse.dart';
import 'package:tixcash/models/LevelitemModel.dart';
import 'package:tixcash/models/SponCode.dart';
import 'package:tixcash/models/StakeDashboardResp.dart';
import 'package:tixcash/models/StakeDateRsp.dart';
import 'package:tixcash/models/Stake_List_Resp.dart';
import 'package:tixcash/models/currency_rate.dart';
import 'package:tixcash/models/directIncome.dart';
import 'package:tixcash/models/models.dart';
import 'package:tixcash/models/network_list_response.dart';
import 'package:tixcash/models/paymentStatus.dart';
import 'package:tixcash/models/premium_Model.dart';
import 'package:tixcash/models/referalclaimResp.dart';
import 'package:tixcash/models/refralincome.dart';
import 'package:tixcash/models/stackingList.dart';
import 'package:tixcash/models/stackingListHistory.dart';
import 'package:tixcash/models/subscriptionReponse.dart';
import 'package:tixcash/models/swap_currencies.dart';
import 'package:tixcash/models/token_detail.dart';
import 'package:tixcash/models/usercode.dart';
import 'package:tixcash/models/walletListResp.dart';
import 'package:tixcash/models/whiteList_Resp.dart';
import 'package:tixcash/models/world_currency.dart';
import 'package:tixcash/shared/constants/storage.dart';

const String SUCCESS = 'success';
const String ERROR = 'failure';
// const String BASE = 'http://block.linechain.org';
const String BASE = 'http://txhapi.tixcash.org';
// const String BASE = 'https://block.linechain.org';
const String BASEAPI = '$BASE/api';
const String BASE_IMAGE = '$BASE/Icon/';
UserResponse? userInfo;
String? deviceId;
String userPassword = '';

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json'
};

Future<ApiResponse> getTokenDetailByContractAPI(address) async {
  try {
    String url = '$BASEAPI/account/gettokendetailbycontract/$address';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      TokenDetail data = tokenDetailFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: null, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

Future<ApiResponse> fundTransferAccountAPI(body) async {
  try {
    String url = '$BASEAPI/account/Swap';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    Map data = jsonDecode(response.body);
    if (data['status'] == 'succeed') {
      CommonResponse data = commonResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: data, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getCurrencyListAPI({isToList = false}) async {
  try {
    String url =
        '$BASEAPI/account/${isToList ? 'getcurrencyTolist' : 'getcurrencyFromlist'}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<SwapCurrency> data = swapCurrencyFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: <SwapCurrency>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <SwapCurrency>[], message: e.toString());
  }
}

Future<ApiResponse> getCurrencyPairPriceAPI(
    {required String from, required String to}) async {
  try {
    String url = '$BASEAPI/account/getcurrencypairprice/$from/$to';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      CurrencyRate data = currencyRateFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: null, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

Future<ApiResponse> getAppVersionAPI() async {
  try {
    String url = '$BASEAPI/account/getAppVersion';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: null, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

Future<ApiResponse> getProfileAPI(id) async {
  try {
    final String url = '$BASEAPI/account/GetProfiledetails/$id';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      UserResponse data = userFromJson(response.body);
      saveUserData(data);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getstakedashboardAPI(int type) async {
  try {
    final String url =
        '$BASEAPI/account/getstakedashboard/$type/${userInfo?.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      StakeDashboardResponse data =
          stakeDashboardResponseFromJson(response.body);

      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getstakedateAPI(int type) async {
  try {
    final String url = '$BASEAPI/account/getstakedate/$type';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      StakedateResponse data = stakedateResponseFromJson(response.body);

      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getsponcodeAPI() async {
  try {
    final String url = '$BASEAPI/account/getsponcode/${userInfo?.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      SponCode data = sponCodeFromJson(response.body);

      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getwhiteliststatusAPI() async {
  try {
    final String url = '$BASEAPI/account/getwhiteliststatus/${userInfo?.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      WhiteListResponse data = whiteListResponseFromJson(response.body);

      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getSubscriptionAPI() async {
  try {
    final String url = '$BASEAPI/account/getsubscriptionstatus/${userInfo?.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      SubscriptionResponse data = subscriptionResponseFromJson(response.body);

      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getcheckreferallAPI(referall) async {
  try {
    final String url =
        '$BASEAPI/account/checkreferall/${userInfo?.id}/$referall';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return ApiResponse(status: true, data: response.body, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getpaymentstatusAPI(phrase) async {
  try {
    final String url = '$BASEAPI/account/getpaymentstatus/$phrase';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      PaymentStatusResponse data = paymentStatusResponseFromJson(response.body);

      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getusercodeAPI() async {
  try {
    final String url = '$BASEAPI/account/getusercode/${userInfo?.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      UsercodeResponse data = usercodeResponseFromJson(response.body);

      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getbackuphrase() async {
  try {
    final String url = '$BASEAPI/account/getbackuphrase/${userInfo?.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      BackupPResponse data = backupPResponseFromJson(response.body);

      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

void saveUserData(UserResponse userResponse) {
  final prefs = Get.find<SharedPreferences>();
  var mData = prefs.getString(StorageConstants.userInfo);
  List<UserResponse> users = mData == null
      ? []
      : userResponseFromJson(prefs.getString(StorageConstants.userInfo)!);

  var mList = users.where((element) => element.id == userResponse.id).toList();
  if (mList.isEmpty) {
    users.add(userResponse);
  }

  // prefs.setString(StorageConstants.userInfo, userResponseToJson(userResponse));
  prefs.setString(StorageConstants.userInfo, userResponseToJson(users));
  userInfo = userResponse;
}

Future<ApiResponse> getcurrencylistAPI() async {
  if (userInfo == null) {
    return ApiResponse(
        status: false, data: <CurrencyListResponse>[], message: ERROR);
  }

  try {
    String url = '$BASEAPI/account/getcurrencylist/${userInfo!.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<CurrencyListResponse> data =
          currencyListResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <CurrencyListResponse>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <CurrencyListResponse>[], message: e.toString());
  }
}

Future<ApiResponse> userFundbalanceAPI(id, currency) async {
  try {
    final String url = '$BASEAPI/account/userFundbalance/$id/$currency';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getBalanceCurrencyListAPI(id) async {
  try {
    final String url = '$BASEAPI/account/GetBalanceCurrencyList/$id';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<CurrencyResponse> data = currencyResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <CurrencyResponse>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <CurrencyResponse>[], message: e.toString());
  }
}

Future<ApiResponse> getwalletlistAPI() async {
  try {
    String url = '$BASEAPI/account/getwalletlist/${userInfo!.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<WalletListResp> data = walletListRespFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <WalletListResp>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <WalletListResp>[], message: e.toString());
  }
}
// Future<ApiResponse> getwalletlistAPI() async {
//   try {
//     const String url = '$BASEAPI/account/getwalletlist/${userInfo!.id}';

//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       List<WalletListResp> data = walletListRespFromJson(response.body);
//       return ApiResponse(status: true, data: data, message: SUCCESS);
//     } else {
//       return ApiResponse(
//           status: false, data: <WalletListResp>[], message: ERROR);
//     }
//   } catch (e) {
//     return ApiResponse(
//         status: false, data: <WalletListResp>[], message: e.toString());
//   }
// }
Future<ApiResponse> getLevelItemAPI(int level) async {
  try {
    String url = '$BASEAPI/account/getlevelteam/${userInfo!.id}/$level';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<LevelitemModel> data = levelitemModelFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <LevelitemModel>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <LevelitemModel>[], message: e.toString());
  }
}

Future<ApiResponse> getPremiumAPI() async {
  try {
    const String url = '$BASEAPI/account/getpackagelist';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<PremiumModel> data = premiumModelFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: <PremiumModel>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <PremiumModel>[], message: e.toString());
  }
}

Future<ApiResponse> getactivestakinglistAPI() async {
  try {
    const String url = '$BASEAPI/account/getactivestakinglist';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<StakeListModel> data = stakeListModelFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <StakeListModel>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <StakeListModel>[], message: e.toString());
  }
}

Future<ApiResponse> getStakingListAPI() async {
  try {
    String url = '$BASEAPI/account/getstakinglist/${userInfo!.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<StakingListModel> data = stakingListModelFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <StakingListModel>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <StakingListModel>[], message: e.toString());
  }
}

Future<ApiResponse> getstakingclaimlistAPI() async {
  try {
    String url = '$BASEAPI/account/getstakingclaimlist/${userInfo!.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<StakingListHistoryModel> data =
          stakingListHistoryModelFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <StakingListHistoryModel>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false,
        data: <StakingListHistoryModel>[],
        message: e.toString());
  }
}

Future<ApiResponse> getrefrallclaimlistAPI() async {
  try {
    String url = '$BASEAPI/account/getrefrallclaimlist/${userInfo!.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<ReferralClaimlistModel> data =
          referralClaimlistModelFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <ReferralClaimlistModel>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <ReferralClaimlistModel>[], message: e.toString());
  }
}

Future<ApiResponse> pendingdirectincomeAPI() async {
  try {
    final String url = '$BASEAPI/account/pendingdirectincome/${userInfo?.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      DirectincomeModel data = directincomeModelFromJson(response.body);

      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getReferalIncomeListAPI() async {
  try {
    String url = '$BASEAPI/account/getrefrellincomelist/${userInfo!.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<ReferalIncomeModel> data = referalIncomeModelFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <ReferalIncomeModel>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <ReferalIncomeModel>[], message: e.toString());
  }
}

// http://royalfalcon.bittgc.com/api/account/MarketListuser/userid
Future<ApiResponse> marketListuserAPI() async {
  try {
    const String url = '$BASEAPI/account/MarketListuser';
    print(url);
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<MarketResponse> data = marketResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <MarketResponse>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <MarketResponse>[], message: e.toString());
  }
}

// http://royalfalcon.bittgc.com/api/account/GetHolderList
Future<ApiResponse> getHolderListAPI() async {
  try {
    const String url = '$BASEAPI/account/GetHolderList';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<HolderResponse> data = holderResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <HolderResponse>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <HolderResponse>[], message: e.toString());
  }
}

// http://royalfalcon.bittgc.com/api/account/getmarketstatic
Future<ApiResponse> getmarketstaticAPI() async {
  try {
    const String url = '$BASEAPI/account/getmarketstatic';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      InfoResponse data = infoResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false,
          data: {'massage': 'something went wrong'},
          message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'massage': e.toString()}, message: e.toString());
  }
}

// http://royalfalcon.bittgc.com/api/account/GetBalanceCurrencyList/Userid
Future<ApiResponse> getTransactionListAPI(String? currency) async {
  if (userInfo == null) {
    return ApiResponse(
        status: false, data: <CurrencyListResponse>[], message: ERROR);
  }

  String mCurrency = currency != null ? '&currency=$currency' : '';

  try {
    final String url =
        '$BASEAPI/account/GetTransactionList?id=${userInfo!.id}$mCurrency';
    // final String url = '$BASEAPI/account/GetTransactionList?id=1$mCurrency';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<TransactionListResponse> data =
          transactionListResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <TransactionListResponse>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false,
        data: <TransactionListResponse>[],
        message: e.toString());
  }
}

// http://royalfalcon.bittgc.com/api/account/GetAllTransactionList
Future<ApiResponse> getAllTransactionListAPI() async {
  try {
    const String url = '$BASEAPI/account/GetAllTransactionList';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<TransferResponse> data = transferResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(
          status: false, data: <TransferResponse>[], message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: <TransferResponse>[], message: e.toString());
  }
}

// http://royalfalcon.bittgc.com/api/account/UpdateBackupPharse
Future<ApiResponse> updateBackupPharseAPI(body) async {
  try {
    String url = '$BASEAPI/account/UpdateBackupPharse';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    Map data = jsonDecode(response.body);
    if (data['status'] == 'succeed') {
      CommonResponse data = commonResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: data, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> restorewithKeyAPI(String key) async {
  try {
    final String url =
        '$BASEAPI/account/RestoreAccountkey/$key/${userInfo?.parentid ?? 0}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    Map data = jsonDecode(response.body);
    if (data['status'] == 'succeed') {
      // return ApiResponse(status: true, data: data, message: SUCCESS);
      return getProfileAPI(data['id']);
    } else {
      return ApiResponse(status: false, data: data, message: data['message']);
    }
  } catch (e) {
    return ApiResponse(status: false, data: {''}, message: e.toString());
  }
}

Future<ApiResponse> getImportAccountAPI(
    String phrase, String paymentcurrency) async {
  try {
    final String url =
        '$BASEAPI/account/ImportAccount/$phrase/${userInfo?.parentid ?? 0}/$paymentcurrency';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    Map data = jsonDecode(response.body);
    if (data['status'] == 'succeed') {
      // return ApiResponse(status: true, data: data, message: SUCCESS);
      return getProfileAPI(data['id']);
    } else {
      return ApiResponse(status: false, data: data, message: data['message']);
    }
  } catch (e) {
    return ApiResponse(status: false, data: {''}, message: e.toString());
  }
}

Future<ApiResponse> getImportAccountKeyAPI(
    String privatekey, String paymentcurrency) async {
  try {
    final String url =
        '$BASEAPI/account/ImportAccountKey/$privatekey/${userInfo?.parentid ?? 0}/$paymentcurrency';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    Map data = jsonDecode(response.body);
    if (data['status'] == 'succeed') {
      // return ApiResponse(status: true, data: data, message: SUCCESS);
      return getProfileAPI(data['id']);
    } else {
      return ApiResponse(status: false, data: data, message: data['message']);
    }
  } catch (e) {
    return ApiResponse(status: false, data: {''}, message: e.toString());
  }
}

// http://royalfalcon.bittgc.com/api/account/RestoreAccount/{Pharseword}
Future<ApiResponse> restoreAccountAPI(String phrase) async {
  try {
    final String url =
        '$BASEAPI/account/RestoreAccount/$phrase/${userInfo?.parentid ?? 0}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    Map data = jsonDecode(response.body);
    if (data['status'] == 'succeed') {
      // return ApiResponse(status: true, data: data, message: SUCCESS);
      return getProfileAPI(data['id']);
    } else {
      return ApiResponse(status: false, data: data, message: data['message']);
    }
  } catch (e) {
    return ApiResponse(status: false, data: {''}, message: e.toString());
  }
}

// https://royalfalcon.bittgc.com/api/account/GetAddressId?id=1&addresstype=0
Future<ApiResponse> getAddressIdAPI(addresstype) async {
  if (userInfo == null) {
    return ApiResponse(
        status: false, data: <CurrencyListResponse>[], message: ERROR);
  }

  try {
    // final String url = '$BASEAPI/account/GetAddressId?id=${userInfo!.id}&addresstype=$addresstype';
    final String url =
        '$BASEAPI/account/GetAddressId?id=${userInfo!.id}&addresstype=$addresstype';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: data, message: data['message']);
    }
  } catch (e) {
    return ApiResponse(status: false, data: {''}, message: e.toString());
  }
}

// http://block.linechain.org/api/account/Swap
// http://royalfalcon.bittgc.com/api/account/userinternalcommission/userid/amt
// Future<ApiResponse> userInternalCommissionAPI(amount) async {
//   try {
//     final String url =
//         '$BASEAPI/account/userinternalcommission/${userInfo!.id}/$amount';
//     print(url);
//     final response = await http.get(Uri.parse(url), headers: headers);
//     Map data = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       return ApiResponse(status: true, data: data, message: SUCCESS);
//     } else {
//       return ApiResponse(status: false, data: data, message: data['message']);
//     }
//   } catch (e) {
//     return ApiResponse(status: false, data: {''}, message: e.toString());
//   }
// }

Future<ApiResponse> userInternalCommissionAPI(currency) async {
  try {
    final String url = '$BASEAPI/account/getCurrencyFee/$currency';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: data, message: data['message']);
    }
  } catch (e) {
    return ApiResponse(status: false, data: {''}, message: e.toString());
  }
}

// http://royalfalcon.bittgc.com/api/account/userexternalcommission/amt
Future<ApiResponse> userExternalCommissionAPI(amount) async {
  return userInternalCommissionAPI(amount);
  try {
    final String url = '$BASEAPI/account/userexternalcommission/$amount';
    print(url);
    final response = await http.get(Uri.parse(url), headers: headers);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: data, message: data['message']);
    }
  } catch (e) {
    return ApiResponse(status: false, data: {''}, message: e.toString());
  }
}

Future<ApiResponse> addressloginAPI(body) async {
  try {
    String url = '$BASEAPI/account/addresslogin';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      UserResponse data = userFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> createWalletAccountAPI(body) async {
  try {
    String url = '$BASEAPI/account/createwalletaccount';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      UserResponse data = userFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

// Future<ApiResponse> createmultipleaccountAPI(body) async {
//   try {
//     String url = '$BASEAPI/account/createmultipleaccount';
//     if (kDebugMode) {
//       print(url);
//     }
//     final response = await http.post(Uri.parse(url),
//         headers: headers, body: json.encode(body));
//     if (response.statusCode == 200) {
//       CommonResponse data = commonResponseFromJson(response.body);
//       return ApiResponse(status: true, data: data, message: SUCCESS);
//     } else {
//       return ApiResponse(status: false, data: response.body, message: ERROR);
//     }
//   } catch (e) {
//     return ApiResponse(
//         status: false, data: {'message': e.toString()}, message: e.toString());
//   }
// }

Future<ApiResponse> createmultipleaccountAPI(body) async {
  try {
    String url = '$BASEAPI/account/createmultipleaccount';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      UserResponse data = userFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> fundTransferaccountAPI(body) async {
  try {
    String url = '$BASEAPI/account/FundTransferaccount';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    Map data = jsonDecode(response.body);
    if (data['status'] == 'succeed') {
      CommonResponse data = commonResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: data, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> fundWithdrwaluserAPI(body) async {
  try {
    String url = '$BASEAPI/account/FundWithdrwaluser';
    if (kDebugMode) {
      print(url);
    }

    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    Map data = jsonDecode(response.body);
    if (data['status'] == 'succeed') {
      CommonResponse data = commonResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: data, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> walletLoginAPI(body) async {
  try {
    String url = '$BASEAPI/account/WalletLogin';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      CommonResponse data = commonResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> userUpdateCurrencyAPI(body) async {
  try {
    String url = '$BASEAPI/account/addcurrencyuser';
    // String url = '$BASEAPI/account/UserUpdateCurrency';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      CommonResponse data = commonResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> depositFundAPI(body) async {
  try {
    String url = '$BASEAPI/account/DepositFund';
    print(url);
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    Map data = jsonDecode(response.body);
    if (data['status'] == 'succeed') {
      CommonResponse data = commonResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: data, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> getNetworkAPI() async {
  try {
    const String url = '$BASEAPI/account/getnetwork';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<NetworkListResponse> data =
          networkListResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: null, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(status: false, data: {''}, message: e.toString());
  }
}

Future<ApiResponse> addCurrencyAPI(body) async {
  try {
    String url = '$BASEAPI/account/addcurrency';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      CommonResponse data = commonResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> addpremiumAccessAPI(body) async {
  try {
    String url = '$BASEAPI/account/buypackage';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      CommonResponse data = commonResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> stakpackageAPI(body) async {
  try {
    String url = '$BASEAPI/account/stakpackage';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      CommonResponse data = commonResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> claimdirectrewardAPI(body) async {
  try {
    String url = '$BASEAPI/account/claimdirectreward';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      CommonResponse data = commonResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

Future<ApiResponse> claimstakingrewardAPI(body) async {
  try {
    String url = '$BASEAPI/account/claimstakingreward';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      CommonResponse data = commonResponseFromJson(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(
        status: false, data: {'message': e.toString()}, message: e.toString());
  }
}

@override
Future<ApiResponse> getWorldCurrencyAPI() async {
  try {
    String url =
        'https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_luCgX11cUnrzrBwxDOnj2xXiRdcJr1tDPO3O2pka';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      WorldCurrencyResponse data = worldCurrencyResponseFromJson(response.body);

      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(status: false, data: {''}, message: e.toString());
  }
}
// getprivatekey

Future<ApiResponse> getPrivateKeyAPI() async {
  try {
    String url =
        '$BASEAPI/account/getprivatekey/${userInfo!.address}/${userInfo!.id}';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      return ApiResponse(status: true, data: data, message: SUCCESS);
    } else {
      return ApiResponse(status: false, data: null, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(status: false, data: {''}, message: e.toString());
  }
}

class ApiResponse {
  bool status;
  String? message;
  dynamic data;

  ApiResponse({required this.status, this.message = '', this.data});
}

const String AUTHORITY = 'royalfalcon.bittgc.com';
const String URI_MESSAGE = 'https://fcm.googleapis.com/fcm/send';
const String AUTHORIZATION =
    'key=AAAA6y1vSc4:APA91bE1CLVYghlWWW9DmdDpYUkPwBgt4F9GsPGxkTq-qcPdCMqkIXGK3Xj7OgapWQB1XJdjdEJyn66mFm1TJQHxPzTHbGQwKjmWEyg7jF8cmBy8zg6arSdAuKe2sUcC3IpzgYs30Bls';

Future<void> postMessage(String token, String title, String message) async {
  Map body = {
    'data': {'score': '5x1', 'time': ''},
    'notification': {'title': title, 'body': message},
    'to': token,
    'direct_book_ok': true,
    'priority': 10
  };

  try {
    final response = await http.post(Uri.http(AUTHORITY, URI_MESSAGE),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AUTHORIZATION,
          'Accept': 'application/json'
        },
        body: json.encode(body));
    if (kDebugMode) {
      print(response.statusCode);
    }
    return;
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
    return;
  }
}
