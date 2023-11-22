import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tixcash/models/Stake_List_Resp.dart';
import 'package:tixcash/models/premium_Model.dart';
import 'package:tixcash/pages/Stack/Stack_Controller.dart';
import 'package:tixcash/pages/dashboard/tabs/Wallet_Premium/Premium_Controller.dart';
import 'package:tixcash/shared/shared.dart';
import 'package:http/http.dart' as http;

class CommonWidget {
  static AppBar appBar(
      BuildContext context, String title, IconData? backIcon, Color color,
      {void Function()? callback}) {
    return AppBar(
      leading: backIcon == null
          ? null
          : IconButton(
              icon: Icon(backIcon, color: color),
              onPressed: () {
                if (callback != null) {
                  callback();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
      centerTitle: true,
      title: Text(
        title.tr,
        style: TextStyle(color: color, fontFamily: 'Rubik'),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  static SizedBox rowHeight({double height = 30}) {
    return SizedBox(height: height);
  }

  static SizedBox rowWidth({double width = 30}) {
    return SizedBox(width: width);
  }

  static void toast(String error) async {
    await Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}

class SaveButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function() onPress;
  const SaveButton(
      {Key? key,
      required this.title,
      this.isActive = true,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isActive
        ? GestureDetector(
            onTap: onPress,
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: ColorConstants.secondaryDarkAppColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.roboto(fontSize: 16),
                ),
              ),
            ),
          )
        : Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: ColorConstants.darkGray,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.roboto(fontSize: 16),
              ),
            ),
          );
  }
}

class SelectContainer extends StatelessWidget {
  final String title;
  final Function() onSelect;
  const SelectContainer({Key? key, required this.title, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
        ),
        decoration: BoxDecoration(
            color: ColorConstants.secondaryDarkAppColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(title),
      ),
    );
  }
}

Future<File?> downloadFile(url) async {
  print('downloadImage => $url');
  try {
    String filename = Uri.parse(url).pathSegments.last;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    // if (file.existsSync()) {
    //   return file;
    // } else {
    print('downloading from server.....');
    var request = await http.get(
      Uri.parse(url),
    );
    print('----------------------------${request.statusCode}');
    if (request.statusCode == 200) {
      var bytes = request.bodyBytes; //close();
      await file.writeAsBytes(bytes);
      print(file.path);
      return file;
    } else {
      return null;
    }
    // }
  } catch (e) {
    print(e);
    return null;
  }
}

class PremiumAccess extends StatelessWidget {
  PremiumAccess({Key? key}) : super(key: key);

  PremiumController controller = Get.put(PremiumController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Select Premium Plan',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  PremiumModel model =
                      controller.premiumModelResponse.elementAt(index);
                  return Column(
                    children: [
                      const SizedBox(height: 12),
                      model.pid == 2
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${model.pid} Years Access',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${model.pid} Year Access',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                      model.pid == 2
                          ? Container(
                              margin: const EdgeInsets.symmetric(vertical: 7),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        model.packagename,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      const CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.red,
                                        child: Center(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '10%',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'OFF',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                  // enabled: model.id.length > 1,
                                  onTap: () {
                                    Get.back(result: {
                                      'pid': model.pid,
                                      'packagename': model.packagename
                                    });
                                  },
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.symmetric(vertical: 7),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                    model.packagename,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // enabled: model.id.length > 1,
                                  onTap: () {
                                    Get.back(result: {
                                      'pid': model.pid,
                                      'packagename': model.packagename
                                    });
                                  },
                                ),
                              ),
                            )
                    ],
                  );
                },
                itemCount: controller.premiumModelResponse.length,
              ),
            )));
  }
}

class ActiveStakeList extends StatelessWidget {
  ActiveStakeList({Key? key}) : super(key: key);

  StackController controller = Get.put(StackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Select Stake Plan',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  StakeListModel model =
                      controller.stakeListModelResponse.elementAt(index);
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: ListTile(
                        trailing: const Icon(Icons.ads_click),
                        title: Text(
                          model.totaldays,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        // enabled: model.id.length > 1,
                        onTap: () {
                          Get.back(result: {
                            'plan': model.totaldays,
                            'id': model.staketype
                          });
                        },
                      ),
                    ),
                  );
                },
                itemCount: controller.stakeListModelResponse.length,
              ),
            )));
  }
}

class currencyPremium extends StatelessWidget {
  currencyPremium({Key? key}) : super(key: key);
  final List<String> currencys = [
    "USDT-BEP20",
    "USDC-BEP20",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Select Currency',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          itemBuilder: (context, index) {
            String name = currencys.elementAt(index);
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                height: 75,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(22)),
                child: Center(
                    child: ListTile(
                  title: Text(
                    name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  enabled: name.length > 1,
                  onTap: () {
                    Get.back(result: {'name': name});
                  },
                )));
          },
          itemCount: currencys.length,
        ),
      ),
    );
  }
}

class StakeDays extends StatelessWidget {
  StakeDays({Key? key}) : super(key: key);

  final myImageAndCaption = [
    ["1460 Days".tr, 1],
    ["730 Days".tr, 2],
    ["365 Days".tr, 3],
    ["90 Days".tr, 4],
    ["Whitelisted  (Staking Period:-  365 Days)".tr, 5],
  ];

  // final List<String> currencys = [
  //   "1460 Days".tr,
  //   "730 Days".tr,
  //   "365 Days".tr,
  //   "90 Days".tr,
  //   "Whitelisted (Staking Period :  365 Days)".tr,
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Select Staking Plan',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              ...myImageAndCaption.map((i) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 7),
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(22)),
                  child: Center(
                      child: ListTile(
                    trailing: const Icon(Icons.circle, color: Colors.blue),
                    title: Text(
                      '${i.first}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Get.back(result: {'plan': i.first, 'id': i.last});
                    },
                  )))),
            ],
          )),
    );
  }
}
