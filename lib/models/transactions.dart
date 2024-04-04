class Transactions {
  final String type;
  final double amount;
  final DateTime time;
  final String category;

  Transactions({
    required this.type,
    required this.amount,
    required this.time,
    required this.category
  });

  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
        type: json['type'],
        amount: json['amount'].toDouble(),
        time: DateTime.parse(json['time']),
        category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'type': type,
      'amount': amount,
      'time': time.toIso8601String(),
      'category': category
    };
  }
}
