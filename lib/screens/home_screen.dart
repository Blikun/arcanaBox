import 'package:arcana_box/controllers/library_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../widgets/card_details_dialog.dart';
import '../widgets/card_preview.dart';

class HomeScreen extends StatelessWidget {
  final libraryController = Get.put(LibraryController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GetX<LibraryController>(
                builder: (controller) {
                  return GridView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: controller.library.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 693 / 968,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Animate(
                            effects: const [FadeEffect()],
                            child: CardPreview(
                              image: controller.library[index].image,
                              enchantedMark: (controller
                                          .library[index].enchantedImage !=
                                      "" &&
                                  controller.library[index].enchantedImage !=
                                      null),
                              onTap: () {
                                Get.dialog(CardDetails(
                                    card: controller.library[index]));
                              },
                            ));
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
