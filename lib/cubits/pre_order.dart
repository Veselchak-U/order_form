import 'dart:async';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:order_form/common/helper.dart';

part 'pre_order.g.dart';

class PreOrderCubit extends Cubit<PreOrderState> {
  PreOrderCubit() : super(const PreOrderState());

  String validateUrl(String value) {
    final url = urlValidator(value);
    if (url != null) {
      emit(state.copyWith(photoUrl: url));
      return null;
    } else {
      return 'Введите корректный URL';
    }
  }

  String validateCount(String value) {
    final count = int.tryParse(value);
    if (count != null && count >= 3 && count <= 5) {
      emit(state.copyWith(positionCount: count));
      return null;
    } else {
      return 'Введите целое число от 3 до 5';
    }
  }

  Future<void> tryCacheImageFile() async {
    final stream = DefaultCacheManager().getImageFile(
      state.photoUrl,
      withProgress: true,
    );
    StreamSubscription<FileResponse> subscription;
    subscription = stream.listen(
      (response) {
        if (response is DownloadProgress) {
          emit(state.copyWith(
              status: PreOrderStatus.downloading,
              downloadProgress: response.progress));
        }
        if (response is FileInfo) {
          emit(state.copyWith(status: PreOrderStatus.valid));
          subscription.cancel();
        }
      },
      onError: (error) {
        emit(state.copyWith(status: PreOrderStatus.error));
        subscription.cancel();
        Future.delayed(const Duration(seconds: 2),
            () => emit(state.copyWith(status: PreOrderStatus.invalid)));
      },
      cancelOnError: true,
    );
  }

  void resetStatus() {
    emit(state.copyWith(status: PreOrderStatus.invalid));
  }
}

enum PreOrderStatus { invalid, downloading, error, valid }

@CopyWith()
class PreOrderState extends Equatable {
  const PreOrderState({
    this.status = PreOrderStatus.invalid,
    this.photoUrl = 'https://',
    this.positionCount = 3,
    this.downloadProgress = 0.0,
  });

  final PreOrderStatus status;
  final String photoUrl;
  final int positionCount;
  final double downloadProgress;

  @override
  List<Object> get props => [
        status,
        photoUrl,
        positionCount,
        downloadProgress,
      ];
}
