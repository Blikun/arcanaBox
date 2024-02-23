import 'package:arcana_box/constants.dart';
import 'package:arcana_box/controllers/FilterController.dart';
import 'package:arcana_box/controllers/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:arcana_box/data/api_client/get_cards.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../data/models/card.dart';

class LibraryController extends GetxController {
  final commState = CommState.idle.obs;
  final RxList<LCard> library = RxList();
  final lastPageFetched = 0.obs;
  final translationService = Get.put(TranslationService());
  ScrollController scrollController = ScrollController();
  FilterController filterController = FilterController();

  @override
  void onInit() {
    super.onInit();
    filterController.clearAllFilters();
    paginationListener();
    Future.delayed(const Duration(milliseconds: 250), () {
      fetchPaginated(1);
    });
  }

  void paginationListener() async {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent - 250 <=
              scrollController.position.pixels &&
          scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        paginateLibrary();
      }
    });
  }

  void paginateLibrary() {
    if (commState.value != CommState.idle) return;
    print("paginateLibrary");
    filterController.hasActiveFilters()
        ? searchFilterPaginated(lastPageFetched.value + 1)
        : fetchPaginated(lastPageFetched.value + 1);
  }

  void fetchPaginated(int page) async {
    if (commState.value != CommState.idle) return;
    print("fetchPaginated: $page");
    commState.value = CommState.loading;

    List<LCard> fetchedCards = await GetCards().fetch(page);
    for (LCard card in fetchedCards) {
      if (!library.contains(card)) {
        library.add(card);
      }
    }
    lastPageFetched.value = page;
    print("done");
    commState.value = CommState.idle;
  }

  void searchFilterPaginated(int page) async {
    if (commState.value != CommState.idle) return;
    print("searchFilterPaginated: $page");
    commState.value = CommState.loading;

    List<LCard> searchedCards = await GetCards().searchFilterCard(
        filterController.type.value,
        filterController.name.value,
        filterController.rarity.value,
        filterController.inkable.value,
        filterController.cost.value,
        filterController.color.value,
        filterController.cardNum.value,
        filterController.setNum.value,
        filterController.abilities.value,
        filterController.setName.value,
        filterController.bodyText.value,
        filterController.willpower.value,
        filterController.strength.value,
        filterController.lore.value,
        page);
    for (LCard card in searchedCards) {
      if (!library.contains(card)) {
        library.add(card);
      }
    }
    lastPageFetched.value = page;
    print("done");
    commState.value = CommState.idle;
  }

  void clearLibrary({bool paginateClear = false}) {
    library.clear();
    if (paginateClear) lastPageFetched.value = 0;
  }
}
