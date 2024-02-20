import 'package:arcana_box/controllers/translation_service.dart';
import 'package:arcana_box/data/api_client/get_cards.dart';
import 'package:arcana_box/models/card.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class LibraryController extends GetxController {
  final RxList<LCard> library = RxList();
  final translationService = Get.put(TranslationService());

  @override
  void onInit(){
    super.onInit();
    getLibrary();
  }

  void getLibrary() async {
    library.value = await GetCards().fetchPage(1);
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