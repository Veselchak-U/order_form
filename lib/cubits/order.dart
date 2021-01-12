import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_form/import.dart';

part 'order.g.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(OrderModel order) : super(OrderState(order: order));
}

enum OrderStatus { invalid, downloading, error, valid }

@CopyWith()
class OrderState extends Equatable {
  const OrderState({
    this.status = OrderStatus.invalid,
    this.order,
  });

  final OrderStatus status;
  final OrderModel order;

  @override
  List<Object> get props => [
        status,
        order,
      ];
}
