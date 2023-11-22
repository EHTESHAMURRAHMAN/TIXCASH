import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixcash/shared/constants/storage.dart';
import 'package:tixcash/shared/utils/focus.dart';

import 'd_apps_controller.dart';
import 'trone_browser.dart';

class SearchPage extends GetView<DAppsController> {
  final String url;
  const SearchPage({
    Key? key,
    this.url = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String textValue = url;
    controller.searchController.text = url;
    AppFocus.focus(context, controller.mFocus);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller.searchController,
          focusNode: controller.mFocus,
          keyboardType: TextInputType.url,
          onChanged: (val) {
            textValue = val;
            controller.isSearch.value = true;
            controller.getHistoryList(val);
          },
          onSubmitted: (val) {
            _onSubmit(context, val);
          },
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: 'Search or Type URL',
              hintStyle: const TextStyle(color: Colors.white30),
              border: InputBorder.none,
              // suffixIcon: Icon(Icons.search),
              suffix: GestureDetector(
                  onTap: () {
                    controller.searchController.text = '';
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                    size: 24,
                  ))),
        ),
      ),
      body: Obx(() => Column(
            children: List.generate(
                controller.historyList.length,
                (index) => ListTile(
                      title: Text(
                        controller.historyList.elementAt(index),
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        _onSubmit(
                            context, controller.historyList.elementAt(index));
                      },
                    )),
          )),
    );
  }

  _onSubmit(context, String val) {
    String url = val;
    if (!val.toString().contains('http')) {
      url = 'https://$url';
    } else if (!val.toString().contains('https')) {
      url = val.replaceFirst('http', 'https');
    }
    controller.saveLastOpen(url);
    Get.back(result: url);
  }
}
