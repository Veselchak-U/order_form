import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_form/import.dart';

class PreOrderScreen extends StatelessWidget {
  Route getRoute() {
    return MaterialPageRoute(builder: (_) => this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PreOrderCubit(),
      lazy: false,
      child: _PreOrderView(),
    );
  }
}

class _PreOrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preOrderCubit = BlocProvider.of<PreOrderCubit>(context);
    return BlocListener<PreOrderCubit, PreOrderState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, preOrderState) {
        if (preOrderState.status == PreOrderStatus.valid) {
          preOrderCubit.resetStatus();
          // final List<AdditionalItemModel> additionalItems =
          //     kStubAdditionalItems.take(preOrderState.positionCount);
          final order = OrderModel(
            id: '${DateTime.now()}',
            displayName: 'Произвольный текст как заголовок',
            photoUrl: preOrderState.photoUrl,
            additionalItems:
                kStubAdditionalItems.take(preOrderState.positionCount).toList(),
          );
          navigator.push(OrderScreen(order).getRoute());
        }
      },
      child: _PreOrderBody(),
    );
  }
}

class _PreOrderBody extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final preOrderCubit = BlocProvider.of<PreOrderCubit>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Параметры заказа',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '* URL фото',
                    helperText: '',
                  ),
                  initialValue: preOrderCubit.state.photoUrl,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.url,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => preOrderCubit.validateUrl(value),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '* Количество позиций',
                    helperText: '',
                  ),
                  initialValue: '${preOrderCubit.state.positionCount}',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => preOrderCubit.validateCount(value),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      preOrderCubit.tryCacheImageFile();
                    }
                  },
                  child: _ButtonContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: BlocProvider.of<PreOrderCubit>(context),
      builder: (context, PreOrderState preOrderState) {
        Widget result;
        if (preOrderState.status == PreOrderStatus.downloading) {
          result = SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              value: preOrderState.downloadProgress,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        } else if (preOrderState.status == PreOrderStatus.error) {
          result = Text('Ошибка загрузки URL');
        } else {
          result = Text('Перейти к заказу');
        }
        return Container(
          width: 200,
          height: 40,
          color: preOrderState.status == PreOrderStatus.error
              ? Colors.red
              : Colors.blue,
          child: Center(
            child: result,
          ),
        );
      },
    );
  }
}
