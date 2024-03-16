
class FiltersModel {
  String? type;
  String? name;
  String? rarity;
  String? inkable;
  List<int>? cost;
  String? color;
  int? cardNum;
  int? setNum;
  String? abilities;
  String? setName;
  String? bodyText;
  int? willpower;
  int? strength;
  int? lore;

  FiltersModel({
    this.type,
    this.name,
    this.rarity,
    this.inkable,
    this.cost,
    this.color,
    this.cardNum,
    this.setNum,
    this.abilities,
    this.setName,
    this.bodyText,
    this.willpower,
    this.strength,
    this.lore,
  });

  FiltersModel copyWith({
    String? type,
    String? name,
    String? rarity,
    String? inkable,
    List<int>? cost,
    String? color,
    int? cardNum,
    int? setNum,
    String? abilities,
    String? setName,
    String? bodyText,
    int? willpower,
    int? strength,
    int? lore,
  }) {
    return FiltersModel(
      type: type ?? this.type,
      name: name ?? this.name,
      rarity: rarity ?? this.rarity,
      inkable: inkable ?? this.inkable,
      cost: cost ?? this.cost,
      color: color ?? this.color,
      cardNum: cardNum ?? this.cardNum,
      setNum: setNum ?? this.setNum,
      abilities: abilities ?? this.abilities,
      setName: setName ?? this.setName,
      bodyText: bodyText ?? this.bodyText,
      willpower: willpower ?? this.willpower,
      strength: strength ?? this.strength,
      lore: lore ?? this.lore,
    );
  }
}
