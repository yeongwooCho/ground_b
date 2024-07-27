enum MainMaterialStatus {
  denim('데님'),
  velvet('벨벳'),
  chiffon('쉬폰'),
  silk('실크'),
  wool('울'),
  linen('리넨'),
  leather('레자'),
  cashmere('캐시미어'),
  etc('기타');

  const MainMaterialStatus(this.label);

  final String label;
}
