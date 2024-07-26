enum ManufacturingCategoryStatus {
  clothing('의류'),
  childCare('육아용품'),
  miscellaneous('잡화'),
  etc('기타'),
  overseas('해외제작');

  const ManufacturingCategoryStatus(this.label);

  final String label;
}