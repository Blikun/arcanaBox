import 'package:get/get.dart';

import '../../models/filters.dart';
part 'filter_state.dart';

class FilterController extends GetxController {
  final FilterState state;
FilterController(this.state);
  void updateType(String? newValue) {
    state.filters.value = state.filters.value.copyWith(type: newValue ?? "Any");
  }

  void updateName(String? newValue) {
    state.filters.value = state.filters.value.copyWith(name: newValue);
  }

  void updateRarity(String? newValue) {
    state.filters.value = state.filters.value.copyWith(rarity: newValue);
  }

  void updateInkable(String? newValue) {
    state.filters.value = state.filters.value.copyWith(inkable: newValue);
  }

  void updateCost(List<int> newValue) {
    state.filters.value = state.filters.value.copyWith(cost: newValue);
  }

  void updateColor(String? newValue) {
    bool remove = state.filters.value.color == newValue;
    state.filters.value = state.filters.value.copyWith(
      color: newValue,
      needClearColor: remove,
    );
  }

  void updateCardNum(int? newValue) {
    state.filters.value = state.filters.value.copyWith(cardNum: newValue);
  }

  void updateSetNum(int? newValue) {
    state.filters.value = state.filters.value.copyWith(setNum: newValue ?? 0);
  }

  void updateAbilities(String? newValue) {
    state.filters.value = state.filters.value.copyWith(abilities: newValue);
  }

  void updateSetName(String? newValue) {
    state.filters.value = state.filters.value.copyWith(setName: newValue);
  }

  void updateBodyText(String? newValue) {
    state.filters.value = state.filters.value.copyWith(bodyText: newValue);
  }

  void updateWillpower(int? newValue) {
    state.filters.value = state.filters.value.copyWith(willpower: newValue ?? -1);
  }

  void updateStrength(int? newValue) {
    state.filters.value = state.filters.value.copyWith(strength: newValue ?? -1);
  }

  void updateLore(int? newValue) {
    state.filters.value = state.filters.value.copyWith(lore: newValue ?? -1);
  }


  void clearAllFilters() {
    state.filters.value = FiltersModel(
      type: "Any",
      cost: [1, 10],
      setNum: 0,
      willpower: -1,
      strength: -1,
      lore: -1,
    );
  }

  bool hasActiveFilters() {
    var currentFilters = state.filters.value;
    return currentFilters.type != "Any" ||
        currentFilters.name != null ||
        currentFilters.rarity != null ||
        currentFilters.inkable != null ||
        currentFilters.cost != [1, 10] ||
        currentFilters.color != null ||
        currentFilters.cardNum != null ||
        currentFilters.setNum != 0 ||
        currentFilters.abilities != null ||
        currentFilters.setName != null ||
        currentFilters.bodyText != null ||
        currentFilters.willpower != -1 ||
        currentFilters.strength != -1 ||
        currentFilters.lore != -1;
  }
}
