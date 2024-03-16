
part of 'filter_controller.dart';


class FilterState {

    final Rx<FiltersModel> filters = Rx<FiltersModel>(FiltersModel(
        type: "Any",
        cost: [1, 10],
        setNum: 0,
        willpower: -1,
        strength: -1,
        lore: -1,
    ));

}
