import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyLocalController extends GetxController {
  final lang = GetStorage();
  Locale? initailLang;

  @override
  void onInit() {
    super.onInit();
    initailLang = lang.read('lang') == null
        ? Get.deviceLocale!
        : Locale(lang.read('lang'));
  }

  void chageLang(String codeLang) {
    Locale locale = Locale(codeLang);
    lang.write("lang", codeLang);
    Get.updateLocale(locale);
  }
}

class SettingsController extends GetxController {
  late ThemeData themeData;

  final box = GetStorage();

  @override // called when you use Get.put before running app
  void onInit() {
    super.onInit();
    _restoreTheme();
  }

  void _restoreTheme() {
    bool isDark =
        box.read('isDark') ?? true; // null check for first time running this
    if (isDark) {
      themeData = ThemeData.dark(useMaterial3: true);
    } else {
      themeData = ThemeData.light();
    }
  }

  void storeThemeSetting(bool isDark) {
    box.write('isDark', isDark);
  }
}

class ListItem {
  String title;
  bool switchValue;

  ListItem({
    required this.title,
    required this.switchValue,
  });
}

class MyController extends GetxController {
  var list = <ListItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the list with some sample data
    list.value = [
      ListItem(title: 'Item 1', switchValue: false),
      ListItem(title: 'Item 2', switchValue: true),
      ListItem(title: 'Item 3', switchValue: false),
    ];

    // Retrieve the saved switch values from GetStorage
    final box = GetStorage();
    for (final item in list.value) {
      item.switchValue = box.read(item.title) ?? item.switchValue;
    }
  }

  void toggleSwitch(int index) {
    list[index].switchValue = !list[index].switchValue;

    // Save the new switch value to GetStorage
    final box = GetStorage();
    box.write(list[index].title, list[index].switchValue);
  }
}
