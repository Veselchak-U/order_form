import 'dart:async';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

part 'pre_order.g.dart';

class PreOrderCubit extends Cubit<PreOrderState> {
  PreOrderCubit() : super(const PreOrderState());

  String validateUrl(String value) {
    final uri = Uri.tryParse(value);
    if (uri != null && _isValidUri(uri)) {
      emit(state.copyWith(photoUrl: uri.toString()));
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

  void tryCacheImageFile() async {
    final stream = DefaultCacheManager().getImageFile(
      state.photoUrl,
      withProgress: true,
    );
    StreamSubscription<FileResponse> subscription;
    subscription = stream.listen(
      (FileResponse response) {
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
        Future.delayed(Duration(seconds: 2),
            () => emit(state.copyWith(status: PreOrderStatus.invalid)));
      },
      cancelOnError: true,
    );
  }

  void resetStatus() {
    emit(state.copyWith(status: PreOrderStatus.invalid));
  }

  // Simple check URL
  bool _isValidUri(Uri uri) {
    bool result = false;
    try {
      final origin = uri.origin;
      if (origin.length > 11) {
        result = true;
      }
    } on dynamic {
      result = false;
    }
    return result;
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
