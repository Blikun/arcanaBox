import 'package:arcana_box/controllers/filter_controller/filter_controller.dart';
import 'package:arcana_box/controllers/library_controller/library_controller.dart';
import 'package:arcana_box/screens/library_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/translation_controller/translation_controller.dart';
import 'data/card_data/cards_api_client.dart';

void main() {
  initializeDependencies();
  runApp(const AppMain());
}

void initializeDependencies() {
  CardsApiClient cardsApiClient = CardsApiClient();
  var translationController = TranslationController(TranslationState());
  var filterController = FilterController(FilterState());
  var libraryController = LibraryController(
      LibraryState(), cardsApiClient, filterController, translationController);

  Get.put(translationController);
  Get.put(filterController);
  Get.put(libraryController);
}

class AppMain extends StatelessWidget {
  const AppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ArcanaBox',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: LibraryScreen(),
    );
  }
}
