import 'package:arcana_box/controllers/translation_service.dart';
import 'package:arcana_box/data/api_client/fetch_cards.dart';
import 'package:arcana_box/models/card.dart';
import 'package:get/get.dart';

class LibraryController extends GetxController {
  final library = [].obs;
  final translationController = Get.put(TranslationService());

  @override
  void onInit(){
    super.onInit();
    getLibrary();
  }

  void getLibrary() async {
    library.value = await FetchCards().all();
  }

  Future<bool> tryAddTranslation(index) async {
    CardTranslations translations = await translationController.getTranslate(library.value[index]);
    library.value[index].cardTranslations =  translations;
    return translations != null;
  }

}