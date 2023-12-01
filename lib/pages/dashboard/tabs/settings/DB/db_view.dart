import 'package:flutter/cupertino.dart';
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

  Future<void> addData() async {
    if (titleController.text.isEmpty) {
      EasyLoading.showToast('Enter Name');
      return;
    }

    if (descController.text.isEmpty) {
      EasyLoading.showToast('Enter Address');
      return;
    }

    await SQLHELPER.createData(
      titleController.text,
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

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData = allData.firstWhere((element) => element['id'] == id);
      titleController.text = existingData['title'];

      descController.text = existingData['desc'];
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text('Wallet Address'),
              centerTitle: true,
            ),
            body: ListView(
              children: [
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 25),
                        // Container(
                        //   height: 60,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       border: Border.all(
                        //           color: Theme.of(context).primaryColor)),
                        //   child: ListTile(
                        //     title: Text(
                        //       'Select Network',
                        //       style: TextStyle(fontSize: 13),
                        //     ),
                        //     trailing: Icon(Icons.arrow_drop_down_circle,
                        //         color: Theme.of(context).primaryColor),
                        //   ),
                        // ),
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
                                  child: Text(id == null ? "Save" : "Update",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Address Book',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    height: 85,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: Center(
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              if (widget.checkId == 1) {
                                Get.back(result: {
                                  'address': allData[index]['desc'],
                                });
                              }
                            });
                          },
                          leading: const Icon(Icons.save, size: 25),
                          title: Text(allData[index]['title'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          trailing: IconButton(
                              onPressed: () {
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
                                                      showBottomSheet(
                                                          allData[index]['id']);
                                                    },
                                                    child: const Text('Update',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: Colors.red,
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
                                                    child: const Text('Delete',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  )
                                                ],
                                              ),
                                            ])));
                              },
                              icon: const Icon(Icons.arrow_forward_ios,
                                  size: 18)),
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
