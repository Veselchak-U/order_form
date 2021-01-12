import 'package:order_form/import.dart';

class OrderModel {
  const OrderModel({
    this.id,
    this.displayName,
    this.photoUrl,
    this.additionalItems,
    this.totalCost,
  });

  final String id;
  final String displayName;
  final String photoUrl;
  final List<AdditionalItemModel> additionalItems;
  final int totalCost; // общая стоимость  в копейках
}
