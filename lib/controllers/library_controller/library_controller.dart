import 'dart:developer';

import 'package:arcana_box/constants.dart';
import 'package:arcana_box/controllers/filter_controller/filter_controller.dart';
import 'package:arcana_box/controllers/translation_controller/translation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../data/api/api_client.dart';
import '../../models/card.dart';

part 'library_state.dart';

class LibraryController extends GetxController {
  final ApiClient apiClient;
  final LibraryState state;
  final FilterController filterController;
  final TranslationController translationController;

  LibraryController(this.state, this.apiClient, this.filterController, this.translationController);

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    filterController.clearAllFilters();
    paginationListener();
    Future.delayed(const Duration(milliseconds: 250), () {
      searchPaginated(1);
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
    if (state.commState.value != CommState.idle) return;
    log("paginateLibrary");
    searchPaginated(state.lastPageFetched.value + 1);
  }

  void searchPaginated(int page) async {
    if (state.commState.value != CommState.idle) return;
    log("searchFilterPaginated: $page");
    state.commState.value = CommState.loading;

    List<CardModel> searchedCards =
        await apiClient.searchFilterCard(filterController.state.filters.value, page);
    for (CardModel card in searchedCards) {
      if (!state.library.contains(card)) {
        state.library.add(card);
      }
    }
    state.lastPageFetched.value = page;
    log("done");
    state.commState.value = CommState.idle;
  }

  void refreshLibrary() {
    clearLibrary(paginateClear: true);
    paginateLibrary();
    update();
  }

  void clearLibrary({bool paginateClear = false}) {
    state.library.clear();
    if (paginateClear) state.lastPageFetched.value = 0;
  }
}
