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

  Widget buildInkIcon(Map<String, dynamic> inkData) {
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
            AnimatedContainer(
              duration: 0.5.seconds,
              width: double.infinity,
              curve: Curves.decelerate,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage(Constants.decorationFrame),
                    alignment: Alignment.topCenter,
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
                        for (Map<String, dynamic> inkColor
                            in Constants.inkColors) ...{buildInkIcon(inkColor)}
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
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}
