import 'package:arcana_box/controllers/library_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../widgets/card_grid.dart';

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
              child: CardGrid()
                  .animate(effects: [
                const FadeEffect(duration: Duration(seconds: 2))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
