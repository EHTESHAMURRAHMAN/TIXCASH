import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/shared/constants/colors.dart';

class SelectProfile extends StatefulWidget {
  final bool isSelected;
  final String name;
  // final String balance;
  final Function(bool) onSelect;
  final Function(String) onEdit;
  final Function(String) onDelete;
  const SelectProfile(
      {Key? key,
      this.isSelected = false,
      required this.name,
      required this.onSelect,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  @override
  State<SelectProfile> createState() => _SelectProfileState();
}

class _SelectProfileState extends State<SelectProfile> {
  String _userName = '';

  List<Color> colors = [
    Colors.teal,
    Colors.pink,
    Colors.deepPurple,
    Colors.blue
  ];

  @override
  void initState() {
    super.initState();
    _userName = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            height: 65,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Colors.grey.shade300
                  ],
                ),
                borderRadius: BorderRadius.circular(32)),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    Icons.account_circle,
                    size: 37,
                    color: colors[widget.name.length % 4],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_userName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    const SizedBox(
                      height: 8,
                    ),

                    widget.isSelected
                        ? IconButton(
                            onPressed: () {
                              editNameDialog(context, () {
                                widget.onEdit(_userName);
                                Get.back();
                                if (mounted) setState(() {});
                              });
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ))
                        : const SizedBox()
                    // Text(widget.balance, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
                  ],
                )),
                widget.isSelected
                    ? const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 28,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          deleteUserDialog(context, () {
                            widget.onDelete(_userName);
                            Get.back();
                          });
                        },
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                          size: 28,
                        ))
              ],
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16),
          //   child: Divider(
          //     color: Colors.black12,
          //   ),
          // ),
        ],
      ),
      onTap: () {
        widget.onSelect(true);
      },
    );
  }

  void editNameDialog(context, Function() onConfirm) {
    final TextEditingController _editingController = TextEditingController();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
              backgroundColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    color: ColorConstants.secondaryDarkAppColor,
                    height: 50,
                    child: Text(
                      'Enter account name'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: _editingController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: 'Name'.tr,
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: InputBorder.none),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 2,
                      color: ColorConstants.secondaryDarkAppColor,
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () => Get.back(),
                          child: Text('Cancel'.tr)),
                      const SizedBox(
                        width: 16,
                      ),
                      TextButton(
                          onPressed: () {
                            if (_editingController.text.isEmpty) {
                              EasyLoading.showToast('Enter account name'.tr);
                            } else {
                              userInfo?.name = _editingController.text;
                              _userName = _editingController.text;
                            }
                            // // if(userInfo!.password !=_editingController.text.trim()){
                            // if(userPassword.isEmpty || userPassword !=_editingController.text.trim()){
                            //   EasyLoading.showToast('Enter correct password'.tr);
                            // }else{
                            onConfirm();
                            //   // Get.offAndToNamed(Routes.HOME);
                            // }
                          },
                          child: Text('Change'.tr)),
                      const SizedBox(
                        width: 8,
                      )
                    ],
                  )
                ],
              ),
            ));
  }

  void deleteUserDialog(context, Function() onConfirm) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              backgroundColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        'Delete Account'.tr,
                        style: GoogleFonts.roboto(
                            color: ColorConstants.secondaryDarkAppColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Are you sure want to delete your account?\nHave you taken your backup?'
                        .tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ColorConstants.secondaryDarkAppColor,
                            // side: BorderSide(
                            //     color: ColorConstants.secondaryDarkAppColor
                            //         .withOpacity(.5)),
                            shape: const BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            shadowColor: Colors.lightBlue,
                          ),
                          child: Text('Cancel'.tr),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        ElevatedButton(
                          onPressed: () => onConfirm(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ColorConstants.secondaryDarkAppColor,
                            // side: BorderSide(
                            //     color: ColorConstants.secondaryDarkAppColor
                            //         .withOpacity(.5)),
                            shape: const BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            shadowColor: Colors.lightBlue,
                          ),
                          child: Text('Delete'.tr),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
