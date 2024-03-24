

class CardTranslation {
  final int cardId;
  final String? bodyText;

  CardTranslation({required this.cardId, this.bodyText});

  CardTranslation copyWith({
    required int cardId,
    String? bodyText,
  }) =>
      CardTranslation(
          cardId: cardId,
          bodyText: bodyText ?? this.bodyText);
}
