import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/library_controller.dart';
import 'ink_icon.dart';

class FilterBar extends StatelessWidget {
  FilterBar({
    super.key,
  });

  final libraryController = Get.find<LibraryController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              bottom: 0,
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
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: 0.5.seconds,
              width: double.infinity,
              curve: Curves.decelerate,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage(Constants.decorationFrame),
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.cover,
                    opacity: 0.2),
              ),
              child: GetBuilder<LibraryController>(builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 45,
                    ),
                    Row(
                      children: [
                        InkIcon(
                          ink: Constants.inkSteel,
                          color: Constants.steelColor,
                          selected:
                              libraryController.filterController.color.value ==
                                      "Steel"
                                  ? true
                                  : false,
                          onTap: () {
                            libraryController.filterController
                                .updateColor("Steel");
                            libraryController.update();
                          },
                        ),
                        InkIcon(
                          ink: Constants.inkRuby,
                          color: Constants.rubyColor,
                          selected:
                              libraryController.filterController.color.value ==
                                      "Ruby"
                                  ? true
                                  : false,
                          onTap: () {
                            libraryController.filterController
                                .updateColor("Ruby");
                            libraryController.update();
                          },
                        ),
                        InkIcon(
                          ink: Constants.inkAmber,
                          color: Constants.amberColor,
                          selected:
                              libraryController.filterController.color.value ==
                                      "Amber"
                                  ? true
                                  : false,
                          onTap: () {
                            libraryController.filterController
                                .updateColor("Amber");
                            libraryController.update();
                          },
                        ),
                        InkIcon(
                          ink: Constants.inkEmerald,
                          color: Constants.emeraldColor,
                          selected:
                              libraryController.filterController.color.value ==
                                      "Emerald"
                                  ? true
                                  : false,
                          onTap: () {
                            libraryController.filterController
                                .updateColor("Emerald");
                            libraryController.update();
                          },
                        ),
                        InkIcon(
                          ink: Constants.inkSapphire,
                          color: Constants.sapphireColor,
                          selected:
                              libraryController.filterController.color.value ==
                                      "Sapphire"
                                  ? true
                                  : false,
                          onTap: () {
                            libraryController.filterController
                                .updateColor("Sapphire");
                            libraryController.update();
                          },
                        ),
                        InkIcon(
                          ink: Constants.inkAmethyst,
                          color: Constants.amethystColor,
                          selected:
                              libraryController.filterController.color.value ==
                                      "Amethyst"
                                  ? true
                                  : false,
                          onTap: () {
                            libraryController.filterController
                                .updateColor("Amethyst");
                            libraryController.update();
                          },
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        libraryController.clearLibrary(paginateClear: true);
                        libraryController.paginateLibrary();
                      },
                      icon: Icon(
                        Icons.youtube_searched_for,
                        color: Constants.goldColor.withOpacity(0.5),
                        size: 30,
                      ),
                      highlightColor: Constants.goldColor.withOpacity(0.05),
                      padding: EdgeInsets.all(2),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
        Container(
          height: 5,
          decoration:
              BoxDecoration(color: Constants.goldColor.withOpacity(0.9)),
        ),
      ],
    );
  }
}
