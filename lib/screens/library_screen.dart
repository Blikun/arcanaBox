import 'package:arcana_box/controllers/library_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../widgets/card_grid.dart';
import '../widgets/filter_bar.dart';

class LibraryScreen extends StatelessWidget {
  final libraryController = Get.put(LibraryController());

  LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 2,),
            Expanded(
              child: CardGrid().animate(
                  effects: [const FadeEffect(duration: Duration(seconds: 2))]),
            ),
            const SizedBox(height: 1),
            Obx(() {
              return Stack(children: [
                FilterBar(),
                if (libraryController.commState.value == CommState.loading)
                  LinearProgressIndicator(
                    color: libraryController.filterController.color.value !=
                        null
                        ? Constants.inkColors.firstWhere((element) =>
                    element['name'] ==
                        libraryController.filterController.color.value)['color']
                        : Constants.goldColor,
                    backgroundColor: Colors.transparent,
                    minHeight: 3,
                  ),
              ],);
            })

          ],
        ),
      ),
    );
  }
}

