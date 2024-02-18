import 'dart:convert';

import '../utils.dart';

List<LCard> cardFromJson(String str) => List<LCard>.from(json.decode(str).map((x) => LCard.fromJson(x)));

String cardToJson(List<LCard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LCard {
  final String? artist;
  final String? setName;
  final String? classifications;
  final String? abilities;
  final int? setNum;
  final String? color;
  final String? image;
  final int? cost;
  final bool? inkable;
  final String? enchantedImage;
  final String? name;
  final String? type;
  final int? lore;
  final String? rarity;
  final int? cardNum;
  final String? bodyText;
  final String? foilImage;
  final int? willpower;
  final int? strength;
  final String? setId;
  final String? flavorText;
  CardTranslations? cardTranslations;

  LCard({
    this.artist,
    this.setName,
    this.classifications,
    this.abilities,
    this.setNum,
    this.color,
    this.image,
    this.cost,
    this.inkable,
    String? enchantedImage,
    this.name,
    this.type,
    this.lore,
    this.rarity,
    this.cardNum,
    this.bodyText,
    this.foilImage,
    this.willpower,
    this.strength,
    this.setId,
    this.flavorText,
    this.cardTranslations,
  }) : enchantedImage = Utils().getEnchantedImage(int.parse("$cardNum$setNum")) ?? enchantedImage; // Use function to determine enchantedImage


  LCard copyWith({
    String? artist,
    String? setName,
    String? classifications,
    String? abilities,
    int? setNum,
    String? color,
    String? image,
    int? cost,
    bool? inkable,
    String? enchantedImage,
    String? name,
    String? type,
    int? lore,
    String? rarity,
    int? cardNum,
    String? bodyText,
    String? foilImage,
    int? willpower,
    int? strength,
    String? setId,
    String? flavorText,
    CardTranslations? cardTranslations,
  }) =>
      LCard(
        artist: artist ?? this.artist,
        setName: setName ?? this.setName,
        classifications: classifications ?? this.classifications,
        abilities: abilities ?? this.abilities,
        setNum: setNum ?? this.setNum,
        color: color ?? this.color,
        image: image ?? this.image,
        cost: cost ?? this.cost,
        inkable: inkable ?? this.inkable,
        enchantedImage: enchantedImage ?? this.enchantedImage,
        name: name ?? this.name,
        type: type ?? this.type,
        lore: lore ?? this.lore,
        rarity: rarity ?? this.rarity,
        cardNum: cardNum ?? this.cardNum,
        bodyText: bodyText ?? this.bodyText,
        foilImage: foilImage ?? this.foilImage,
        willpower: willpower ?? this.willpower,
        strength: strength ?? this.strength,
        setId: setId ?? this.setId,
        flavorText: flavorText ?? this.flavorText,
        cardTranslations: cardTranslations ?? this.cardTranslations
      );


  factory LCard.fromJson(Map<String, dynamic> json) => LCard(
    artist: json["Artist"],
    setName: json["Set_Name"],
    classifications: json["Classifications"],
    abilities: json["Abilities"],
    setNum: json["Set_Num"],
    color: json["Color"],
    image: json["Image"],
    cost: json["Cost"],
    inkable: json["Inkable"],
    enchantedImage: json["Enchanted_Image"],
    name: json["Name"],
    type: json["Type"],
    lore: json["Lore"],
    rarity: json["Rarity"],
    cardNum: json["Card_Num"],
    bodyText: json["Body_Text"],
    foilImage: json["Foil_Image"],
    willpower: json["Willpower"],
    strength: json["Strength"],
    setId: json["Set_ID"],
    flavorText: json["Flavor_Text"],
  );

  Map<String, dynamic> toJson() => {
    "Artist": artist,
    "Set_Name": setName,
    "Classifications": classifications,
    "Abilities": abilities,
    "Set_Num": setNum,
    "Color": color,
    "Image": image,
    "Cost": cost,
    "Inkable": inkable,
    "Enchanted_Image": enchantedImage,
    "Name": name,
    "Type": type,
    "Lore": lore,
    "Rarity": rarity,
    "Card_Num": cardNum,
    "Body_Text": bodyText,
    "Foil_Image": foilImage,
    "Willpower": willpower,
    "Strength": strength,
    "Set_ID": setId,
    "Flavor_Text": flavorText,
  };
}


class CardTranslations {
  String? bodyText;

  CardTranslations({this.bodyText});
}