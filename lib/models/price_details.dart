class PriceDetailsModel {
  final int detailsId;
  final int? priceCents;
  final String? currency;

  PriceDetailsModel({required this.detailsId,this.currency, this.priceCents});

  PriceDetailsModel copyWith({
    required int detailsID,
    int? priceCents,
    String? currency,
  }) =>
      PriceDetailsModel(
          detailsId: detailsID,
          currency: currency ?? this.currency,
          priceCents: priceCents ?? this.priceCents);

  factory PriceDetailsModel.fromCardTraderJson(Map<String, dynamic> json, detailsId) {
    return PriceDetailsModel(
      priceCents: json["price_cents"],
      currency:  json["price"]["currency_symbol"],
      detailsId: detailsId,
    );
  }
}
