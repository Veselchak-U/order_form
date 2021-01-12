import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_form/import.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen(this.order);

  final OrderModel order;

  Route getRoute() {
    return MaterialPageRoute(builder: (_) => this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCubit(order),
      lazy: false,
      child: _OrderView(),
    );
  }
}

class _OrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, orderState) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Бланк заказа'),
            centerTitle: true,
          ),
          body: _OrderBody(),
        );
      },
    );
  }
}

class _OrderBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _MainImage(),
          _Header(),
          _AdditionalBlock(),
        ],
      ),
    );
  }
}

class _AdditionalBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    final items = orderCubit.state.order.additionalItems;
    final List<Widget> children = [];

    children.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        children: [
          Text(
            'Дополнительно',
            style: Theme.of(context).textTheme.headline6,
          ),
          Spacer(),
        ],
      ),
    ));
    children.addAll(
      List.generate(
        items.length,
        (index) => _AdditionalElement(items[index]),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        color: Colors.grey[200],
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class _AdditionalElement extends StatelessWidget {
  _AdditionalElement(this.item);

  final AdditionalItemModel item;

  @override
  Widget build(BuildContext context) {
    final imageSize = 40.0;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          CachedNetworkImage(
            width: imageSize,
            height: imageSize,
            fit: BoxFit.cover,
            imageUrl: item.photoUrl,
            errorWidget: (context, url, error) => Placeholder(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                item.displayName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          _CountPicker(item),
          SizedBox(
            width: 60,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '+${item.price ~/ 100} р.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountPicker extends StatelessWidget {
  _CountPicker(this.item);

  final AdditionalItemModel item;

  @override
  Widget build(BuildContext context) {
    final OrderCubit orderCubit = BlocProvider.of<OrderCubit>(context);

    return SizedBox(
      height: 36,
      width: 100,
      child: Stack(
        alignment: AlignmentDirectional.center,
        overflow: Overflow.visible,
        children: [
          Container(
            height: 32,
            width: 64,
            color: Colors.grey[300],
          ),
          Text('${item.count}'),
          Positioned(
            left: 0,
            width: 36,
            child: ElevatedButton(
              onPressed: () {
                orderCubit.removeItem(item);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[300],
                onPrimary: Colors.black,
                shape: CircleBorder(),
              ),
              child: Icon(Icons.remove, size: 18),
            ),
          ),
          Positioned(
            right: 0,
            width: 36,
            child: ElevatedButton(
              onPressed: () {
                orderCubit.addItem(item);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: CircleBorder(),
              ),
              child: Icon(Icons.add, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    final order = orderCubit.state.order;

    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        order.displayName,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}

class _MainImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    final order = orderCubit.state.order;
    final imageWidth = MediaQuery.of(context).size.width;
    final imageHeight = imageWidth * 3 / 4;

    return CachedNetworkImage(
      width: imageWidth,
      height: imageHeight,
      fit: BoxFit.cover,
      imageUrl: order.photoUrl,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
      errorWidget: (context, url, error) => Placeholder(),
    );
  }
}
