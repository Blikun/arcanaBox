import 'package:arcana_box/controllers/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:arcana_box/data/api_client/get_cards.dart';
import 'package:arcana_box/models/card.dart';
import 'package:get/get.dart';


class LibraryController extends GetxController {
  final RxList<LCard> library = RxList();
  final lastPageFetched = 0.obs;
  final translationService = Get.put(TranslationService());
  ScrollController scrollController = ScrollController();

  @override
  void onInit(){
    super.onInit();
    fetchPaginated(1);
    addItems();
  }

  void fetchPaginated(int page) async {
    List<LCard> fetchedCards = await GetCards().fetch(page);
    for (LCard card in fetchedCards) {
      if (!library.contains(card)) {
        library.add(card);
      }
    }
    lastPageFetched.value = page;
  }

  addItems() async {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        for (int i = 0; i < 1; i++) {

          print("LOAD");
          fetchPaginated(lastPageFetched.value+1);

        }
      }
    });
  }


 // Future<bool> tryAddTranslation(index) async {
 //   bool connectivity = await InternetConnection().hasInternetAccess;
 //   if (connectivity) {
 //     CardTranslations translations =
 //         await translationService.getTranslate(library[index].bodyText);
 //     library[index].cardTranslations = translations;
 //     return translations != null;
 //   }
 //   return true;
 // }

}