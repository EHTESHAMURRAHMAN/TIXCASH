import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/scan_qr.dart';
import 'package:tixcash/pages/dashboard/tabs/send_tyv/send_tyv_view.dart';
import 'package:tixcash/pages/dashboard/tabs/settings/DB/DB_Store.dart';
import 'package:tixcash/pages/dashboard/tabs/settings/settings_controller.dart';
import 'package:tixcash/shared/constants/colors.dart';

class AddressBook extends StatefulWidget {
  final int checkId;
  const AddressBook({super.key, required this.checkId});

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  final SettingsController controller = Get.put(SettingsController());

  List<Map<String, dynamic>> allData = [];
  bool isLoading = true;
  void refreshData() async {
    final data = await SQLHELPER.getAllData();
    setState(() {
      allData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  var dropdownvalue = 'Select Network'.tr;
  var items = [
    "Select Network".tr,
    "TXH",
    "BTC",
    "ETH",
    "BNB",
    "USDC-BEP20",
    "USDT-BEP20",
    "XRP",
    "DASH",
    "DOGE",
    "XLM",
    "OKB",
    "SOL",
    "TRX",
    "MATIC",
  ];
  Future<void> addData() async {
    if (titleController.text.isEmpty) {
      EasyLoading.showToast('Enter Name'.tr);
      return;
    }
    if (dropdownvalue.isEmpty) {
      EasyLoading.showToast('Select Nework'.tr);
      return;
    }
    if (descController.text.length < 22) {
      EasyLoading.showToast('Invalid Address'.tr);
      return;
    }

    await SQLHELPER.createData(
      titleController.text,
      dropdownvalue,
      descController.text,
    );
    titleController.text = "";

    descController.text = "";
    refreshData();
    Navigator.of(context).pop();
  }

  Future<void> updateData(int id) async {
    await SQLHELPER.updateData(
      id,
      titleController.text,
      dropdownvalue,
      descController.text,
    );
    refreshData();
    Navigator.of(context).pop();
  }

  Future<void> deleteData(int id) async {
    await SQLHELPER.deleteData(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Address Deleted".tr),
      backgroundColor: Colors.red,
    ));
    refreshData();
  }

  // String dateOfBirth = '';
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  var network = '';

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData = allData.firstWhere((element) => element['id'] == id);
      titleController.text = existingData['title'];

      descController.text = existingData['addresss'];
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return ListView(
              children: [
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter Name'.tr,
                            style: GoogleFonts.roboto(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                              hintText: 'Enter Name'.tr,
                              hintStyle: const TextStyle(fontSize: 14),
                              labelStyle: const TextStyle(fontSize: 14),
                              label: Text('Enter Name'.tr),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.secondaryAppColor),
                                  borderRadius: BorderRadius.circular(20)),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.secondaryAppColor),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Select Network'.tr,
                            style: GoogleFonts.roboto(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 60,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstants.secondaryAppColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: DropdownButton(
                                    value: dropdownvalue,
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                      });
                                    },
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    underline: Container(),
                                    isExpanded: true,
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter Address'.tr,
                            style: GoogleFonts.roboto(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        InputIconBox(
                          hint: 'Enter Address'.tr,
                          title: ''.tr,
                          image: GestureDetector(
                            child: Text(
                              'PASTE'.tr,
                              style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF40C4FF)),
                            ),
                            onTap: () async {
                              ClipboardData? data =
                                  await Clipboard.getData('text/plain');
                              descController.text = data?.text ?? '';
                              controller.isActived.value =
                                  descController.text.isNotEmpty;
                            },
                          ),

                          //
                          controller: descController,
                          onChange: (value) {
                            controller.isActived.value =
                                descController.text.isNotEmpty;
                          },
                          isScanner: true,
                          onScan: () {
                            controller.isScanEnable.value = true;
                            callOnScan();
                          },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: InkWell(
                            onTap: () async {
                              if (id == null) {
                                await addData();
                              }
                              if (id != null) {
                                await updateData(id);
                              }
                            },
                            child: Container(
                              height: 55,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                      id == null ? "Save".tr : "Update".tr,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Warning ⚠️'.tr,
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Ensure the network matches the withdrawal address and the deposit platform support it, or assets may be lost and never recover.'
                                .tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Colors.red),
                          ),
                        ),
                      ],
                    )),
              ],
            );
          }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Address Book'.tr,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : allData.isEmpty
              ? Center(
                  child: Text('No Address'.tr,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                )
              : ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (context, index) => SizedBox(
                    height: 98,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: Center(
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              if (widget.checkId == 1) {
                                Get.back(result: {
                                  'address': allData[index]['addresss'],
                                });
                              } else {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    elevation: 5,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => Container(
                                        padding: EdgeInsets.only(
                                            top: 30,
                                            left: 15,
                                            right: 15,
                                            bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom +
                                                50),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      showBottomSheet(
                                                          allData[index]['id']);
                                                    },
                                                    child: Text('Update'.tr,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.red,
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    onPressed: () {
                                                      deleteData(
                                                          allData[index]['id']);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Delete'.tr,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  )
                                                ],
                                              ),
                                            ])));
                              }
                            });
                          },
                          leading: IconButton(
                              onPressed: () {},
                              icon:
                                  const Icon(Icons.save_as_rounded, size: 29)),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(allData[index]['title'],
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(allData[index]['currency'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(
                                  allData[index]['addresss']
                                      .replaceRange(6, 20, "..............."),
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_forward_ios,
                                  size: 16)),
                        ),
                      ),
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => showBottomSheet(null),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  callOnScan() async {
    Get.to(const ScanQR())?.then((value) {
      descController.text = value;
      controller.isActived.value = true;
    });
  }
}
