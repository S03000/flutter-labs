class CurrencyPair {
  final String from;
  final String to;

  CurrencyPair(this.from, this.to);

  @override
  bool operator ==(Object other) =>
      other is CurrencyPair && from == other.from && to == other.to;

  @override
  int get hashCode => from.hashCode ^ to.hashCode;

  Map<String, dynamic> toJson() => {'from': from, 'to': to};

  static CurrencyPair fromJson(Map<String, dynamic> json) =>
      CurrencyPair(json['from'] as String, json['to'] as String);
}