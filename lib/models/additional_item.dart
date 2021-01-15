import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'additional_item.g.dart';

@CopyWith()
class AdditionalItemModel extends Equatable {
  const AdditionalItemModel({
    @required this.id,
    @required this.displayName,
    @required this.photoUrl,
    @required this.price,
    this.count = 0,
  });

  final String id;
  final String displayName;
  final String photoUrl;
  final int price; // цена за единицу в копейках
  final int count; // количество единиц текущей позиции

  @override
  List<Object> get props => [
        id,
        displayName,
        photoUrl,
        count,
        price,
      ];
}
