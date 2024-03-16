import 'package:arcana_box/controllers/library_controller/library_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../widgets/card_grid.dart';
import '../widgets/filter_bar.dart';

class LibraryScreen extends StatelessWidget {
  final libraryController = Get.find<LibraryController>();

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
                if (libraryController.state.commState.value == CommState.loading)
                  LinearProgressIndicator(
                    color: libraryController.filterController.state.filters.value.color !=
                        null
                        ? Constants.inkColors.firstWhere((element) =>
                    element['name'] ==
                        libraryController.filterController.state.filters.value.color)['color']
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

