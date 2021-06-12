import 'package:flutter/foundation.dart';

class BudgetItemModel {
  final String name;
  final String category;
  final double price;
  final DateTime date;

  const BudgetItemModel({
    @required this.name,
    @required this.category,
    @required this.price,
    @required this.date,
  });

  factory BudgetItemModel.fromMap(Map<String, dynamic> map) {
    final properties = map['properties'] as Map<String, dynamic>;
    final nameList = properties.containsKey("Name")
        ? (properties['Name']['title'] ?? []) as List
        : [];
    final dateStr = properties.containsKey("Date")
        ? properties['Date']['date']['start']
        : null;
    final category = properties.containsKey("Category")
        ? properties['Category']['select']['name'] ?? 'Any'
        : 'Any';
    final price = properties.containsKey("Price")
        ? (properties['Price']['number'] ?? 0.0).toDouble()
        : 0.0;
    return BudgetItemModel(
      name: nameList.isNotEmpty ? nameList[0]['plain_text'] : '?',
      category: category,
      price: price,
      date: dateStr != null ? DateTime.parse(dateStr) : DateTime.now(),
    );
  }
}
