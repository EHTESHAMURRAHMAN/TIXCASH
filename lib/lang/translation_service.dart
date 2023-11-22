import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tixcash/lang/ch_CH.dart';
import 'package:tixcash/lang/th_TH.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;

  static const fallbackLocale = Locale('kg', 'KG');
  @override
  Map<String, Map<String, String>> get keys => {
        // 'en_US': en_US,
        // 'ru_RU': ru_RU,
        // 'kg_KG': kg_KG,
        // 'tr_TR': tr_TR,
        'ch_CH': ch_CH,
        'th_TH': th_TH,
      };

  Map<String, Map<String, String>> get keys1 => {
        // 'en_US': en_US,
        // 'ru_RU': ru_RU,
        // 'kg_KG': kg_KG,
        // 'tr_TR': tr_TR,
        'ch_CH': ch_CH,
        'th_TH': th_TH,
      };
}