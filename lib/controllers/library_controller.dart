import 'package:arcana_box/controllers/translation_service.dart';
import 'package:arcana_box/data/api_client/fetch_cards.dart';
import 'package:arcana_box/models/card.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class LibraryController extends GetxController {
  final library = [].obs;
  final translationService = Get.put(TranslationService());

  @override
  void onInit(){
    super.onInit();
    getLibrary();
  }

  void getLibrary() async {
    library.value = await FetchCards().all();
  }

  Future<bool> tryAddTranslation(index) async {
    bool connectivity = await InternetConnection().hasInternetAccess;
    if (connectivity) {
      CardTranslations translations =
          await translationService.getTranslate(library[index]);
      library[index].cardTranslations = translations;
      return translations != null;
    }
    return true;
  }

}