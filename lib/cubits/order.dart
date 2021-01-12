import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_form/import.dart';

part 'order.g.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(OrderModel order) : super(OrderState(order: order));

  void addItem(AdditionalItemModel item) {
    if (item.count == 20) {
      return;
    }
    final newItem = item.copyWith(count: item.count + 1);
    final newOrder = state.order;
    final index = newOrder.additionalItems.indexOf(item);
    newOrder.additionalItems[index] = newItem;
    emit(state.copyWith(order: newOrder.recalc()));
  }

  void removeItem(AdditionalItemModel item) {
    if (item.count == 0) {
      return;
    }
    final newItem = item.copyWith(count: item.count - 1);
    final newOrder = state.order;
    final index = newOrder.additionalItems.indexOf(item);
    newOrder.additionalItems[index] = newItem;
    emit(state.copyWith(order: newOrder.recalc()));
  }
}

enum OrderStatus { ready }

@CopyWith()
class OrderState extends Equatable {
  const OrderState({
    this.status = OrderStatus.ready,
    this.order,
    this.totalCount,
    this.totalCost,
  });

  final OrderStatus status;
  final OrderModel order;
  final int totalCount;
  final int totalCost;

  @override
  List<Object> get props => [
        status,
        order,
        totalCount,
        totalCost,
      ];
}
