import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'additional_item.g.dart';

@CopyWith()
class AdditionalItemModel extends Equatable {
  const AdditionalItemModel({
    this.id,
    @required this.displayName,
    @required this.photoUrl,
    this.count = 0,
    @required this.price,
  });

  final String id;
  final String displayName;
  final String photoUrl;
  final int count; // количество единиц текущей позиции
  final int price; // цена за единицу в копейках

  @override
  List<Object> get props => [
        id,
        displayName,
        photoUrl,
        count,
        price,
      ];
}
