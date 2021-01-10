import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pre_order.g.dart';

class PreOrderCubit extends Cubit<PreOrderState> {
  PreOrderCubit() : super(const PreOrderState());

  String validateUrl(String value) {
    final uri = Uri.tryParse(value);
    if (uri == null || !_isValidUri(uri)) {
      return 'Введите корректный URL';
    } else {
      emit(state.copyWith(photoUrl: uri.toString()));
      return null;
    }
  }

  String validateCount(String value) {
    final count = int.tryParse(value);
    if (count == null || count < 3 || count > 5) {
      return 'Введите целое число от 3 до 5';
    } else {
      emit(state.copyWith(positionCount: count));
      return null;
    }
  }

  bool _isValidUri(Uri uri) {
    bool result = false;
    try {
      final origin = uri.origin;
      if (origin.length > 11) {
        result = true;
      }
    } on dynamic {}
    return result;
  }
}

enum PreOrderStatus { valid, invalid, busy }

@CopyWith()
class PreOrderState extends Equatable {
  const PreOrderState({
    this.status = PreOrderStatus.invalid,
    this.photoUrl = 'https://',
    this.positionCount = 3,
  });

  final PreOrderStatus status;
  final String photoUrl;
  final int positionCount;

  @override
  List<Object> get props => [
        status,
        photoUrl,
        positionCount,
      ];
}
