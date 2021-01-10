import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_form/import.dart';

class PreOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        final preOrderCubit = PreOrderCubit();
        return preOrderCubit;
      },
      lazy: false,
      child: _PreOrderView(),
    );
  }
}

class _PreOrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: BlocProvider.of<PreOrderCubit>(context),
      builder: (BuildContext context, PreOrderState preOrderState) {
        return Stack(
          children: [
            Scaffold(
              body: _PreOrderBody(),
            ),
            if (preOrderState.status == PreOrderStatus.busy)
              Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
          ],
        );
      },
    );
  }
}

class _PreOrderBody extends StatefulWidget {
  @override
  _PreOrderBodyState createState() => _PreOrderBodyState();
}

class _PreOrderBodyState extends State<_PreOrderBody> {
  final _formKey = GlobalKey<FormState>();
  PreOrderCubit preOrderCubit;

  @override
  void initState() {
    super.initState();
    preOrderCubit = BlocProvider.of<PreOrderCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Параметры заказа',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'URL фото',
                  helperText: '',
                ),
                initialValue: preOrderCubit.state.photoUrl,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.url,
                onSaved: (value) {
                  // final newUser = preOrderCubit.state.user.copyWith(email: value);
                  // preOrderCubit.updateUser(newUser);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => preOrderCubit.validateUrl(value),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Количество позиций',
                  helperText: '',
                ),
                initialValue: '${preOrderCubit.state.positionCount}',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  // final newUser = preOrderCubit.state.user.copyWith(phone: value);
                  // preOrderCubit.updateUser(newUser);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => preOrderCubit.validateCount(value),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    // final result = await preOrderCubit.preOrder();
                    // if (result) {
                    // }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Перейти к заказу'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
