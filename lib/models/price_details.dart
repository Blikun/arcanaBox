
class PriceDetails {
  final int blueprintId;
  final double? priceCents;
  final String? currency;

  PriceDetails({required this.blueprintId,this.currency, this.priceCents});

  PriceDetails copyWith({
    required int detailsID,
    double? priceCents,
    String? currency,
  }) =>
      PriceDetails(
          blueprintId: detailsID,
          currency: currency ?? this.currency,
          priceCents: priceCents ?? this.priceCents);

}
