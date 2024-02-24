import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/library_controller.dart';
import 'cost_slider.dart';
import 'ink_icon.dart';

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
        libraryController.clearLibrary(paginateClear: true);
        libraryController.paginateLibrary();
        libraryController.update();
      },
    );
  }

  final _height = 50.0.obs;
  final _opened = false.obs;

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
                  AnimatedContainer(
                    duration: 0.5.seconds,
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
                            libraryController.clearLibrary(paginateClear: true);
                            libraryController.paginateLibrary();
                            libraryController.update();
                          },
                          icon: Icon(
                            Icons.youtube_searched_for,
                            color: Constants.goldColor.withOpacity(0.5),
                            size: 25,
                          ),
                          highlightColor: Constants.goldColor.withOpacity(0.05),
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
                                ? _height.value = 220
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
                          highlightColor: Constants.goldColor.withOpacity(0.05),
                        ),
                      ],
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
                        label: "Cost",
                        max: 10,
                        getValue: () => libraryController.filterController.cost,
                        setValue: (newValues) => libraryController
                            .filterController
                            .updateCost(newValues),
                      ),
                    ),
                    Flexible(
                      child: FilterSlider(
                        label: "Lore",
                        max: 5,
                        getValue: () => libraryController.filterController.lore,
                        setValue: (newValues) => libraryController
                            .filterController
                            .updateLore(newValues),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
