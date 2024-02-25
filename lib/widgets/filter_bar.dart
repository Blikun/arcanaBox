import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/library_controller.dart';
import 'filter_slider.dart';
import 'ink_icon.dart';

final _height = 50.0.obs;
final _opened = false.obs;

class FilterBar extends StatelessWidget {
  FilterBar({
    super.key,
  });

  final libraryController = Get.find<LibraryController>();

  Widget _buildInkIcon(Map<String, dynamic> inkData) {
    return InkIcon(
      ink: inkData['ink'],
      color: inkData['color'],
      selected:
          libraryController.filterController.color.value == inkData['name'],
      onTap: () {
        libraryController.filterController.updateColor(inkData['name']);
        libraryController.refreshLibrary();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 3,
          decoration:
              BoxDecoration(color: Constants.goldColor.withOpacity(0.3)),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Constants.goldColor.withOpacity(0.15),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Center(
              child: GetBuilder<LibraryController>(builder: (controller) {
                return Stack(children: [
                  GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (details.delta.dy < -10) {
                        _opened.value = true;
                        _height.value = 285;
                      }
                      if (details.delta.dy > 10) {
                        _opened.value = false;
                        _height.value = 50;
                      }
                      libraryController.update();
                    },
                    child: AnimatedContainer(
                      duration: 0.4.seconds,
                      width: double.infinity,
                      curve: Curves.decelerate,
                      height: _height.value,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: AssetImage(Constants.decorationFrame),
                            alignment: Alignment.topCenter,
                            fit: BoxFit.fitWidth,
                            opacity: 0.2),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              libraryController.filterController.clearAllFilters();
                              libraryController.refreshLibrary();
                            },
                            icon: Icon(
                              Icons.youtube_searched_for,
                              color: Constants.goldColor.withOpacity(0.5),
                              size: 25,
                            ),
                            highlightColor:
                                Constants.goldColor.withOpacity(0.05),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Row(
                              children: [
                                for (Map<String, dynamic> inkColor in Constants
                                    .inkColors) ...{_buildInkIcon(inkColor)}
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _opened.value = !_opened.value;
                              _opened.isTrue
                                  ? _height.value = 285
                                  : _height.value = 50;
                              libraryController.update();
                            },
                            icon: Icon(
                              _opened.isTrue
                                  ? Icons.expand_more_outlined
                                  : Icons.expand_less_outlined,
                              color: Constants.goldColor.withOpacity(0.5),
                              size: 30,
                            ),
                            highlightColor:
                                Constants.goldColor.withOpacity(0.05),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]);
              }),
            ),
            Positioned(
                top: 50,
                child: Text(
                  "Ink type",
                  style: Constants.cabinStyle
                      .copyWith(color: Constants.goldColor.withOpacity(0.8)),
                )),
            Positioned(
              top: 70,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Flexible(
                      child: FilterSlider(
                        range: true,
                        label: "Cost",
                        min: 1,
                        max: 10,
                        getValue: () => libraryController.filterController.cost,
                        setValue: (newValues) => libraryController
                            .filterController
                            .updateCost(newValues),
                        onChanged: ()=>libraryController.refreshLibrary(),
                      ),
                    ),
                    Flexible(
                      child: FilterSlider(
                        type: 3,
                        range: false,
                        label: "Lore",
                        min: -1,
                        max: 5,
                        getValue: () => libraryController.filterController.lore,
                        setValue: (newValue) => libraryController
                            .filterController
                            .updateLore(newValue[0]),
                        onChanged: ()=>libraryController.refreshLibrary(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 120,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Flexible(
                      child: FilterSlider(
                        type: 2,
                        range: false,
                        label: "Strength",
                        min: -1,
                        max: 15,
                        getValue: () => libraryController.filterController.strength,
                        setValue: (newValues) => libraryController
                            .filterController
                            .updateStrength(newValues[0]),
                        onChanged: ()=>libraryController.refreshLibrary(),
                      ),
                    ),
                    Flexible(
                      child: FilterSlider(
                        type: 1,
                        range: false,
                        label: "Will",
                        min: -1,
                        max: 15,
                        getValue: () => libraryController.filterController.willpower,
                        setValue: (newValue) => libraryController
                            .filterController
                            .updateWillpower(newValue[0]),
                        onChanged: ()=>libraryController.refreshLibrary(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
