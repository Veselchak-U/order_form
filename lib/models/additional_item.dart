class AdditionalItemModel {
  const AdditionalItemModel({
    this.id,
    this.displayName,
    this.photoUrl,
    this.count,
    this.price,
  });

  final String id;
  final String displayName;
  final String photoUrl;
  final int count; // количество
  final int price; // цена за единицу в копейках
}
