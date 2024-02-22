
import 'package:arcana_box/constants.dart';
import 'package:arcana_box/controllers/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:arcana_box/data/api_client/get_cards.dart';
import 'package:get/get.dart';

import '../data/models/card.dart';


class LibraryController extends GetxController {
  final commState = CommState.idle.obs;
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
    if (commState.value != CommState.idle) return;
    print("loading page: $page");
    commState.value = CommState.loading;
    List<LCard> fetchedCards = await GetCards().fetch(page);
    for (LCard card in fetchedCards) {
      if (!library.contains(card)) {
        library.add(card);
      }
    }
    print("loading done: $page");
    lastPageFetched.value = page;
    commState.value = CommState.idle;
  }

  addItems() async {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent - 250 <= scrollController.position.pixels) {
          fetchPaginated(lastPageFetched.value+1);
      }
    });
  }

}