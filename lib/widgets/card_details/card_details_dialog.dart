import 'dart:developer';

import 'package:arcana_box/controllers/library_controller/library_controller.dart';
import 'package:arcana_box/models/card.dart';
import 'package:arcana_box/widgets/card_details/enchanted_button.dart';
import 'package:arcana_box/widgets/card_details/enchanted_display_card.dart';
import 'package:arcana_box/widgets/card_details/price_info.dart';
import 'package:arcana_box/widgets/card_details/rotate_card_button.dart';
import 'package:arcana_box/widgets/card_details/standard_display_card.dart';
import 'package:arcana_box/widgets/translation_frame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/translation_controller/translation_controller.dart';
import 'dart:math' as math;

class CardDetailsDialog extends StatefulWidget {
  final int index;
  final TranslationController? translationService;

  const CardDetailsDialog({super.key, this.translationService, required this.index});

  @override
  CardDetailsDialogState createState() => CardDetailsDialogState();
}

class CardDetailsDialogState extends State<CardDetailsDialog> {
  final LibraryController libraryController = Get.find<LibraryController>();
  final RxBool _showAlternateArt = false.obs;
  final RxBool _rotated = false.obs;
  int _indexDisplacement = 0;
  static const _sensibilityThreshold = 25;
  double _dragAmount = 0.0; // Tracks the amount of horizontal drag delta

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      onHorizontalDragStart: (details) {},
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragAmount += details.primaryDelta ?? 0.0; // Update the drag delta
        });
      },
      onHorizontalDragEnd: (details) {
        if (_dragAmount.abs() > _sensibilityThreshold) {
          if (_dragAmount < 0 &&
              _indexDisplacement < libraryController.state.library.length) {
            _indexDisplacement++;
            log('Dragged left $_indexDisplacement');
          } else if (_dragAmount > 0 && _indexDisplacement + widget.index > 0) {
            _indexDisplacement--;
            log('Dragged right $_indexDisplacement');
          }
        }
        _showAlternateArt.value = false;
        _dragAmount = 0.0; // Reset drag delta

        // Trigger the exit animation and load the next/previous card
        Builder(builder: (BuildContext context){
          _animateCardExit(context, _dragAmount < 0 ? -1 : 1);
          return SizedBox();

        },);
      },
      child: Material(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            int newIndex = widget.index + _indexDisplacement;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (newIndex == libraryController.state.library.length - 4 ||
                  newIndex == libraryController.state.library.length - 1) {
                libraryController.paginateLibrary();
              }
            });
            final cardValue = libraryController.state.library[newIndex];
            return Column(
              children: [
                cardDisplay(cardValue),
                const SizedBox(height: 5),
                if (widget.translationService != null)
                  TranslationFrame(
                      translationService: widget.translationService!,
                      card: cardValue),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget cardDisplay(CardModel cardValue) {
    return AnimatedScale(
      scale: _rotated.isTrue ? 0.72 : 1,
      curve: Curves.fastEaseInToSlowEaseOut,
      duration: const Duration(milliseconds: 500),
      child: Transform.rotate(
        angle: _rotated.isTrue ? -math.pi / -2 : 0,
        child: Transform.translate(
          // Translate the card based on the drag delta for a swiping effect
          offset: Offset(_dragAmount, 0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Obx(() => _showAlternateArt.isTrue
                    ? EnchantedDisplayCard(card: cardValue)
                    : StandardDisplayCard(card: cardValue)),
              ),
              PriceInfoDetails(card: cardValue),
              if (cardValue.enchantedImage?.isNotEmpty ?? false)
                EnchantedButton(
                    onToggle: () => _showAlternateArt.toggle(),
                    showAlternateArt: _showAlternateArt),
              if (cardValue.type == 'Location')
                RotateCardButton(
                    onRotate: () => _rotated.value = !_rotated.value,
                    rotated: _rotated),
            ],
          ),
        ),
      ),
    );
  }

  void _animateCardExit(BuildContext context, int direction) {
// Start the exit animation
    AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: Scaffold.of(context),
    );
    Animation<Offset> offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(direction.toDouble(), 0.0),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    controller.addListener(() {
      setState(() {
        _dragAmount =
            offsetAnimation.value.dx * MediaQuery.of(context).size.width;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          // Reset drag delta
          _dragAmount = 0.0;
          // Load the next or previous card
          int newIndex = widget.index + _indexDisplacement;
          if (newIndex >= 0 &&
              newIndex < libraryController.state.library.length) {
            // Update the state to show the new card
          } else {
            // Handle the edge case where there are no more cards to show
          }
        });
        controller.dispose();
      }
    });

    controller.forward();
  }
}
