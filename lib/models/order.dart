import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:order_form/import.dart';

part 'order.g.dart';

@CopyWith()
class OrderModel extends Equatable {
  const OrderModel({
    @required this.id,
    @required this.displayName,
    @required this.photoUrl,
    this.additionalItems,
    this.totalCount = 0,
    this.totalCost = 0,
  });

  final String id;
  final String displayName;
  final String photoUrl;
  final List<AdditionalItemModel> additionalItems;
  final int totalCount; // общее количество позиций заказа
  final int totalCost; // общая стоимость в копейках

  @override
  List<Object> get props => [
        id,
        displayName,
        photoUrl,
        additionalItems,
        totalCount,
        totalCost,
      ];

  OrderModel recalc() {
    return _recalcTotalCount()._recalcTotalCost();
  }

  OrderModel _recalcTotalCount() {
    int result = 0;
    for (final item in additionalItems) {
      result = result + item.count;
    }
    return copyWith(totalCount: result);
  }

  OrderModel _recalcTotalCost() {
    int result = 0;
    for (final item in additionalItems) {
      result = result + item.count * item.price;
    }
    return copyWith(totalCost: result);
  }
}
