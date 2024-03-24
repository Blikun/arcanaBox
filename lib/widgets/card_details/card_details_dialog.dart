import 'package:arcana_box/controllers/library_controller/library_controller.dart';
import 'package:arcana_box/models/card.dart';
import 'package:arcana_box/widgets/card_details/enchanted_button.dart';
import 'package:arcana_box/widgets/card_details/enchanted_display_card.dart';
import 'package:arcana_box/widgets/card_details/price_info.dart';
import 'package:arcana_box/widgets/card_details/standard_display_card.dart';
import 'package:arcana_box/widgets/translation_frame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/translation_controller/translation_controller.dart';
import 'dart:math' as math;

class CardDetailsDialog extends StatefulWidget {
  final int index;
  final TranslationController? translationService;

  const CardDetailsDialog(
      {super.key, this.translationService, required this.index});

  @override
  CardDetailsDialogState createState() => CardDetailsDialogState();
}

class CardDetailsDialogState extends State<CardDetailsDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  final LibraryController libraryController = Get.find<LibraryController>();
  final RxBool _showAlternateArt = false.obs;
  final RxBool _rotated = false.obs;
  final RxDouble _dragAmount = 0.0.obs;
  final RxInt _indexDisplacement = 0.obs;
  bool _slideFromRight = false;
  bool _canSwipe = true;
  static const _sensibilityThreshold = 25;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    // Initialize opacity to fully visible
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    // Initialize slide animation with no movement
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      onHorizontalDragStart: (details) {
        _animationController.reset();
        // Prepare slide out effect with initial opacity animation
        _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.easeIn));
        _slideAnimation =
            Tween<Offset>(begin: Offset.zero, end: Offset(-_dragAmount.sign, 0))
                .animate(CurvedAnimation(
                    parent: _animationController, curve: Curves.easeInOut));
      },
      onHorizontalDragUpdate: (details) {
        _dragAmount.value += details.primaryDelta ?? 0.0;
      },
      onHorizontalDragEnd: (details) {
        _slideFromRight = _dragAmount < 0;

        if (_slideFromRight) {
          _canSwipe = (widget.index + 1 + _indexDisplacement.value) < libraryController.state.library.length;
        } else {
          _canSwipe = widget.index -1 + _indexDisplacement.value >= 0;
        }
        if (_dragAmount.abs() > _sensibilityThreshold && _canSwipe) {
          _animationController.forward().then((_) {
            _slideFromRight
                ? {_indexDisplacement.value++}
                : {_indexDisplacement.value--};
            _rotated.value = false;
            _dragAmount.value = 0;
            _showAlternateArt.value = false;
            // Set up slide-in effect with opacity fading in
            _slideAnimation = Tween<Offset>(
              begin: Offset(_slideFromRight ? 1.5 : -1.5, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
                parent: _animationController, curve: Curves.easeOut));

            _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: _animationController, curve: Curves.easeIn));

            _animationController
                .reset(); // Reset the controller to start animations from the beginning
            _animationController
                .forward(); // Start the animations for slide-in and fade-in effects
          });
        } else {
          _dragAmount.value = 0;
        }
      },
      child: Material(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AnimatedBuilder(
            animation: Listenable.merge([_opacityAnimation, _slideAnimation]),
            builder: (context, child) {
              return FadeTransition(
                opacity: _opacityAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Obx(() {
                    int index = widget.index + _indexDisplacement.value;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (index == libraryController.state.library.length - 4 ||
                          index == libraryController.state.library.length - 1) {
                        libraryController.paginateLibrary();
                      }
                    });
                    return animatedSwiper(libraryController.state.library[index]);
                  }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget animatedSwiper(CardModel cardValue) {
    final tiltAngle = _dragAmount / 600;
    const maxTiltRadians = 20 * math.pi / 180;
    final angle =
        math.min(math.max(tiltAngle, -maxTiltRadians), maxTiltRadians);
    return AnimatedScale(
      scale: _rotated.value ? 0.72 : 1,
      curve: Curves.fastEaseInToSlowEaseOut,
      duration: const Duration(milliseconds: 500),
      child: Transform.rotate(
        angle: _rotated.value ? -math.pi / 2 : 0,
        child: Transform.translate(
          offset: Offset(_dragAmount.value, 0),
          child: Transform.rotate(
              angle: angle,
              child: Column(
                children: [
                  cardDisplay(cardValue),
                  const SizedBox(height: 5),
                  if (widget.translationService != null)
                    TranslationFrame(
                        translationService: widget.translationService!,
                        card: cardValue),
                ],
              )),
        ),
      ),
    );
  }

  Widget cardDisplay(CardModel cardValue) {
    return Stack(
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
       // if (cardValue.type == 'Location')
       //   RotateCardButton(
       //       onRotate: () => _rotated.value = !_rotated.value,
       //       rotated: _rotated),
      ],
    );
  }
}
