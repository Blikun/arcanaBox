
part of 'library_controller.dart';


class LibraryState {

    final commState = CommState.idle.obs;

    final RxList<CardModel> library = RxList();

    final lastPageFetched = 0.obs;

}
