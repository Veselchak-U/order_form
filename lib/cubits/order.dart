import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_form/import.dart';

part 'order.g.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({
    @required String photoUrl,
    @required int positionCount,
    @required List<AdditionalItemModel> additionalItems,
  }) : super(OrderState(
          photoUrl: photoUrl,
          positionCount: positionCount,
          additionalItems: additionalItems,
        ));
}

enum OrderStatus { invalid, downloading, error, valid }

@CopyWith()
class OrderState extends Equatable {
  const OrderState({
    this.status = OrderStatus.invalid,
    this.photoUrl,
    this.positionCount,
    this.additionalItems,
  });

  final OrderStatus status;
  final String photoUrl;
  final int positionCount;
  final List<AdditionalItemModel> additionalItems;

  @override
  List<Object> get props => [
        status,
        photoUrl,
        positionCount,
        additionalItems,
      ];
}
