class AdditionalItemModel {
  const AdditionalItemModel({
    this.id,
    this.displayName,
    this.photoUrl,
    this.priceInKopecks,
  });

  final String id;
  final String displayName;
  final String photoUrl;
  final int priceInKopecks; // цена в копейках
}
