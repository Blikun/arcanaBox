import 'package:get/get.dart';

class FilterController extends GetxController {
  final Rx<String?> type = Rx<String?>(null);
  final Rx<String?> name = Rx<String?>(null);
  final Rx<String?> rarity = Rx<String?>(null);
  final Rx<String?> inkable = Rx<String?>(null);
  final Rx<List<int>> cost = Rx<List<int>>([1,10]);
  final Rx<String?> color = Rx<String?>(null);
  final Rx<int?> cardNum = Rx<int?>(null);
  final Rx<int?> setNum = Rx<int?>(null);
  final Rx<String?> abilities = Rx<String?>(null);
  final Rx<String?> setName = Rx<String?>(null);
  final Rx<String?> bodyText = Rx<String?>(null);
  final Rx<int?> willpower = Rx<int?>(null);
  final Rx<int?> strength = Rx<int?>(null);
  final Rx<List<int>> lore = Rx<List<int>>([0,0]);

  // update values
  void updateType(String? newValue) {
    if (type.value == newValue) {
      type.value = null;
    } else {
      type.value = newValue;
    }
  }

  void updateName(String? newValue) {
    if (name.value == newValue) {
      name.value = null;
    } else {
      name.value = newValue;
    }
  }

  void updateRarity(String? newValue) {
    if (rarity.value == newValue) {
      rarity.value = null;
    } else {
      rarity.value = newValue;
    }
  }

  void updateInkable(String? newValue) {
    if (inkable.value == newValue) {
      inkable.value = null;
    } else {
      inkable.value = newValue;
    }
  }

  void updateCost(List<int> newValue) {
      cost.value = newValue;
  }

  void updateColor(String? newValue) {
    if (color.value == newValue) {
      color.value = null;
    } else {
      color.value = newValue;
    }
  }

  void updateCardNum(int? newValue) {
    if (cardNum.value == newValue) {
      cardNum.value = null;
    } else {
      cardNum.value = newValue;
    }
  }

  void updateSetNum(int? newValue) {
    if (setNum.value == newValue) {
      setNum.value = null;
    } else {
      setNum.value = newValue;
    }
  }

  void updateAbilities(String? newValue) {
    if (abilities.value == newValue) {
      abilities.value = null;
    } else {
      abilities.value = newValue;
    }
  }

  void updateSetName(String? newValue) {
    if (setName.value == newValue) {
      setName.value = null;
    } else {
      setName.value = newValue;
    }
  }

  void updateBodyText(String? newValue) {
    if (bodyText.value == newValue) {
      bodyText.value = null;
    } else {
      bodyText.value = newValue;
    }
  }

  void updateWillpower(int? newValue) {
    if (willpower.value == newValue) {
      willpower.value = null;
    } else {
      willpower.value = newValue;
    }
  }

  void updateStrength(int? newValue) {
    if (strength.value == newValue) {
      strength.value = null;
    } else {
      strength.value = newValue;
    }
  }

  void updateLore(List<int> newValue) {
      lore.value = newValue;
  }

  // clear
  void clearAllFilters() {
    type.value = null;
    name.value = null;
    rarity.value = null;
    inkable.value = null;
    cost.value = [1,10];
    color.value = null;
    cardNum.value = null;
    setNum.value = null;
    abilities.value = null;
    setName.value = null;
    bodyText.value = null;
    willpower.value = null;
    strength.value = null;
    lore.value = [0,0];
  }

  bool hasActiveFilters() {
    return type.value != null ||
        name.value != null ||
        rarity.value != null ||
        inkable.value != null ||
        cost.value != null ||
        color.value != null ||
        cardNum.value != null ||
        setNum.value != null ||
        abilities.value != null ||
        setName.value != null ||
        bodyText.value != null ||
        willpower.value != null ||
        strength.value != null ||
        lore.value != null;
  }
}
