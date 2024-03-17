class PriceDetails {
  final int detailsId;
  final int? priceCents;
  final String? currency;

  PriceDetails({required this.detailsId,this.currency, this.priceCents});

  PriceDetails copyWith({
    required int detailsID,
    int? priceCents,
    String? currency,
  }) =>
      PriceDetails(
          detailsId: detailsID,
          currency: currency ?? this.currency,
          priceCents: priceCents ?? this.priceCents);

  factory PriceDetails.fromCardTraderJson(Map<String, dynamic> json, detailsId) {
    return PriceDetails(
      priceCents: json["price_cents"],
      currency:  json["price"]["currency_symbol"],
      detailsId: detailsId,
    );
  }
}
